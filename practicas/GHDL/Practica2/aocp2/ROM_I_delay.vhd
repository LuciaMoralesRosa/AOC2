----------------------------------------------------------------------------------
-- IMPORTANTE: CADA ESTUDIANTE DEBE COMPLETAR SUS DATOS 
-- Name: Lucia Morales Rosa
-- NIA: 816906
-- Create Date: 22/02/2024   
-- Module Name: memoriaROM_I
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

entity memoriaROM_I is 
generic (	propagation_delay: time := 8 ns --propagation delay of the ROM
    		);  
port (
		ADDR : in std_logic_vector (6 downto 0); --Dir 
        RE : in std_logic;		-- read enable		  
		Dout : out std_logic_vector (31 downto 0)
		);
end memoriaROM_I;

architecture Behavioral of memoriaROM_I is
type RomType is array(0 to 127) of std_logic_vector(31 downto 0);
signal ROM : RomType := (  	X"0004E201", X"00000002", X"00000003", X"0002EE04", X"00007085", X"00000006", X"000000C7", X"00401CC6", -- words 0,1,2,3,4,...
							X"004018A5", X"00401484", X"00401063", X"00400C42", X"00400820", X"00200000", X"00000000", X"00000000",-- words 8,9,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",-- words 16,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
							X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...

signal internal_Dout : std_logic_vector (31 downto 0);
																		
begin
 	--read port
     internal_Dout <= ROM(conv_integer(ADDR)) when (RE='1') else X"00000000"; --s�lo se lee si RE vale 1
     -- Propagation delay
     Dout <= internal_Dout after propagation_delay;

end Behavioral;


