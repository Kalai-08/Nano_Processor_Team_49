library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OurProcessor is
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC; 
          Reg : out STD_LOGIC_VECTOR (3 downto 0);
          Zero : out STD_LOGIC;
          Overflow : out STD_LOGIC;  
          Display : out STD_LOGIC_VECTOR (6 downto 0);
          Anode: out STD_LOGIC_VECTOR (3 downto 0);
          Carry: out STD_LOGIC );
end OurProcessor;

architecture Behavioral of OurProcessor is

component NanoProcessor
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC; 
          Reg : out STD_LOGIC_VECTOR (3 downto 0);
          Zero : out STD_LOGIC;
          Overflow : out STD_LOGIC;
          Display : out STD_LOGIC_VECTOR (6 downto 0);
          Anode: out STD_LOGIC_VECTOR (3 downto 0);
          Carry: out STD_LOGIC );
end component;

signal R: STD_LOGIC_VECTOR (3 downto 0);

begin

Processor43 : NanoProcessor
    Port map (
        Clk => Clk,
        Reset => Reset,
        Reg => R,
        Zero => Zero,
        Overflow => Overflow,
        Display => Display,
        Anode => Anode,
        Carry => Carry
    );
Reg <= R;

end Behavioral;
