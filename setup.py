from setuptools import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize("hello\\hello.pyx", annotate=True),
)
