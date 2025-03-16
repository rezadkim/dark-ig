#ay
import os
import sys
import subprocess
import pkg_resources

def main():
    try:
        # Cari path ke direktori paket 'rezadkim'
        package_dir = os.path.dirname(pkg_resources.resource_filename('rezadkim', '__init__.py'))
        
        # Path ke darkig.py (berada di direktori root dark-ig/)
        darkig_script = os.path.join(os.path.dirname(package_dir), 'darkig.py')
        
        # Debug: Cetak path yang digunakan
        print(f"Looking for darkig.py at: {darkig_script}")
        
        # Pastikan file darkig.py ada
        if not os.path.exists(darkig_script):
            print(f"Error: File '{darkig_script}' not found.")
            sys.exit(1)
        
        # Jalankan darkig.py menggunakan Python
        sys.exit(subprocess.call([sys.executable, darkig_script] + sys.argv[1:]))
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
