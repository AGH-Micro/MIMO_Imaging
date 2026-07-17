import serial
import numpy as np
import time
import struct

PORT = "COM1"       # zmień na swój port
BAUDRATE = 115200
FS = 18800          # Hz na kanał
BUFFER_SIZE = 256   # musi zgadzać się z firmware
BYTES_PER_SAMPLE = 2  # uint16_t

# połówka bufora to 128 sampli (64 na kanał)
HALF = BUFFER_SIZE // 2
BYTES_PER_PACKET = HALF * BYTES_PER_SAMPLE  # 256 bajtów na pakiet

# zbieramy próbki osobno dla każdego kanału
ch2_samples = []
ch3_samples = []

COLLECT_SECONDS = 1.0  # co ile sekund liczymy FFT
MIN_SAMPLES = int(FS * COLLECT_SECONDS)

def compute_dominant_freq(samples, fs):
    n = len(samples)
    if n < 2:
        return 0.0
    arr = np.array(samples, dtype=np.float32)
    arr -= np.mean(arr)  # usuń DC
    fft_vals = np.abs(np.fft.rfft(arr))
    freqs = np.fft.rfftfreq(n, d=1.0/fs)
    # pomijamy DC (index 0)
    idx = np.argmax(fft_vals[1:]) + 1
    return freqs[idx]

def parse_packet(raw):
    """Rozdziela pakiet na próbki CH2 i CH3 (przeplatane)."""
    count = len(raw) // BYTES_PER_SAMPLE
    samples = struct.unpack(f"<{count}H", raw[:count * BYTES_PER_SAMPLE])
    # dane są przeplatane: CH2, CH3, CH2, CH3...
    ch2 = list(samples[0::2])
    ch3 = list(samples[1::2])
    return ch2, ch3

def main():
    ser = serial.Serial(PORT, BAUDRATE, timeout=2)
    print(f"Nasłuchuję na {PORT} @ {BAUDRATE} baud...")
    print(f"Fs = {FS} Hz na kanał\n")

    raw_buf = b""
    last_print = time.time()

    while True:
        chunk = ser.read(BYTES_PER_PACKET)
        if not chunk:
            continue

        raw_buf += chunk

        # przetwarzaj pełne pakiety
        while len(raw_buf) >= BYTES_PER_PACKET:
            packet = raw_buf[:BYTES_PER_PACKET]
            raw_buf = raw_buf[BYTES_PER_PACKET:]
            c2, c3 = parse_packet(packet)
            ch2_samples.extend(c2)
            ch3_samples.extend(c3)

        # co sekundę printuj dominującą częstotliwość
        now = time.time()
        if now - last_print >= COLLECT_SECONDS:
            if len(ch2_samples) >= MIN_SAMPLES and len(ch3_samples) >= MIN_SAMPLES:
                f2 = compute_dominant_freq(ch2_samples[-MIN_SAMPLES:], FS)
                f3 = compute_dominant_freq(ch3_samples[-MIN_SAMPLES:], FS)
                print(f"CH2: {f2:.1f} Hz  |  CH3: {f3:.1f} Hz")
            else:
                print(f"Zbyt mało próbek... (CH2: {len(ch2_samples)}, CH3: {len(ch3_samples)})")
            last_print = now

if __name__ == "__main__":
    main()
