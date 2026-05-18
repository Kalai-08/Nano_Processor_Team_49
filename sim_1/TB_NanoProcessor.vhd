
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_NanoProcessor is
--  Port ( );
end TB_NanoProcessor;
    
architecture Behavioral of TB_NanoProcessor is
component NanoProcessor
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC; 
          Reg : out STD_LOGIC_VECTOR (3 downto 0);
          Display : out STD_LOGIC_VECTOR (6 downto 0);
          Zero : out STD_LOGIC;
          Overflow : out STD_LOGIC;
          Carry: out STD_LOGIC   );
end component;
Signal Clk,Reset,Zero,Overflow,Carry : STD_LOGIC;
signal Reg : STD_LOGIC_VECTOR (3 downto 0);
signal Display : STD_LOGIC_VECTOR (6 downto 0);

begin
UUT : NanoProcessor
    Port Map (
        Clk => Clk,
        Reset => Reset,
        Reg => Reg,
        Zero => Zero,
        Overflow => Overflow,
        Carry => Carry,
        Display => Display
    );

process
begin
    Clk <= '0';
    wait for 10ns;
    Clk <= '1';
    wait for 10ns;
end process;

process
begin
    Reset <= '0';
    wait for 30ns;
    Reset <= '1';
    wait for 10ns;
    Reset <= '0';
    wait;
end process;
end Behavioral;
