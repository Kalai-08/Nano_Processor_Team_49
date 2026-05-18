

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Instruction_Decoder is
--  Port ( );
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is
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
signal I : STD_LOGIC_VECTOR (11 downto 0);
signal Reg_Check_Jump : STD_LOGIC_VECTOR (3 downto 0);
signal Load_Select  : STD_LOGIC;
signal Imm_Value : STD_LOGIC_VECTOR (3 downto 0);
signal Reg_Enable :  STD_LOGIC_VECTOR (2 downto 0);
signal Reg_Select_1 :  STD_LOGIC_VECTOR (2 downto 0);
signal Reg_Select_2 : STD_LOGIC_VECTOR (2 downto 0);
signal Add_Sub : STD_LOGIC;
signal Jump_Flag :STD_LOGIC;
signal Address : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT: Instruction_Decoder
    Port Map (
       I => I,
       Reg_Check_Jump => Reg_Check_Jump,
       Load_Select =>  Load_Select,    
       Imm_Value=>  Imm_Value,
       Reg_Enable=>   Reg_Enable,
       Reg_Select_1=> Reg_Select_1,
       Reg_Select_2=> Reg_Select_2,
       Add_Sub=> Add_Sub,
       Jump_Flag=> Jump_Flag,
       Address=> Address
    );

process
begin
Reg_Check_Jump <= "0000";
I <= "100010000001";
wait for 100ns;
I <= "000100110000";
wait for 100ns;
I <= "111110000011";
wait for 100ns;
I <= "010110000000";
wait for 100ns;
end process;

end Behavioral;
