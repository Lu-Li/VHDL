library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity div_50000 is
port(clk50MHz:in std_logic;  --转换前时钟50MHz
     clk1kHz:out std_logic);  --转换后时钟1kHz
end div_50000;

architecture behave of div_50000 is
signal tmp:integer range 0 to 49999;
begin 

p1:process(clk50MHz)
begin 
if clk50MHz'event and clk50MHz='1' then 
	if tmp=49999 then 
		tmp<=0;
	else 
		tmp<=tmp+1;
	end if;
end if;
end process p1;

p2:process(clk50MHz)
begin 
if clk50MHz'event and clk50MHz='1' then 
	if tmp=49999 then
		clk1kHz<='1';
	else
		clk1kHz<='0';
	end if;
end if;
end process p2;

end behave;


    
