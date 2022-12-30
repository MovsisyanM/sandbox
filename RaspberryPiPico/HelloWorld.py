import machine
import utime

# region Morse translation

ENGLISH_TO_MORSE = {'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.', 'G': '--.', 'H': '....',
                    'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---', 'P': '.--.',
                    'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
                    'Y': '-.--', 'Z': '--..', '0': '-----', '1': '.----', '2': '..---', '3': '...--', '4': '....-',
                    '5': '.....', '6': '-....', '7': '--...', '8': '---..', '9': '----.'}


MORSE_TO_ENGLISH = {}
for key, value in ENGLISH_TO_MORSE.items():
    MORSE_TO_ENGLISH[value] = key


def english_to_morse(message):
    morse = []  # Will contain Morse versions of letters
    for char in message:
        if char in ENGLISH_TO_MORSE:
            morse.append(ENGLISH_TO_MORSE[char])
    return " ".join(morse)


def morse_to_english(message):
    message = message.split(" ")
    english = []  # Will contain English versions of letters
    for code in message:
        if code in MORSE_TO_ENGLISH:
            english.append(MORSE_TO_ENGLISH[code])
    return " ".join(english)

# endregion Morse translation

# region Hello world

led_pin = machine.Pin(25, machine.Pin.OUT)
morse_message = english_to_morse("Hello Mher")

for _ in range(2 ** 8):
    for c in morse_message:
        if c == " ":
            led_pin.value(0)
            utime.sleep(0.5)
        elif c == ".":
            led_pin.value(1)
            utime.sleep(0.13)
            led_pin.value(0)
        else:
            led_pin.value(1)
            utime.sleep(0.27)
            led_pin.value(0)

# endregion Hello world

