cdef class Token:
    cdef readonly str name
    cdef readonly str address


cdef class Via:
    cdef readonly str name
    cdef readonly str pair
    cdef readonly float fee
    cdef readonly str router


cdef class Swap:
    cdef readonly Token fro
    cdef readonly Token to
    cdef readonly Via via


cdef class Route:
    cdef public list swaps
    cdef public float UsdValue
    cdef public int EP
    cdef public float index
    cdef public int capital


cdef class Spliter:
    cdef public list items
    cdef public int start
    cdef public int end
    cdef public int gap
