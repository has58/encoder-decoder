
--Implement Multiplier in GF(2^m) using VHDL--
----------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
---the package includes function of multiplier in GF(2^8)-------------------------------
package my_package is
    function mult_Hao (v1, v2 : in std_logic_vector) return std_logic_vector;
end package;

package body my_package is  
  
function mult_Hao (v1, v2 : in std_logic_vector) 
return std_logic_vector is

constant m              : integer := 8;        --we use the 8 bits package	
variable dummy          : std_logic;
variable v_temp         : std_logic_vector(m-1 downto 0);
variable ret            : std_logic_vector(m-1 downto 0);

begin
  v_temp := "00000000";                  --produce primitive polynomial: 1 + x^2 + x^3 + x^4 + x^8
   for i in 0 to m-1 loop                --do implementation by using LFSR approach
  
    dummy	   := v_temp(7 );
    v_temp(7 ) := v_temp(6 );
    v_temp(6 ) := v_temp(5 );
    v_temp(5 ) := v_temp(4 );
    v_temp(4 ) := v_temp(3 )xor dummy;
    v_temp(3 ) := v_temp(2 )xor dummy;
    v_temp(2 ) := v_temp(1 )xor dummy;
    v_temp(1 ) := v_temp(0 );
    v_temp(0 ) := dummy;

    for j in 0 to m-1 loop
      v_temp(j) := v_temp(j) xor (v1(j) and v2(m-i-1)); --performing the division by the primitive polynomial in GF(2^8),
                                                        --we need "xor" and "and" operations
    end loop;
  end loop;
  ret := v_temp;
  return ret;
end mult_Hao;

end package body;
----------------------------------------------the end of the package-------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use work.my_package.all;

Entity mult is 
  port (A,B: in std_logic_vector(7 downto 0);
         clk : in std_logic;
         C  : out std_logic_vector(7 downto 0));

end entity;

Architecture bev of mult is
signal d,e: std_logic_vector(7 downto 0);
begin
process(A,B,clk)
  begin
     if clk'event and clk = '1' then               --make 24 registers to do the primetime
     d <= A;
     e <= B;
     C <= mult_Hao(d,e);
     end if;
end process;
end bev;
