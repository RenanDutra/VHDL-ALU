-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity BCD is 
	port
	(
	
--INPUTS	
		
		INPUT: in 			std_logic_vector(3 downto 0); -- 4bit input

--OUTPUTS		
		
		OUTPUT0: out 			std_logic_vector(3 downto 0); -- 4bit input
		OUTPUT1: out			std_logic_vector(3 downto 0) -- 4bit input
		
	);
	
end BCD;

architecture dataflow of BCD is
begin

	with INPUT select OUTPUT0 <=
		"0000" when x"0",	
		"0001" when x"1",	
		"0010" when x"2", 		--  
		"0011" when x"3", 		--   --a--     --a--
		"0100" when x"4", 		--  |     |	  |     |
		"0101" when x"5", 		--  f	  	 b	  f	  b
		"0110" when x"6", 		--  |	  	 |   |	  |
		"0111" when x"7", 		--   --g--     --g--
		"1000" when x"8", 		--  |	    |   |	  |
		"1001" when x"9", 		--  e	    c   e	  c
		"0000" when x"a", 	   --  |	    |   |	  |
		"0001" when x"b",			--   --d--     --d--
		"0010" when x"c",								
		"0011" when x"d",	
		"0100" when x"e",
		"0101" when x"f",
		"0000" when others;
	
	with INPUT select OUTPUT1 <=
		"0001" when x"a",	
		"0001" when x"b",	
		"0001" when x"c", 		--  
		"0001" when x"d", 		--   --a--     --a--
		"0001" when x"e", 		--  |     |	  |     |
		"0001" when x"f", 		--  f	  	 b	  f	  b
		"0000" when others;  	--  |	  	 |   |	  |
										--   --g--     --g--
										--  |	    |   |	  |
										--  e	    c   e	  c
										--  |	    |   |	  |
										--   --d--     --d--

end dataflow;