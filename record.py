"""PyAudio example: Record a few seconds of audio and save to a WAVE file."""

import pyaudio
import wave
import os
import sys


def record_sound(filename):
    CHUNK = 1024
    # FORMAT = pyaudio.paInt16
    FORMAT = pyaudio.paUInt8
    CHANNELS = 2
    RATE = 44100
    RECORD_SECONDS = 3
    WAVE_OUTPUT_FILENAME = filename

    p = pyaudio.PyAudio()

    stream = p.open(format=FORMAT,
                    channels=CHANNELS,
                    rate=RATE,
                    input=True,
                    frames_per_buffer=CHUNK)

    print("* recording")

    frames = []

    for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
        data = stream.read(CHUNK)
        frames.append(data)

    # print(int.from_bytes(frames[0],byteorder='little'))

    stream.stop_stream()
    stream.close()
    p.terminate()



    wf = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
    wf.setnchannels(CHANNELS)
    wf.setsampwidth(p.get_sample_size(FORMAT))
    wf.setframerate(RATE)
    wf.writeframes(b''.join(frames))
    wf.close()


if __name__ == "__main__":
    head = os.getcwd()

    while True:
        name = str(input("Name: "))

        cmd = 'mkdir ' + name
        os.system(cmd)

        os.chdir(name + '/')

        print('Say: HELLO')
        file1 = name + "1.wav"
        record_sound(file1)

        print('Say: BUG')
        file2 = name + "2.wav"
        record_sound(file2)

        print('Say: COW')
        file3 = name + "3.wav"
        record_sound(file3)

        print('Say: HOME')
        file4 = name + "4.wav"
        record_sound(file4)

        print('Say: SURE')
        file5 = name + "5.wav"
        record_sound(file5)

        print('Say: SUN')
        file6 = name + "6.wav"
        record_sound(file6)

        print('Say: Turkey')
        file7 = name + "7.wav"
        record_sound(file7)

        print('Say: PUMPKIN')
        file8 = name + "8.wav"
        record_sound(file8)

        print('Say: MAPLE')
        file9 = name + "9.wav"
        record_sound(file9)

        os.chdir(head)
