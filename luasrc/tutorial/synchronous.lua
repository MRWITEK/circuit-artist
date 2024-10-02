return {
  name='Synchronous Circuits',
  text=[[

In this section, you'll see how to use memory to create `synchronous sequential` circuits.

`Sequential` as in, calculations and memory updates are always done in sequence: first you updated the memory, then you perform calculations, then you update the memory again, and so on.
!img:imgs/tutorial/sync4.png
`Synchronous` as in, every bit storage you have is updated once and at the `same time` for each `enable` cycle. We use a special bit to perform this sycnrhonization, which we call `CLOCK` bit.  Whenever it goes up, the memories are updated (with the current input `D` value, which come from calculations from previous cycle) and it is only updated again when it goes to 0 and back to 1. This form what we call a `clock cycle`. We can see that the actual "sequential" property of our system is tightly linked with the cycles of the clock: each cycle defines one "update->compute" step in our sequence .
!img:imgs/tutorial/sync2.png
You can structure synchronous circuits in 2 major subcircuits: (i) the `combinatorial` subcircuit and (ii) the `memory` subcircuit:
!img:imgs/tutorial/sync1.png
The role of the `memory` subcircuit is to store and update the memory of the system. It's very similar to a big D flip flop but instead of a single bit, it stores multiple bits `S`, and the output is just a stored version of the input `S`.

The role of the `combinatorial` subcircuit is to take the previous state `S_prv` as input, as well as some external input bits `Din` and generate both the bits corresponding to the next desired state `S_nxt` and the outputs of the system `Dout`. In this subcircuit there's no memory or "loops", just straight logic computation.

This way, once you're designing a sequential circuit, you can separate the logic from the storage and think in terms of: (i) what should the memory look like? (ii) how can I use the current memory (and inputs) to generate the next state of the memory (and outputs)?

`EXAMPLE`: Let's design a circuit with 1 bit input `A` and that outputs the bit `Y` that appeared 2 clock cycles ago. The circuit should look like:

1. CC=0 A=A0 --> Y=n/a
2. CC=1 A=A1 --> Y=n/a
3. CC=2 A=A2 --> Y=A0
4. CC=3 A=A3 --> Y=A1

We would need 2 bits for the memory: one `S0` for storing the current bit and one `S1` for the bit one clock ago. At the current clock cycle, you want to output the bit that appeared 1-clock "ago" from the last clock cycle, ie, the `S1` that you have as input. The updates then would look like the following:

- `S0_nxt = Din`
- `S1_nxt = S0_prv`
- `Dout = S1_prv`

And the circuit would look something like that:
!img:imgs/tutorial/sync3.png

]]
}
