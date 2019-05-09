
-----Pengxiang Zhao component of addition decoder------
library ieee;
use ieee.std_logic_1164.all;

entity Add_Decoder_Component is
	port(clk,ena,rst:in bit;
		a,b:in bit_vector(7 downto 0);
		output1,output2:out bit_vector(7 downto 0));
end Add_Decoder_Component;

architecture behv of Add_Decoder_Component is
begin
	--xor_gate: for i in a'range generate
		--output1(i)<=a(i) xor b(i);
	--end generate;
	
	process(clk,ena,rst,a,b)
	begin
		if (rst='1') then
			output1<=(others=>'0');
			output2<=(others=>'0');
		elsif (clk'event and clk='1') then
			if (ena='1') then
				for i in a'range loop
					output1(i) <= a(i) xor b(i);
					output2(i) <= a(i);
				end loop;
			end if;
		end if;
	end process;
end behv;