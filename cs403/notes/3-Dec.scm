Steps for a proof:

1. P -> I
2. <<requires: I>> E <<ensures: I>> : E does not cause a change of state.
3. <<requires: I and E>> S <<ensures: I>>
4. I and ~E -> Q