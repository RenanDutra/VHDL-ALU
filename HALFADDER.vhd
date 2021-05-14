-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 

entity HALFADDER is 
	port
	(
		x, y, cin : in std_logic;
		output, cout : out std_logic
		
	);
	
end HALFADDER;


architecture dataflow of HALFADDER is
begin

	output <= (x XOR y) XOR cin;
	cout <= (x AND y) OR (cin AND (x XOR y));


end dataflow;