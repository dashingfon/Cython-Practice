class dre:
    def __init__(self, num):
        self.num = num

    def __repr__(self):
        return f'dre num is ({self.num})'
r = dre(5)
print(str(r))
t = {'r': r}
print(t)
print(str(t))
