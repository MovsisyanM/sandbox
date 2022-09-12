import sys

def move_vm(vms=[], servers=[], vm_locations=[], last_move=False):
    """
    vm: list of vm ids
    server: list of server ids
    """
    assert len(vms) == len(
        servers), "Move failed: Number of vms don't match number of servers"
    assert len(vms) <= 2, "Maximum 2 moves allowed per"

    if len(vms) == 0:
        sys.stdout.write("0" if last_move else "0\n")

    else:
        output = f"{len(vms)}"

        for v, s in zip(vms, servers):
            output += f" {v + 1} {s + 1}"
            vm_locations[v] = s

        sys.stdout.write(output if last_move else output + "\n")

    return vm_locations


def read_config():
    servers = []
    vms = []
    vm_locations = []

    S, V, T = sys.stdin.readline().split(" ")
    S, V, T = int(S), int(V), int(T)

    for s_id in range(S):
        cores, gbs = sys.stdin.readline().split(" ")
        servers.append((int(cores), int(gbs)))

    for vm_id in range(V):
        cores, gbs = sys.stdin.readline().split(" ")
        vms.append((int(cores), int(gbs)))

    for vm_id in range(V):
        vm_locations.append(int(sys.stdin.readline()) - 1)

    return servers, vms, vm_locations, T


def hypothetical_move_vm(vms=[], servers=[], vm_locations=[]):
    """
    Imagines a move scenario without executing the move
    vm: list of vm ids
    server: list of server ids
    """
    _vm_locations = vm_locations.copy()

    for v, s in zip(vms, servers):
        _vm_locations[v] = s

    return _vm_locations


def argmax(arr):
    m = max(arr)
    for index, item in enumerate(arr):
        if item == m:
            return index


def argmin(arr):
    m = min(arr)
    for index, item in enumerate(arr):
        if item == m:
            return index


def main():
    servers, vms, vm_locations, T = read_config()

    S = len(servers)
    V = len(vms)

    # can limit these and keep last u observations, but 1024mb is more than enough for 18 days
    usage_history = [[] for _ in vms]
    server_usage_history = [[] for _ in servers]

    def loss(hypothetical_location, hypothetical_usage, move_cost=0):
        """Given a location and predicted usage data, determine loss"""
        hypothetical_server_usage = [0 for _ in servers]

        for vm_id, cpu_usage in enumerate(hypothetical_usage):
            hypothetical_server_usage[hypothetical_location[vm_id]
                                      ] += int(cpu_usage) * vms[vm_id][0]

        return sum([(hu/1e4)**2 for hu in hypothetical_server_usage]) + move_cost

    i = 0
    while i < T - 1:
        # region Collecting usage history
        usage = sys.stdin.readline().split(" ")[:len(vms)]

        server_ram_usage = [0 for _ in servers]
        server_core_usage = [0 for _ in servers]
        [server_usage_history[s_id].append(0) for s_id in range(S)]

        # for vm_id, cpu_usage in enumerate(usage):
        #     server_usage_history[vm_locations[vm_id]
        #                          ][-1] += int(cpu_usage) * vms[vm_id][0]
        #     server_core_usage[vm_locations[vm_id]] += vms[vm_id][0]
        #     server_ram_usage[vm_locations[vm_id]] += vms[vm_id][1]
        #     usage_history[vm_id].append(int(cpu_usage))
        # endregion Collecting usage history

        # naive prediction
        predicted_usage = [hist[-1] for hist in usage_history]

        # region predicting next usage
        if i > 12:  # skipping to save time
            for vm_id in range(V):
                cyclical_pattern = {}

                # checking for cyclical patterns
                for window in range(2, min(int(i/2), 25)):
                    prev_slide_max = -1
                    prev_slide_min = -1
                    supporting = 0
                    for slide in range(int(len(usage_history[vm_id])/window)):
                        if prev_slide_max == -1:
                            prev_slide_max = argmax(
                                usage_history[vm_id][slide * window:(slide + 1) * window])
                            prev_slide_min = argmin(
                                usage_history[vm_id][slide * window:(slide + 1) * window])
                            continue

                        amax = argmax(
                            usage_history[vm_id][slide * window:(slide + 1) * window])
                        if prev_slide_max <= amax and \
                                prev_slide_max >= amax:
                            supporting += 1
                        else:
                            supporting -= 1

                        amin = argmin(
                            usage_history[vm_id][slide * window:(slide + 1) * window])
                        if prev_slide_min <= amin and \
                                prev_slide_max >= amin:
                            supporting += 1
                        else:
                            supporting -= 1

                        if 1/window ** int((window * supporting)/4) < 0.001:
                            cyclical_pattern[1/window **
                                             int(supporting)] = window

                if cyclical_pattern:
                    most_significant = cyclical_pattern[min(
                        cyclical_pattern.keys())]

                    prev_iters = [obs for c, obs in enumerate(
                        usage_history[vm_id]) if not (c % most_significant)]

                    predicted_usage[vm_id] = prev_iters[-1]
                    if len(prev_iters) >= 2:
                        predicted_usage[vm_id] += prev_iters[-1] - \
                            prev_iters[-2]

        # endregion predicting next usage

        # region best move calculation

        loss_possibilities = {}

        # calculating move losses for 1 move

        for l in range(S):
            for h in range(V):
                if vm_locations[h] == l or \
                        ((server_ram_usage[l] + vms[h][1]) > servers[l][1]) or \
                        ((server_core_usage[l] + vms[h][0]) > servers[l][0]):
                    continue

                this_loss = loss(
                    hypothetical_move_vm([h], [l], vm_locations),
                    predicted_usage,
                    vms[h][1]
                )
                loss_possibilities[this_loss] = ([h], [l])

        # calculating loss for no move
        this_loss = loss(
            vm_locations,
            predicted_usage
        )
        loss_possibilities[this_loss] = ([], [])

        # endregion best move calculation

        # making the best move
        move_vm(
            *loss_possibilities[min(loss_possibilities.keys())],
            vm_locations,
            last_move=(i == T-2)
        )
        i += 1

    return int(not T)


if __name__ == "__main__":
    sys.exit(main())
