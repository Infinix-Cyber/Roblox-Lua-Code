# FE Toolkit - keygen
# by Infinix-Cyber / local maze
# usage: python keygen.py

import hashlib

def gen(key, hwid):
    s = (key + hwid).strip()
    return hashlib.sha256(s.encode('utf-8')).hexdigest()

def main():
    print("=== FE Toolkit KeyGen ===")
    while True:
        print()
        key = input("secret key (empty = exit): ").strip()
        if not key:
            break
        hwid = input("user HWID: ").strip()
        if not hwid:
            print("hwid empty, skip")
            continue
        h = gen(key, hwid)
        print()
        print("hash  ->", h)
        print("add this line to data/keys.txt")
        print()

if __name__ == "__main__":
    try:
        main()
    except (KeyboardInterrupt, EOFError):
        print("\nbye")
