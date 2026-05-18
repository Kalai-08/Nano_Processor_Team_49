
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Add_Sub is
--  Port ( );
end TB_Add_Sub;

architecture Behavioral of TB_Add_Sub is
component Add_Sub
     Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Ctrl : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Z_out : out STD_LOGIC;
           C_out : out STD_LOGIC
           );
end component;
signal Ctrl,Overflow,c_out,z_out : STD_LOGIC;
signal a,b,s : STD_LOGIC_VECTOR (3 downto 0);
begin
UUT: Add_Sub
    PORT MAP (
         A => a,
         B => b,
         S => s,
         Ctrl =>Ctrl,
         Overflow =>Overflow,
         C_out => c_out,
         Z_out => z_out
    );
    process
            begin 
                --- 240212R - 0b 1110 1010 1001 0101 00
                --- 240308R - 0b 1110 1010 1010 1101 00 
                --- 240216 -  0b 1110 1010 1001 0110 00
                --- 240385X - 0b 1110 1010 1100 0000 01 
                
                Ctrl <='1';
                A <= "1100"; -- -4
                B <= "0001"; -- 1
                wait for 100ns;
                Ctrl <= '0';
                A <= "1001"; -- -7
                B <= "1000"; -- -8
                wait for 100ns;
                Ctrl <= '1';
                A <= "1111"; -- 1
                B <= "1101"; -- -3
                wait for 100ns;
                Ctrl <='0';
                A <= "1111"; -- -1
                B <= "1111"; -- -1
                wait;
            end process;
    

end Behavioral;