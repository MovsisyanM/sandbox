import sys


def main():
    S, V, T = sys.stdin.readline().split(" ")
    S, V, T = int(S), int(V), int(T)

    i = 0
    while i < T-1:
        server_usage = sys.stdin.readline().split(" ")
        sys.stdout.write("0\n" if i != T-2 else "0")
        i += 1


if __name__ == "__main__":
    main()
