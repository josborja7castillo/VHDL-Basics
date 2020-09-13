--Author: José Borja Castillo
--Date September 13th, 2020.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--A and B are two bits that are going to be added.
--Cin is carry in.
--Cout is carry out.
--S is out
---------------------------------------------------------------------------------
--Entity declarations

entity fulladder is
	port (
		A, B: in bit;
		Cin: in bit;
		Cout: out bit;
		S: out bit
	);
end entity fulladder;

--------------------------------------------------------------------------------
--Architectural behaviour

architecture arch_fulladder of fulladder is
	--Declaration of needed signals.
	signal I1, I2, I3: bit;

	--This design is modular, that means a sub-module previously 
	-- done is going to be reused.
	component halfadd is
		port (
			A,B: in bit;
			Cout: out bit;
			O: out bit
		);
	end component halfadd;

	for H1: halfadd use entity work.halfadder(arch_halfadder);
	for H2: halfadd use entity work.halfadder(arch_halfadder);

begin
	
	H1: halfadd port map (A,B,I2,I1);
	H2: halfadd port map (I1,Cin,I3,S);
	Cout <= I2 or I3;	
end architecture arch_fulladder;
