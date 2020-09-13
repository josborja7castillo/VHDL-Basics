--Author: José Borja Castillo.
--Date: September 13th, 2020.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------------------------------------
--Entity declaration

entity genfulladder is
	generic (N: integer :=31);
	port (
			A, B: in bit_vector(N downto 0);		
			Cin: in bit;
			Cout: out bit;
			S: out bit_vector(N downto 0)
		);	
end entity genfulladder;

---------------------------------------------------------------------------------
--Architecture declaration

architecture behav of genfulladder is
	signal INT: bit_vector(N+1 downto 0);

	component FULLADDER is
		port (
			A,B: in bit;
			Cin: in bit;
			Cout: out bit;
			S: out bit
		);
	end component FULLADDER;
begin

	INT(0) <= Cin;

	GEX: for I in 0 to N generate 
        X: FULLADDER port map (A(I),B(I),INT(I),INT(I+1),S(I));
	end generate GEX;

	Cout <= INT(N+1);
	
end architecture behav;