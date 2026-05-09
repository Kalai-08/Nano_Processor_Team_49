
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_4bit is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Register_4bit;

architecture Behavioral of Register_4bit is

begin
    process (Clk,Reset) 
    begin
        if Reset = '1' then
            Q <= "0000";
        elsif (rising_edge(Clk)) then
            if En = '1' then
                Q <= D;
            end if;
        end if;
    end process;

end Behavioral;
