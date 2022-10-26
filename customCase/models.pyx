# cython: profile=True

import typing


cdef class Token:
    
    def __init__(self, str name, str address) -> None:
        self.name = name
        self.address = address

    def __repr__(self) -> str:
        return f'{self.name}'

    def __hash__(self) -> int:
        return hash((self.name, self.address.lower()))

    def __eq__(self, Token other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.name == (<Token>other).name and self.address == (<Token>other).addesss

    def __ne__(self, Token other) -> bool:
        if self.__eq__(other) is NotImplemented:
            return NotImplemented
        return not self.__eq__(other)

    def __lt__(self, Token other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.addesss.lower() < other.address.lower()
        
    def __le__(self, Token other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.addesss.lower() <= other.address.lower()

    def __gt__(self, Token other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.addesss.lower() > other.address.lower()

    def __ge__(self, Token other) -> bool:
        if not isinstance(other, Token):
            return NotImplemented
        return self.addesss.lower() >= other.address.lower()

    @property
    def fullJoin(self) -> str:
        return f'{self.name}_{self.address}'

    @classmethod
    def fromDict(cls, dict load) -> Token:

        return cls(
            name=load.get('name'),
            address=load.get('address')
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
    def fromDict(cls, dict load) -> Via:

        return cls(
            name=load.get('name'),
            pair=load.get('pair'),
            fee=load.get('fee'),
            router=load.get('router')
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

        return cls(
            fro=Token.fromDict(load.get('fro')),
            to=Token.fromDict(load.get('to')),
            via=Via.fromDict(load.get('via'))
        )

    def toDict(self) -> dict:
        return {
            'fro': self.fro.toDict(),
            'to': self.to.toDict(),
            'via': self.via.toDict()
        }


cdef class Route:
    
    def __init__(self, list swaps,
                 float UsdValue, int EP,
                 float index, int capital) -> None:

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
        if not isinstance(other, Route):
            return NotImplemented
        return self.swaps == other.swaps

    def __ne__(self, Route other) -> bool:
        if self.__eq__(other) is NotImplemented:
            return NotImplemented
        return not self.__eq__(other)

    def __lt__(self, Route other) -> bool:
        if not isinstance(other, Route):
            return NotImplemented
        return self.UsdValue * self.EP < other.UsdValue * other.EP

    def __le__(self, Route other) -> bool:
        if not isinstance(other, Route):
            return NotImplemented
        return self.UsdValue * self.EP <= other.UsdValue * other.EP

    def __gt__(self, Route other) -> bool:
        if not isinstance(other, Route):
            return NotImplemented
        return self.UsdValue * self.EP > other.UsdValue * other.EP
        
    def __ge__(self, Route other) -> bool:
        if not isinstance(other, Route):
            return NotImplemented
        return self.UsdValue * self.EP >= other.UsdValue * other.EP

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
