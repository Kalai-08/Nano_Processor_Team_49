Our instruction has totally 12 bits

I(11 downto 10) = OpCode
I(9 downto 7)   = RegA
I(6 downto 4)   = RegB
I(3 downto 0)   = Immediate value / Address

For Jump instruction:
I(2 downto 0) = Address


Our instructions are -

ADD      00 with Imm not 1111 or 1110  (Addition)
ABS DIFF 00 with Imm = 1111            (Absolute Difference)
MUL      00 with Imm = 1110            (Multiplication)
SUB/NEG  01                            (Subtraction / Negation)
MOVI     10                            (Move Immediate)
JZR      11                            (Jump if Zero)


Special control signals:

Abs_Diff = 1 when OpCode = 00 and Imm = 1111
Multiply = 1 when OpCode = 00 and Imm = 1110
Add_Sub  = 1 when OpCode = 01
Load_Select = 1 when OpCode = 10
Jump_Flag = 1 when OpCode = 11 and selected register value is 0000


Register Codes -

R0 = 000
R1 = 001
R2 = 010
R3 = 011
R4 = 100
R5 = 101
R6 = 110
R7 = 111