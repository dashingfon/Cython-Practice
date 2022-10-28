from hello import say_hello_to
from fib import fib
from primes import primes
import time
from models import Route


def timer(func):
    def inner(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        end = time.perf_counter()
        print(f'took {end - start} seconds to run {func}')
        return result
    return inner

@timer
def _hello(name: str):
    say_hello_to(name)


@timer
def _fib(num: int):
    fib(num)


@timer
def _primes(num: int):
    print(primes(num))

cache = {
    '': [],
    '': []
}
getRoutes = lambda v: v==1

routes = []


@timer
def main():
    routeDict1 = {
        'swaps': [
            {
                'fro': {'name': 'WBNB',
                        'address': '0x373645636'},
                'to': {'name': 'ETH',
                        'address': '0x36262563'}, 
                'via': {'name': 'srivas',
                        'pair': '0x37263525363',
                        'fee': 0.996,
                        'router': '0x45255536453'}
            },
            {
                'fro': {'name': 'ETH',
                        'address': '0x36262563'},
                'to': {'name': 'WBNB',
                        'address': '0x373645636'},
                'via': {'name': 'tempos',
                        'pair': '0x46354663',
                        'fee': 0.995,
                        'router': '0x73645363'}
            }
        ],
        'UsdValue': 0.,
        'EP': 0,
        'index': 0.,
        'capital': 0
    }
    routeDict2 = {
        'swaps': [
            {
                'fro': {'name': 'WBNB',
                        'address': '0x373645636'},
                'to': {'name': 'ETH',
                        'address': '0x36262563'}, 
                'via': {'name': 'crivas',
                        'pair': '0x37263525363',
                        'fee': 0.996,
                        'router': '0x45255536453'}
            },
            {
                'fro': {'name': 'ETH',
                        'address': '0x36262563'},
                'to': {'name': 'USDC',
                        'address': '0x373645636'},
                'via': {'name': 'servic',
                        'pair': '0x46354663',
                        'fee': 0.995,
                        'router': '0x73645363'}
            },
            {
                'fro': {'name': 'USDC',
                        'address': '0x36262563'},
                'to': {'name': 'WBNB',
                        'address': '0x373645636'},
                'via': {'name': 'tempos',
                        'pair': '0x46354663',
                        'fee': 0.995,
                        'router': '0x73645363'}
            }
        ],
        'UsdValue': 0.,
        'EP': 0,
        'index': 0.,
        'capital': 0
    }
    route = Route.fromDict(routeDict1)
    route1 = Route.fromDict(routeDict2)
    route1.UsdValue = 9
    print(route == route1)
    print(route1.UsdValue)

if __name__ == '__main__':
    '''_hello('mfon')

    _fib(300000)
    _primes(100000)'''
    main()
