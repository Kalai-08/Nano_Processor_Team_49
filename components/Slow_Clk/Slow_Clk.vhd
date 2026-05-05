library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end Slow_Clk;

architecture Behavioral of Slow_Clk is
constant MAX_COUNT : integer := 50000000;
SIGNAL count : integer range 1 to MAX_COUNT := 1;
SIGNAL clk_status : std_logic :='0';

begin
   process (Clk_in) begin
      if (rising_edge(Clk_in)) then
         if (count = MAX_COUNT) then
             clk_status <= not (clk_status);
             count <= 1;
         else
             count <= count + 1;
         end if;
      end if;
   end process;

   Clk_out <= clk_status;
end Behavioral;
