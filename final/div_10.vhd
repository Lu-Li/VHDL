library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity div_10 is
port(clk1kHz:in std_logic;  --转换前时钟1kHz
	 clk100Hz:out std_logic);  --转换后时钟100Hz
end div_10;

architecture behave of div_10 is
signal tmp:integer range 0 to 9;
begin 

p1:process(clk1kHz)
begin 
if clk1kHz'event and clk1kHz='1' then 
	if tmp=9 then 
		tmp<=0;
	else 
		tmp<=tmp+1;
	end if;
end if;
end process p1;
  
p2:process(clk1kHz)
begin 
if clk1kHz'event and clk1kHz='1' then 
	if tmp=9 then 
		clk100Hz<='1';
	else
		clk100Hz<='0';
	end if;
end if;
end process p2;

end behave;


    
