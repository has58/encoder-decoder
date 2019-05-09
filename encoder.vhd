
-----Pengxiang Zhao component of addition encoder------
library ieee;
use ieee.std_logic_1164.all;

entity Add_Encoder_Component is
	port(clk,ena,rst:in bit;
		a,b:in bit_vector(7 downto 0);
		output:out bit_vector(7 downto 0));
end Add_Encoder_Component;

architecture behv of Add_Encoder_Component is
begin
	process(clk,a,b,ena)
	begin
		if (rst='1') then
			output<=(others=>'0');
		elsif (clk'event and clk='1') then
			if (ena='1') then
				for i in a'range loop
					output(i)<=a(i) xor b(i);
				end loop;
			end if;
		end if;
	end process;
end behv;
