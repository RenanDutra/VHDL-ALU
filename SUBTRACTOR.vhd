-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 

entity SUBTRACTOR is 
	port
	(
	
--INPUTS	
		
		A, B: in 			std_logic_vector(3 downto 0);
		BIN: in 				std_logic;
		
--OUTPUTS		
		
		SUB: out 			std_logic_vector(3 downto 0)
		
	);
	
end SUBTRACTOR;


architecture structure of SUBTRACTOR is

--SOMADOR
	component FULLADDER 
		port(
		
--INPUTS	
	
		X: 		in 						std_logic_vector(3 downto 0);
		Y: 		in 						std_logic_vector(3 downto 0);
		CIN : 	in 						std_logic;
			
--OUTPUTS
		
		SUM:		out 						std_logic_vector(3 downto 0);
		COUT : 	out 						std_logic
				
		);
		end component;
		
--COMPLEMENTO DE DOIS		
		component TWOCOMPLEMENT 
		port(
		
	
--INPUTS	
		
		input: in 							std_logic_vector(3 downto 0);
		
--OUTPUTS		
		
		output: out 						std_logic_vector(3 downto 0)
		
	);
	
		end component;
		
--SINAIS

signal b_complement, temp_sub: 		std_logic_vector(3 downto 0);	
signal sub_complement: 				std_logic_vector(3 downto 0);	
signal condition: 						std_logic;

begin

	
	u1: TWOCOMPLEMENT 	port map(B, b_complement);
	u2: FULLADDER 			port map(A, b_complement, '0', temp_sub, condition);
	
-- SE o COUT(condition) FOR 1, O RESULTADO É SUB, CASO CONTRARIO, TEMOS QUE FAZER O COMPLEMENTO DE 2 NOVAMENTE
	
	u3: TWOCOMPLEMENT 	port map(B, sub_complement);
	
	process(A, B, BIN, temp_sub, condition, sub_complement)
		begin
				if(condition = '1') then
					
					SUB <= temp_sub;
				
				else
				
					SUB <= sub_complement;
				
				end if;
			
		end process;

end structure;