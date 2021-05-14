-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- MAIO DE 2021
-- EXPERIENCIA 1
-- MULTIPLICADOR

library ieee;
use ieee.std_logic_1164.all; 

entity FULLPRODUCT is 
	port
	(
--INPUTS

		x:                  in      std_logic_vector(3 downto 0);
		y:                  in      std_logic_vector(3 downto 0);
		
--OUTPUTS

		output :            out     std_logic_vector(7 downto 0)
		
	);
	
end FULLPRODUCT;


architecture structure of FULLPRODUCT is

-------------------------------------COMPONENTES-----------------------------------


--SOMADOR
	component FULLADDER 
		port(
		
--INPUTS	
	
		X: 		in 						    std_logic_vector(3 downto 0);
		Y: 		in 						    std_logic_vector(3 downto 0);
		CIN: 		in 						std_logic;
			
--OUTPUTS
		
		SUM:		out 					std_logic_vector(3 downto 0);
		COUT: 	out 						std_logic
	
		);
		end component;
		
--------------------------------SINAIS-----------------------------------------		

-- PRODUTOS PARCIAIS
    signal P0, P1, P2:  std_logic_vector (3 downto 0);
-- B INPUTS 
    signal B0, B1, B2:  std_logic_vector (3 downto 0);

begin

    P0 <= (x(3) and y(1), x(2) and y(1), x(1) and y(1), x(0) and y(1));
    P1 <= (x(3) and y(2), x(2) and y(2), x(1) and y(2), x(0) and y(2));
    P2 <= (x(3) and y(3), x(2) and y(3), x(1) and y(3), x(0) and y(3));

    B0 <=  ('0', x(3) and y(0), x(2) and y(0), x(1) and y(0));
    
    SOMA1: FULLADDER port map(X => P0, Y => B0, CIN => '0', COUT => B1(3), SUM(3) => B1(2), SUM(2) => B1(1), SUM(1) => B1(0), SUM(0) => OUTPUT(1));
    SOMA2: FULLADDER port map(X => P1, Y => B1, CIN => '0', COUT => B2(3), SUM(3) => B2(2), SUM(2) => B2(1), SUM(1) => B2(0), SUM(0) => OUTPUT(2));
    SOMA3: FULLADDER port map(X => P2, Y => B2, CIN => '0', COUT => OUTPUT(7), SUM => OUTPUT(6 downto 3));
    
    OUTPUT(0) <= x(0) and y(0); 
end structure;