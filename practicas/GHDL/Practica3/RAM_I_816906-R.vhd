----------------------------------------------------------------------------------
-- Lucia Morales Rosa, 816906@unizar.es
-- Practica 3 - Arquitectura y Organizacion de Computadores 2
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:16 04/08/2014 
-- Design Name: 
-- Module Name:    memoriaRAM_I - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoriaRAM_I is port (
		  CLK : in std_logic;
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
        Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
        WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end memoriaRAM_I;

architecture Behavioral of memoriaRAM_I is
type RamType is array(0 to 127) of std_logic_vector(31 downto 0);


--------------------------------------------------------------------------------
-- Memoria de instrucciones para test de prueba con NIP = 816906-R
--------------------------------------------------------------------------------
-- JAL R7, #20 														-> 14070014
-- LW  R0, 0(R6) -- R0 = 800000 									-> 08C00000
-- ADD R2, R3, R2 													-> 04621000
-- ADD R4, R5, R4 													-> 04A42000
-- ADD R0, R1, R0 													-> 04010000
-- NOP
-- ADD R2, R4, R2													-> 04821000
-- NOP
-- NOP
-- ADD R0, R2, R0													-> 04400000
-- NOP
-- NOP
-- SW  R0, 0(R8) 													-> 0D000000
-- JAL R0, -1 														-> 1400FFFF
-- NOPS
-- Subrutina para la carga de datos de memoria a registros
-- LW  R1, 4(R6) -- R1 = 10000 										-> 08C10004
-- LW  R2, 8(R6)  -- R2 = 6000 										-> 08C20008
-- LW  R3, 12(R6) -- R3 = 900 										-> 08C3000C
-- LW  R4, 16(R6) -- R4 = 0 										-> 08C40010
-- LW  R5, 20(R6) -- R5 = 6 										-> 08C50014
-- RET R7 -- Retornar a la direccion guardada en R7					-> 18E00000
--------------------------------------------------------------------------------
signal RAM : RamType := ( X"14070014", X"08C00000", X"04621000", X"04A42000", X"04010000", X"00000000", X"00000000", X"00000000", -- palabras 0,1,2,3,4,5,6,7
						  X"04821000", X"00000000", X"00000000", X"04400000", X"00000000", X"00000000", X"0D000000", X"1400FFFF", -- palabras 8,9,...
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"08C10004", X"00000000",
						  X"08C20008", X"08C3000C", X"08C40010", X"08C50014", X"18E00000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
						  X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");
signal dir_7:  std_logic_vector(6 downto 0); 
begin
 
 dir_7 <= ADDR(8 downto 2); -- como la memoria es de 128 plalabras no usamos la direcci�n completa sino s�lo 7 bits. Como se direccionan los bytes, pero damos palabras no usamos los 2 bits menos significativos
 process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE = '1') then -- s�lo se escribe si WE vale 1
                RAM(conv_integer(dir_7)) <= Din;
            end if;
        end if;
    end process;

    Dout <= RAM(conv_integer(dir_7)) when (RE='1') else "00000000000000000000000000000000"; --s�lo se lee si RE vale 1

end Behavioral;


