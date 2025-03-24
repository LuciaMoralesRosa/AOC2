----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:10:07 04/03/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( DA : in  STD_LOGIC_VECTOR (31 downto 0); -- Entrada 1
           DB : in  STD_LOGIC_VECTOR (31 downto 0); -- Entrada 2
           ALUctrl : in  STD_LOGIC_VECTOR (2 downto 0); -- Código de operación
           Dout : out  STD_LOGIC_VECTOR (31 downto 0)); -- Salida
end ALU;

architecture Behavioral of ALU is
signal Dout_internal : STD_LOGIC_VECTOR (31 downto 0);
begin
    process(DA, DB, ALUctrl)
    begin
        case to_integer(unsigned(ALUctrl)) is
            when 0 => Dout_internal <= std_logic_vector(unsigned(DA) + unsigned(DB));
            when 1 => Dout_internal <= std_logic_vector(unsigned(DA) - unsigned(DB));
            when 2 => Dout_internal <= DA AND DB;
            when 3 => Dout_internal <= DA OR DB;
            when others => Dout_internal <= (others => '0');
        end case;
    end process;
    
    Dout <= Dout_internal;
end Behavioral;
