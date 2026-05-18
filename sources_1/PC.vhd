
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (2 downto 0));
end PC;

architecture Behavioral of PC is
component D_FF
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC
           );
end component;
signal Res_Sig : STD_LOGIC:= '1';
begin
DFF_0 : D_FF
    PORT MAP (
        D => D(0),
        Q => O(0),
        Clk => Clk,
        Res => Res_Sig
    );
DFF_1 : D_FF
    PORT MAP (
        D => D(1),
        Q => O(1),
        Clk => Clk,
        Res => Res_Sig
    );
DFF_2 : D_FF
    PORT MAP (
        D => D(2),
        Q => O(2),
        Clk => Clk,
        Res => Res_Sig
    );
Res_Sig <= Reset;
end Behavioral;
