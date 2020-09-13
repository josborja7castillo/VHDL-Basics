--Author: José Borja Castillo
--Date: September 13th, 2020
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--A and B are two bits that are going to be added.
--Cout is carry out.
--O is out
---------------------------------------------------------------------------------
--Entity declarations
entity halfadder is
	port (
		A, B: in bit;
		Cout: out bit;
		O: out bit
	);
end entity halfadder;
--------------------------------------------------------------------------------
--Architectural behaviour

architecture arch_halfadder of halfadder is
begin
    Cout <= A and B;
	O <= A xor B;
end architecture arch_halfadder;