from setuptools import setup, find_packages

setup(
    name='darkig',
    version='1.0.5',
    author='KitsuneXploit',
    author_email='admin@kitsunexploit.com',
    description='Python based tools for hacking instagram accounts',
    long_description='Dark-IG is a python based tools for hacking instagram accounts using brute force and dictionary attacks with private api from latest apk pinning',
    url='https://github.com/rezadkim/darkig',
    packages=find_packages(),
    include_package_data=True,
    package_data={'rezadkim': ['darkig']},
    install_requires=['rich','beaupy','glickey','ihackit','requests','prompt_toolkit'],
    entry_points={
        'console_scripts': [
            'darkig = rezadkim.main:main',
        ],
    },
    classifiers=[
         'Programming Language :: Python :: 3',
         'License :: OSI Approved :: MIT License',
         'Operating System :: OS Independent',
     ],
     python_requires='>=3.10,<3.11'
)
