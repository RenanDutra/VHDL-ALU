-- SISTEMAS DIGITAIS 2020-2
--	AUTOR: RENAN DA SILVA DUTRA
-- ABRIL DE 2021
-- EXPERIENCIA 1
-- SOMADOR (BIT A BIT)

library ieee;
use ieee.std_logic_1164.all; 

entity DECODER is 
	port
	(
	
--INPUTS	
		
		AIN: in 			 			std_logic_vector(3 downto 0); -- ENTRADA DO VALOR A
		BIN: in 			 			std_logic_vector(3 downto 0); -- ENTRADA DO VALOR B
		RIN: in 			 			std_logic_vector(7 downto 0); -- ENTRADA DO RESULTADO DA OPERACAO

--OUTPUTS		
																			  -- a,b,c,d,e,f,g 
		AOUT0: out 					std_logic_vector(6 downto 0); -- PRIMEIRA SAIDA DO VALOR A
		AOUT1: out 					std_logic_vector(6 downto 0); -- SEGUNDA SAIDA DO VALOR A
		BOUT0: out 					std_logic_vector(6 downto 0); -- PRIMEIRA SAIDA DO VALOR B
		BOUT1: out 					std_logic_vector(6 downto 0); -- SEGUNDA SAIDA DO VALOR B
		ROUT0: out 					std_logic_vector(6 downto 0); -- PRIMEIRA SAIDA DO RESULTADO DA OPERACAO
		ROUT1: out 					std_logic_vector(6 downto 0); -- SEGUNDA SAIDA DO RESULTADO DA OPERACAO
		ROUT2: out 					std_logic_vector(6 downto 0)-- TERCEIRA SAIDA DO RESULTADO DA OPERACAO
	);
	
end DECODER;

architecture structure of DECODER is

--------------------------------------------------COMPONENTES------------------------------------------------------------

	component SEVENSEG 
		port
		(
		
	--INPUTS	
			
			INPUT: in 				std_logic_vector(3 downto 0); -- 4bit input

	--OUTPUTS		
			
			OUTPUT: out 			std_logic_vector(6 downto 0) -- a,b,c,d,e,f,g 			

		);
		
	end component;
	
	
	-----------------
	
	component BCD 
	port
	(
	
--INPUTS	
		
		INPUT: in 			std_logic_vector(3 downto 0); -- 4bit input

--OUTPUTS		
		
		OUTPUT0: out 			std_logic_vector(3 downto 0); -- 4bit input
		OUTPUT1: out			std_logic_vector(3 downto 0) -- 4bit input
		
	);
	
	end component;
	
	
	
	---------------------
	
	component BCDEIGHTBIT  
	port
	(
	
--INPUTS	
		
		INPUT: in 			std_logic_vector(7 downto 0); -- 4bit input

--OUTPUTS		
		
		OUTPUT0: out 			std_logic_vector(3 downto 0); -- 4bit input
		OUTPUT1: out			std_logic_vector(3 downto 0); -- 4bit input
		OUTPUT2: out			std_logic_vector(3 downto 0) -- 4bit input
		
	);
	
	end component;
	
	
--------------------------------------------------SINAIS------------------------------------------------------------
	
--- sinais do decodificador	
	signal A2BCD0, A2BCD1 , B2BCD0, B2BCD1: std_logic_vector(3 downto 0);
	signal R2BCD0, R2BCD1, R2BCD2: std_logic_vector(3 downto 0); 
	
begin
--O CIRCUITO PEGA AS ENTRADAS, CONVERTER PARA BCD E MAPEIA NOS 7SEG USANDO OS COMPONENTES

	conversorA: BCD port map(AIN, A2BCD0, A2BCD1);
	conversorB: BCD port map(BIN, B2BCD0, B2BCD1);
	conversorR: BCDEIGHTBIT port map(RIN, R2BCD0, R2BCD1, R2BCD2);

	ASEG0: SEVENSEG port map(A2BCD0, AOUT0);
	ASEG1: SEVENSEG port map(A2BCD1, AOUT1);
	
	BSEG0: SEVENSEG port map(B2BCD0, BOUT0);
	BSEG1: SEVENSEG port map(B2BCD1, BOUT1);
	
	RSEG0: SEVENSEG port map(R2BCD0, ROUT0);
	RSEG1: SEVENSEG port map(R2BCD1, ROUT1);
	RSEG2: SEVENSEG port map(R2BCD2, ROUT2);
	

end structure;