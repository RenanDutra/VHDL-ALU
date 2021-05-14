-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 

entity TWOCOMPLEMENT is 
	port
	(
	
--INPUTS	
		
		input: in std_logic_vector(3 downto 0);
		
--OUTPUTS		
		
		output: out std_logic_vector(3 downto 0)
		
	);
	
end TWOCOMPLEMENT;


architecture dataflow of TWOCOMPLEMENT is

	component FULLADDER 
		port(
		
--INPUTS	
	
		X: 		in 		std_logic_vector(3 downto 0);
		Y: 		in 		std_logic_vector(3 downto 0);
		CIN : 	in 		std_logic;
		
--OUTPUTS
		
		SUM:		out 		std_logic_vector(3 downto 0);
		COUT : 	out 		std_logic
		
		);
		end component;
		
--SINAIS

	signal input_not: 	std_logic_vector(3 downto 0);

begin

	input_not <= NOT input;
	
	u1: FULLADDER port map(input_not, "0000", '1', OUTPUT, open);


end dataflow;