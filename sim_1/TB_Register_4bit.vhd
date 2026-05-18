

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Register_4bit is
--  Port ( );
end TB_Register_4bit;

architecture Behavioral of TB_Register_4bit is

component Register_4bit
    PORT ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal D : STD_LOGIC_VECTOR (3 downto 0):="0000";
signal En,Clk : STD_LOGIC :='0';
signal Reset : STD_LOGIC :='1';
signal Q : STD_LOGIC_VECTOR (3 downto 0);

begin

UUT: Register_4bit
    PORT MAP (
        D => D,
        En => En,
        Clk => Clk,
        Reset => Reset,
        Q => Q 
    );

process
begin
    wait for 50ns;
    Clk <= NOT(Clk);
end process;

process 
begin
    wait for 20ns;
    Reset <= NOT(Reset);
    Wait for 5ns;
    En <= '1';
    wait;
end process;

   --- 240212R - 0b 1110 1010 1001 0101 00
   --- 240308R - 0b 1110 1010 1010 1101 00 
   --- 240216 -  0b 1110 1010 1001 0110 00
   --- 240385X - 0b 1110 1010 1100 0000 01 
    
process
begin
     D <= "1100";
     wait for 100ns;
     D <= "1001";
     wait for 100ns;
     D <= "0001";
     wait for 100ns;
     D <= "1111";
     wait;

end process;

end Behavioral;
