
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Register_Bank is
--  Port ( );
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is

component Register_Bank
    PORT ( Clk : in STD_LOGIC;
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
           I : in STD_LOGIC_VECTOR (2 downto 0)    
    );

end component;

signal I : STD_LOGIC_VECTOR (2 downto 0);
signal Clk : STD_LOGIC := '0';
signal Reset : STD_LOGIC := '1';
signal D : STD_LOGIC_VECTOR (3 downto 0);
signal R0,R1,R2,R3,R4,R5,R6,R7 : STD_LOGIC_VECTOR (3 downto 0);

begin

UUT : Register_Bank 
    PORT MAP(
            Clk => Clk,
            Reset => Reset,
            D => D,
            R0 => R0,
            R1 => R1,
            R2 => R2,
            R3 => R3,
            R4 => R4,
            R5 => R5,
            R6 => R6,
            R7 => R7,
            I => I     
    );

process
begin
    wait for 50ns;
    Clk <= NOT(Clk);
end process;

process 
begin
    wait for 10ns;
    Reset <= NOT(Reset);
    wait;

end process;

    --- 240212R - 0b 1110 1010 1001 0101 00
    --- 240308R - 0b 1110 1010 1010 1101 00 
    --- 240216 -  0b 1110 1010 1001 0110 00
    --- 240385X - 0b 1110 1010 1100 0000 01 

process
begin
      I <= "001"; --grey code
      D <= "1100";
      wait for 100ns;
      I <= "010";
      D <= "1001";
      wait for 100ns;
      I <= "011";
      D <= "0001";
      wait for 100ns;
      I <= "100";
      D <= "1111";
      wait;

end process;


end Behavioral;
