
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor is
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC; 
          Reg : out STD_LOGIC_VECTOR (3 downto 0);
          Zero : out STD_LOGIC;
          Overflow : out STD_LOGIC;  
          Display : out STD_LOGIC_VECTOR (6 downto 0);
          Anode: out STD_LOGIC_VECTOR (3 downto 0);
          Carry: out STD_LOGIC  );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

component LUT_16_7
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component Slow_Clk
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

component Add_Sub
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Ctrl : in STD_LOGIC;
           C_out : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Z_out : out STD_LOGIC
           );
end component;

component Register_Bank 
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0);
           I : in STD_LOGIC_VECTOR (2 downto 0));
end component;

component Adder_3bit
    Port ( 
            A : in STD_LOGIC_VECTOR (2 downto 0);
            S: out STD_LOGIC_VECTOR (2 downto 0);
            C_out : out STD_LOGIC
            );
end component;

component PC
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Instruction_Decoder
    Port ( I : in STD_LOGIC_VECTOR (11 downto 0);
           Reg_Check_Jump : in STD_LOGIC_VECTOR (3 downto 0);
           Load_Select : out STD_LOGIC;
           Imm_Value : out STD_LOGIC_VECTOR (3 downto 0);
           Reg_Enable : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_Select_1 : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_Select_2 : out STD_LOGIC_VECTOR (2 downto 0);
           Add_Sub : out STD_LOGIC;
           Jump_Flag : out STD_LOGIC;
           Address : out STD_LOGIC_VECTOR (2 downto 0)
           );
end component;

component Mux_2_to_1_3bit
    Port ( Sel : in STD_LOGIC;
           D0 : in STD_LOGIC_VECTOR (2 downto 0);
           D1 : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Mux_2_to_1_4bit
    Port ( S : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           X : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Mux_8_to_1_4bit
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           A0 : in STD_LOGIC_VECTOR (3 downto 0);
           A1 : in STD_LOGIC_VECTOR (3 downto 0);
           A2 : in STD_LOGIC_VECTOR (3 downto 0);
           A3 : in STD_LOGIC_VECTOR (3 downto 0);
           A4 : in STD_LOGIC_VECTOR (3 downto 0);
           A5 : in STD_LOGIC_VECTOR (3 downto 0);
           A6 : in STD_LOGIC_VECTOR (3 downto 0);
           A7 : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Program_ROM
    Port ( Mem_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Ins_Bus : out STD_LOGIC_VECTOR (11 downto 0));
end component;
 
signal Load_Select,Add_Sub_Selector,Jump_Flag,Overflow_0,Z_out : STD_LOGIC;
signal Ins_Bus : STD_LOGIC_VECTOR (11 downto 0);
signal O,b,Add_Out,Reg_Enable,Reg_Select_1,Reg_Select_2 : STD_LOGIC_VECTOR (2 downto 0);
signal Address : STD_LOGIC_VECTOR (2 downto 0);
signal Imm_Value,R0,R1,R2,R3,R4,R5,R6,R7,S,X,Y1,Y2: STD_LOGIC_VECTOR (3 downto 0);
--signal R: STD_LOGIC_VECTOR (3 downto 0);
signal Clk_out : STD_LOGIC;

begin

SlowClock : Slow_Clk
    Port map (
        Clk_in => Clk,
        Clk_out => Clk_out
    );

LUT :LUT_16_7
    Port map (
        address => R7,
        Data => Display
    );
    
ProgramCounter : PC
    Port Map(
        Clk => Clk_out,
        Reset => Reset,
        D => b,
        O => O
    );

ProgramRom : Program_Rom
    Port Map(
        Ins_Bus => Ins_Bus,
        Mem_Sel => O
    );
InstructionDecoder: Instruction_Decoder
    Port Map(
       I => Ins_Bus,
       Reg_Check_Jump => Y1,
       Load_Select => Load_Select,
       Imm_Value  => Imm_Value,
       Reg_Enable => Reg_Enable,
       Reg_Select_1 => Reg_Select_1,
       Reg_Select_2 => Reg_Select_2,
       Add_Sub => Add_Sub_Selector,
       Jump_Flag => Jump_Flag,
       Address => Address
    );

Mux_2_to_1_4bit_1 : Mux_2_to_1_4bit
    Port Map (
       S => Load_Select,
       A => S,
       B => Imm_Value,
       X => X
    );
Registerbank : Register_Bank
    Port Map (
       Clk => Clk_out,
       Reset => Reset,
       D => X,
       R0 => R0,
       R1 => R1,
       R2 => R2,
       R3 => R3,
       R4 => R4,
       R5 => R5,
       R6 => R6,
       R7 => R7,
       I => Reg_Enable      
    );
Mux_8_to_1_4bit_0 : Mux_8_to_1_4bit
    Port Map (
       S => Reg_Select_1,
       A0 => R0,
       A1 => R1,
       A2 => R2,
       A3 => R3,
       A4 => R4,
       A5 => R5,
       A6 => R6,
       A7 => R7,
       Y => Y1
    );
Mux_8_to_1_4bit_1 : Mux_8_to_1_4bit
    Port Map (
       S => Reg_Select_2,
       A0 => R0,
       A1 => R1,
       A2 => R2,
       A3 => R3,
       A4 => R4,
       A5 => R5,
       A6 => R6,
       A7 => R7,
       Y => Y2  
    ); 
AddSub : Add_Sub
    Port Map (
       A => Y1,
       B => Y2,
       Ctrl => Add_Sub_Selector,
       C_out => Carry,
       S => S,
       Overflow => Overflow_0, 
       Z_out => Z_out
    );
Mux_2_to_1_3bit_0 : Mux_2_to_1_3bit
    Port map (
       Sel => Jump_Flag,
       D0 => Add_Out,
       D1 => Address,
       Y => b
    );
Adder3bit : Adder_3bit
    Port Map( 
       A => O,
       S => Add_Out,
       C_out => open
    );  
Reg <= R7;
Zero <= Z_out;
Overflow <= Overflow_0;
Anode <= "1110";
end Behavioral;
