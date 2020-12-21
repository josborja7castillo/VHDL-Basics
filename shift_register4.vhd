---4 bit universal shift register---
---Author: José Borja Castillo Sánchez---
---This VHDL model is based on the 74LS194 component---

library ieee;
use ieee.std_logic_1164.all;

entity shift_register4 is 

port(
	clock : in std_logic;
	clear : in std_logic;
	s : in std_logic_vector(1 downto 0);
	sri : in std_logic;
	sli : in std_logic;
	p : in std_logic_vector(3 downto 0);
	q : out std_logic_vector(3 downto 0));
end shift_register4;

architecture behav of shift_register4 is
	type states is (RST, HOLD, LD, SL, SR);
	signal current_state: states := RST;
	signal intermediate: std_logic_vector(3 downto 0);
begin
	process(clear, s)
	begin 
		if(clear = '1') then 
			current_state <= RST;
		else 
			case s is
				when "00" => current_state <= HOLD;
				when "01" => current_state <= SR;
				when "10" => current_state <= SL;
				when "11" => current_state <= LD;
				when others => current_state <= RST;
			end case;
		end if;
	end process;

	process(clock)
	begin
		if(current_state = RST) then
			intermediate <= "0000";
		elsif(current_state = LD) then
			intermediate <= p;
		elsif(current_state = SR) then
			intermediate <= sri & intermediate(3 downto 1);
		elsif(current_state = SL) then 
			intermediate <= intermediate(2 downto 0) & sli;
		end if;
		q <= intermediate;
	end process;
end behav;