import os
import sys
import marshal, gzip, lzma, binascii

def main():
    try:
        # Cari path ke direktori paket 'rezadkim'
        package_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Path ke darkig.py (berisi kode terenkripsi)
        darkig_script = os.path.join(package_dir, "darkig.py")
        
        # Pastikan file darkig.py ada
        if not os.path.exists(darkig_script):
            print(f"Error: File '{darkig_script}' not found.")
            sys.exit(1)
        
        # Baca kode terenkripsi dari file
        with open(darkig_script, "rb") as f:
            encrypted_code = f.read()
        
        # Dekripsi kode
        try:
            # Langkah 1: Unhexlify (jika menggunakan binascii.hexlify)
            compressed_code = binascii.unhexlify(encrypted_code)
            
            # Langkah 2: Decompress (jika menggunakan gzip)
            bytecode = gzip.decompress(compressed_code)
            
            # Langkah 3: Load bytecode menggunakan marshal
            code = marshal.loads(bytecode)
            
            # Langkah 4: Eksekusi kode
            exec(code)
        except Exception as e:
            print(f"Error decrypting or executing code: {e}")
            sys.exit(1)
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
