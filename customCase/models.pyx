# # cython: profile=True

import typing


cdef class Token:
    
    def __init__(self, str name, str address) -> None:
        self.name = name
        self.address = address

    def __repr__(self) -> str:
        return f'Token({self.name})'

    def __hash__(self) -> int:
        return hash((self.name, self.address.lower()))

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Token) and self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Token) and self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Token) and self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Token) and self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Token) and self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __ge__(self, other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.addesss.lower() >= (<Token>other).address.lower()

    @property
    def fullJoin(self) -> str:
        return f'{self.name}_{self.address}'

    @classmethod
    def fromDict(cls, load) -> Token:
        assert type(load.get('name')) == str
        assert type(load.get('address')) == str

        return cls(
            load.get('name'),
            load.get('address')
        )

    def toDict(self) -> dict:
        return {
            'name': self.name,
            'address': self.address
        }

cdef class Via:

    def __init__(self, str name, str pair, float fee, str router) -> None:
        self.name = name
        self.pair = pair
        self.fee = fee
        self.router = router

    def __repr__(self) -> str:
        return f'via({self.name} {self.pair})'

    @classmethod
    def fromDict(cls, load) -> Via:
        assert type(load.get('name')) == str
        assert type(load.get('pair')) == str
        assert type(load.get('fee')) == float
        assert type(load.get('router')) == str

        return cls(
            load.get('name'),
            load.get('pair'),
            load.get('fee'),
            load.get('router')
        )

    def toDict(self) -> dict:
        return {
            'name': self.name,
            'pair': self.pair,
            'fee': self.fee,
            'router': self.router
        }

cdef class Swap:
    
    def __init__(self, Token fro, Token to, Via via) -> None:
        self.fro = fro
        self.to = to
        self.via = via

    def __repr__(self):
        return f'{self.fro} {self.to} {self.via.name}'

    @classmethod
    def fromDict(cls, dict load) -> Swap:
        assert type(load.get('fro')) == dict
        assert type(load.get('to')) == dict
        assert type(load.get('via')) == dict

        return cls(
            Token.fromDict(load.get('fro')),
            Token.fromDict(load.get('to')),
            Via.fromDict(load.get('via'))
        )

    def toDict(self) -> dict:
        return {
            'fro': self.fro.toDict(),
            'to': self.to.toDict(),
            'via': self.via.toDict()
        }


cdef class Route:
    
    def __init__(self, list swaps,
                 long UsdValue, long EP,
                 long index, long capital) -> None:

        self.swaps = swaps
        self.UsdValue = UsdValue
        self.EP = EP
        self.index = index
        self.capital = capital

    def toDict(self) -> dict:
    
        cdef list swapList = []
        cdef Swap s

        for s in self.swaps:
            swapList.append(s.toDict())

        return {
            'swaps': swapList,
            'UsdValue': self.UsdValue,
            'EP': self.EP,
            'index': self.index,
            'capital': self.capital
            }

    @classmethod
    def fromDict(cls, dict load) -> Route:

        assert type(load.get('swaps')) == list
        assert type(load.get('UsdValue')) == float
        assert type(load.get('EP')) == long
        assert type(load.get('index')) == long
        assert type(load.get('capital')) == long

        cdef list swapList = []
        cdef dict s

        for s in load.get('swaps'):
            swapList.append(Swap.fromDict(s))

        return cls(
            swapList,
            load.get('UsdValue'),
            load.get('EP'),
            load.get('index'),
            load.get('capital')
        )

    def __repr__(self) -> str:
        return f'{self.swaps}'

    def __eq__(self, Route other) -> bool:
        return isinstance(other, Route) and self.swaps == (<Route>other).swaps

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Route) and self.swaps == (<Route>other).swaps

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Route) and self.swaps == (<Route>other).swaps

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Route) and self.swaps == (<Route>other).swaps

    def __eq__(self, Token other) -> bool:
        return isinstance(other, Route) and self.swaps == (<Route>other).swaps

    def __ge__(self, other) -> bool:
        if not isinstance(other, Route):
            return NotImplemented
        return self.UsdValue >= (<Route>other).UsdValue


cdef class Spliter:

    def __init__(self, list items,
                 int start, int gap) -> None:

        self.items = items
        self.start = start
        self.end  = self.start + gap

    def __iter__(self) -> 'Spliter':
        return self

    def __next__(self) -> list[Route]:
        if self.start < len(self.items):
            start = self.start
            gap = self.end - self.start
            self.start += gap
            self.end = self.start + gap * 2
            return self.items[start:start + gap]
        else:
            raise StopIteration


class BaseBlockchain(typing.Protocol):

    url: str = ''
    exchanges: dict = {}

    @property
    def arbAddress(self) -> str:
        return ''

    async def genRoutes(self, value: float,
                        routes: list = [],
                        **kwargs: dict) -> typing.AsyncGenerator:

        pass


cdef calculate(dict cache, Route route):
    pass

def test(dict cache, Route route):
    ril = cache.get('riller')
    drill = cache.get('driller')

    route.EP = 0
    route.index = 0
    return route

def getProspects(dict cache, list routes):
    cdef Route r
    cdef float UsdValue
    cdef long EP
    cdef long index
    cdef long capital

    for r in routes:
        pass

def generateProspects(dict cache, list routes):
    cdef Route r
