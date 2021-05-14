-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use IEEE.STD_LOGIC_1164.ALL; 

entity FULLADDER is port
	(
	
--INPUTS	
	
		X: 		in std_logic_vector(3 downto 0);
		Y: 		in std_logic_vector(3 downto 0);
		CIN : 	in std_logic;
		
--OUTPUTS
		
		SUM:		out std_logic_vector(3 downto 0);
		COUT : 	out std_logic
		
	);
	
end FULLADDER;


architecture behavorial of FULLADDER is

	component HALFADDER 
		port(
		
--INPUTS	
	
			x:   		in std_logic; 
			y:   		in std_logic;
			cin: 		in std_logic;
			
--OUTPUTS	
		
			output:  out std_logic;
			cout: 	out std_logic
		
		);
	end component;
	
	
--SINAIS
	
	signal	carry1: std_logic;
	signal	carry2: std_logic;
	signal	carry3: std_logic;
	
begin

--MAPEAMENTO

	
	u0: HALFADDER port map(X(0), Y(0), CIN, SUM(0), carry1);
	u1: HALFADDER port map(X(1), Y(1), carry1, SUM(1), carry2);
	u2: HALFADDER port map(X(2), Y(2), carry2, SUM(2), carry3);
	u3: HALFADDER port map(X(3), Y(3), carry3, SUM(3), COUT);	
	

end behavorial;