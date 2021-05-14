-- SISTEMAS DIGITAIS 2020-2
-- AUTOR: RENAN DA SILVA DUTRA
-- MAIO DE 2021
-- EXPERIENCIA 1
-- UNIDADE LOGICA ARITMETICA
--
--	SEL2  SEL1      SEL0 |	OUTPUT
--	0		0		0	 | A complemento de 2	 
--	0		0		1	 | A - B
--	0		1		0	 | A + B
--	0		1		1	 | A * B
--	1		0		0	 | A ^ 2
--	1		0		1	 | A AND B
--	1		1		0	 | A OR B
--	1		1		1	 | NOT A

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ULA is
port
	(
	
--INPUTS

		RST:																in 				std_logic;
		SW:																in 				std_logic_vector(8 downto 0);--A(3 downto 0) e B(7 downto 4)
		CLOCK_50:														in 				std_logic;

--OUTPUTS
		
		HEX0, HEX1, HEX2, HEX4, HEX5, HEX6, HEX7: 			            out 			std_logic_vector(6 downto 0);
		LEDR:                                                           out             std_logic_vector(2 downto 0);
		SAIDA: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	
end ULA;

architecture structure of ULA is --	COMPORTAMENTO DA ALU

------------------------- COMPONENTES --------------------------

--7SEG DECODER

	component DECODER  
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
			ROUT2: out 					std_logic_vector(6 downto 0) -- TERCEIRA SAIDA DO RESULTADO DA OPERACAO
			
		);
		
	end component;

--SUBTRATOR

	component SUBTRACTOR  
		port
		(
		
--INPUTS	
			
			A, B: in 						std_logic_vector(3 downto 0);
			BIN: in 						std_logic;
			
--OUTPUTS		
			
			SUB: out 						std_logic_vector(3 downto 0)
			
		);
	
	end component;

--SOMADOR
	component FULLADDER 
		port(
		
--INPUTS	
	
		X: 		in 						std_logic_vector(3 downto 0);
		Y: 		in 						std_logic_vector(3 downto 0);
		CIN: 		in 						std_logic;
			
--OUTPUTS
		
		SUM:		out 						std_logic_vector(3 downto 0);
		COUT: 	out 						std_logic
				
		);
		end component;
		
--MULTIPLICADOR

component FULLPRODUCT 
	port
	(
--INPUTS

		x:                  in      std_logic_vector(3 downto 0);
		y:                  in      std_logic_vector(3 downto 0);
		
--OUTPUTS

		output :            out     std_logic_vector(7 downto 0)
		
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
		
-------------------------  SINAIS  --------------------------

signal counter: 					    unsigned(25 downto 0);
signal operation: 			            unsigned(2 downto 0);

--sinais auxiliares das operacoes

signal subcomp: std_logic_vector(3 downto 0);
signal adder: std_logic_vector(4 downto 0);
signal sub: std_logic_vector(3 downto 0);
signal product, power: std_logic_vector(7 downto 0);

signal Ax, Aaux, Bx, Baux: std_logic_vector(3 downto 0);
signal OUTPUT: std_logic_vector(7 downto 0);
signal CLK, EN, INT_CLK: std_logic;
------------------------- LOGICA --------------------------	

begin

-- INDEXAMENTO DOS SINAIS

Aaux <= SW(3 downto 0);
Baux <= SW(7 downto 4);
EN <= SW(8);
CLK <= CLOCK_50 when EN = '1' else '0';	
LEDR(2) <= std_logic(operation(2));
LEDR(1) <= std_logic(operation(1));
LEDR(0) <= std_logic(operation(0));
SAIDA <= OUTPUT;
	
-- REGISTRADOR DO CONTADOR	
	process(CLK, RST) 
	begin
			
	    if rising_edge(CLK) then
            counter <= counter + 1;
            if counter >= 5  then -- 50 MHz;
                INT_CLK <= '1';
                counter <= (others => '0');
            else
                INT_CLK <= '0';
            end if;
        end if;
        
        if RST = '0' then
        
            counter <= (others => '0');
        
        end if;
        
	end process;
	
-- REGISTRADOR DO OPERADOR	
	process(CLK, INT_CLK) 
	begin
			
	    if rising_edge(INT_CLK) then
            operation <= operation + 1;
            if operation >= 7 then
                operation <= (others => '0');
            end if;
        end if;
        
        
        if RST = '0' then
        
            operation <= (others => '0');
        
        end if;
        
	end process;
	
-- REGISTRADORES DOS VALORES	
	process(CLK, EN) 
	begin
	
	    if rising_edge(CLK) then
            Ax <= Aaux;
            Bx <= Baux;
        end if;
        
        if RST = '0' then
        
            Ax <= "0000";
            Bx <= "0000";
        
        end if;
        
	end process;
		
-- OPERACOES E MAPEAMENTO	

	u0: TWOCOMPLEMENT port map(Ax, subcomp);
	u1: SUBTRACTOR port map(Ax, Bx, '0', sub);
	u2: FULLADDER port map(Ax, Bx, '0', adder(3 downto 0), adder(4));
	u3: FULLPRODUCT port map(Ax, Bx, product);
	u4: FULLPRODUCT port map(Ax, Ax, power);
	u5: DECODER port map(Aaux, Baux, OUTPUT, HEX6, HEX7, HEX4, HEX5, HEX0, HEX1, HEX2);
	
	
	
-- SELECAO DA OPERACAO
	process(CLK) 
		begin
    			case(operation) is
    		
    				when "000" => 
    				
    					OUTPUT(7 downto 4) <= "0000";
    					OUTPUT(3 downto 0) <= subcomp;
    					
    				when "001" => 
    				
    					OUTPUT(7 downto 4) <= "0000";
    					OUTPUT(3 downto 0) <= sub;
    						
    				when "010" => 
    				
    					OUTPUT(7 downto 5) <= "000";
    					OUTPUT(4 downto 0) <= adder;
    						
    				when "011" => 
    				
    					OUTPUT<= product;
    						
    				when "100" => 
    				
    				    OUTPUT<= power;
    					
    				when "101" => 
    				
    					OUTPUT(7 downto 4) <= "0000";
    					OUTPUT(3 downto 0) <= Ax AND Bx;
    						
    				when "110" => 
    				
    					OUTPUT(7 downto 4) <= "0000";
    					OUTPUT(3 downto 0) <= Ax OR Bx ;
    						
    				when "111" => 
    				
    					OUTPUT(7 downto 4) <= "0000";
    					OUTPUT(3 downto 0) <= NOT Ax;
    						
    				when others => 
    						
    					OUTPUT <= "00000000";
    			
			    end case;
		end process;
		
		
end structure;