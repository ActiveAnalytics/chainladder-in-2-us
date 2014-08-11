Chain Ladder in less than 2 microseconds
===================

This repository contains the code from an Active Analytics blog entry for calculating the Chain Ladder function in less than 2 microseconds.

## The Files

The files contained in the repostory are:

1. speed-cl.c contains the functions for calculating the age-to-age factors and the chain ladder
2. traingle.jl function contains the functions for calling the C chain ladder function and carrying out the bechmark

## Compilation

1. Compile the c-code:

$ gcc speed-cl.c -shared -o speed-cl.so -fPIC

2. In the chain ladder function, the code:


```
ccall((:get_factor, "speed-cl"), Void, (Ptr{Float64}, Ptr{Float64}, Int32), pointer(tri), pointer(fact), p)
ccall((:cl, "speed-cl"), Void, (Ptr{Float64}, Ptr{Float64}, Int32), pointer(tri), pointer(fact), p)
```

the "speed-cl" needs to be the path to the linked library.

## Usage

```
# The auto paid data from the ChainLadder package
julia> x = [101125. 209921 266618 305107 327850 340669 348430 351193 353353 353584
       102541 203213 260677 303182 328932 340948 347333 349813 350523     NaN
       114932 227704 298120 345542 367760 377999 383611 385224     NaN     NaN
       114452 227761 301072 340669 359979 369248 373325     NaN     NaN     NaN
       115597 243611 315215 354490 372376 382738     NaN     NaN     NaN     NaN
       127760 259416 326975 365780 386725     NaN     NaN     NaN     NaN     NaN
       135616 262294 327086 367357     NaN     NaN     NaN     NaN     NaN     NaN
       127177 244249 317972     NaN     NaN     NaN     NaN     NaN     NaN     NaN
       128631 246803     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN
       126288     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN];


julia> chain_ladder(x)
10x10 Array{Float64,2}:
 101125.0  209921.0  266618.0  305107.0  327850.0  340669.0  348430.0  351193.0  353353.0  353584.0
 102541.0  203213.0  260677.0  303182.0  328932.0  340948.0  347333.0  349813.0  350523.0  350752.0
 114932.0  227704.0  298120.0  345542.0  367760.0  377999.0  383611.0  385224.0  386801.0  387054.0
 114452.0  227761.0  301072.0  340669.0  359979.0  369248.0  373325.0  375696.0  377234.0  377481.0
 115597.0  243611.0  315215.0  354490.0  372376.0  382738.0  389122.0  391594.0  393197.0  393454.0
 127760.0  259416.0  326975.0  365780.0  386725.0  398767.0  405418.0  407994.0  409664.0  409932.0
 135616.0  262294.0  327086.0  367357.0  390851.0  403021.0  409744.0  412346.0  414035.0  414305.0
 127177.0  244249.0  317972.0  361420.0  384534.0  396507.0  403121.0  405682.0  407343.0  407609.0
 128631.0  246803.0  317180.0  360519.0  383575.0  395519.0  402117.0  404671.0  406328.0  406593.0
 126288.0  251312.0  322974.0  367105.0  390583.0  402745.0  409463.0  412064.0  413751.0  414021.0
 

julia> bench(1000)

1x6 DataFrame:
          min    lq median      uq   max neval
[1,]    1.586 1.604  1.614 1.68475 8.172  1000
```
