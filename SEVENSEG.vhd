-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity SEVENSEG is 
	port
	(
	
--INPUTS	
		
		INPUT: in 			std_logic_vector(3 downto 0); -- 4bit input

--OUTPUTS		
		
		OUTPUT: out 			std_logic_vector(6 downto 0) -- a,b,c,d,e,f,g 
		

	);
	
end SEVENSEG;

architecture dataflow of SEVENSEG is
begin

	with INPUT select OUTPUT <=
		"1000000" when x"0",	
		"1111001" when x"1",	
		"0100100" when x"2", 	--  
		"0110000" when x"3", 	--   --a--
		"0011001" when x"4", 	--  |     |
		"0010010" when x"5", 	--  f	  	 b
		"0000010" when x"6", 	--  |	  	 |
		"1111000" when x"7", 	--   --g--
		"0000000" when x"8", 	--  |	    |
		"0011000" when x"9", 	--  e	    c
		"0001000" when x"a",    --  |	    |
		"0000011" when x"b",    --   --d--
		"1000110" when x"c",    --
		"0100001" when x"d",
		"0000110" when x"e",
		"0001110" when x"f",
		"1111111" when others;



end dataflow;