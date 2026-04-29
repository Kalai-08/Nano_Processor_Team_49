----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 11:03:47 PM
-- Design Name: 
-- Module Name: registers - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.logic_components.D_FF;

-- Generic N bit Register
entity Reg is
    generic(
        N : integer
    );
    Port ( D : in std_logic_vector(N-1 downto 0);
           Res: in STD_LOGIC;
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out std_logic_vector(N-1 downto 0));
end Reg;

architecture Behavioral of Reg is

begin

    D_Flip_Flops: for i in 0 to N-1 generate
        D_FF_Inst: D_FF port map(
                D => D(i),
                Res => Res,
                Clk => Clk,
                En => En,
                Q => Q(i)
                ); 
    end generate D_Flip_Flops;
    
end Behavioral;