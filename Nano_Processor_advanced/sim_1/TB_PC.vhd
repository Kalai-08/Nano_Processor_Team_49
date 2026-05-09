
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_OurProcessor is
--  Port ( );
end TB_OurProcessor;
architecture Behavioral of TB_OurProcessor is
component OurProcessor
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC; 
          Reg : out STD_LOGIC_VECTOR (3 downto 0);
          Zero : out STD_LOGIC;
          Overflow : out STD_LOGIC;  
          Display : out STD_LOGIC_VECTOR (6 downto 0);
          Anode: out STD_LOGIC_VECTOR (3 downto 0);
          Carry: out STD_LOGIC );
end component;
Signal Clk,Reset,Zero,Overflow,Carry : STD_LOGIC;
signal Reg, Anode : STD_LOGIC_VECTOR (3 downto 0);
signal Display :STD_LOGIC_VECTOR (6 downto 0);
begin
UUT : OurProcessor
    Port Map (
        Clk => Clk,
        Reset => Reset,
        Reg => Reg,
        Zero => Zero,
        Overflow => Overflow,
        Display => Display,
        Anode => Anode,
        Carry => Carry
    );

process
begin
    Clk <= '0';
    wait for 2ns;
    Clk <= '1';
    wait for 2ns;
end process;

process
begin
    Reset <= '1';
    wait for 20ns;
    Reset <= '0';
    wait;
end process;
end Behavioral;
