def gen(num):
    yield 'starting'
    for i in range(num):
        yield i

generator = gen(8)
e = next(generator)
print(e)
for i in generator:
    print(i)
