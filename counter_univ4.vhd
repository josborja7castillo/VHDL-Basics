---Universal 4 bit counter ---
---Author: José Borja Castillo Sánchez---
-- Synchronous reset, binary counter--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity counter4 is port(
	clk: in std_logic;
	reset: in std_logic;
	load: in std_logic;
	u_not_d: in std_logic;
	p_in: in std_logic_vector(3 downto 0);
	q: out std_logic_vector(3 downto 0));
end counter4;

architecture rtl of counter4 is 
	signal count, next_count : std_logic_vector(3 downto 0) := "0000"; 
	type states is (RST, LD, CNT_UP, CNT_DOWN);
	signal curr_state: states := RST;
begin
	--Updates the current state.
	process(reset,load,u_not_d)
	begin
		if(reset = '1') then
			curr_state <= RST;
		else
			if(load = '1') then 
				curr_state <= LD;
			elsif(load = '0' and u_not_d = '1') then
				curr_state <= CNT_UP;
			elsif (load = '0' and u_not_d = '0') then
				curr_state <= CNT_DOWN;
			end if;
		end if;
	end process;
--Although the state change might be asynchronous, 
--the updated behaviour only happens whenever a rising clock event
--occurs.
	process(clk)
	begin
		if(clk'event and clk = '1') then 
			if(curr_state = RST) then
				count <= "0000";
			elsif(curr_state = LD) then
				count <= p_in;
			elsif(curr_state = CNT_UP) then
				--count <= next_count;
				if(count = "1111") then
					count <= "0000";
				else
					count <= count + 1;
				end if;
			elsif(curr_state = CNT_DOWN) then
				--count <= next_count;
				if(count = "0000") then
					count <= "1111";
				else
					count <= count - 1;
				end if;
			end if;
		end if;
	q <= count;
	end process;
end rtl; 