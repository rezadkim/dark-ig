import os
import sys
import subprocess
import pkg_resources

def main():
    darkige = pkg_resources.resource_filename('rezadkim', 'darkig')
    if not os.access(darkige, os.X_OK): os.chmod(darkige, 0o755)
    sys.exit(subprocess.call([darkige] + sys.argv[1:]))

if __name__ == '__main__':
    main()
