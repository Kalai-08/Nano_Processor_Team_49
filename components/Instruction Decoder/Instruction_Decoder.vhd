library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Decoder is
    Port (
        I : in STD_LOGIC_VECTOR (11 downto 0);  -- 12-bit instruction
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
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

    signal OpCode : STD_LOGIC_VECTOR(1 downto 0);
    signal RegA : STD_LOGIC_VECTOR(2 downto 0);
    signal RegB : STD_LOGIC_VECTOR(2 downto 0);
    signal Imm  : STD_LOGIC_VECTOR(3 downto 0);

begin

    OpCode <= I(11 downto 10);   --used for operations
    RegA <= I(9 downto 7);
    RegB <= I(6 downto 4);
    Imm <= I(3 downto 0);
        
    Reg_Enable <= RegA;
    Imm_Value <= Imm;
    Address <= I(2 downto 0);
       
    Load_Select <= '1' when (OpCode = "10") else '0';
    Add_Sub <= '1' when (OpCode = "01") else '0';
    
    process(OpCode, RegB, RegA)
    begin
        if OpCode = "01" then
            Reg_Select_1 <= "000";
            Reg_Select_2 <= RegA;
        else
            Reg_Select_2 <= RegB;
            Reg_Select_1 <= RegA;
        end if;
    end process;
    
    Jump_Flag <= '1' when (OpCode = "11" and Reg_Check_Jump = "0000") else '0';

end Behavioral;