library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count6 is
port(clk1khz:in std_logic;  --时钟输入
	 count6out:out std_logic_vector(2 downto 0));  --0~5循环六进制显示
end count6;

architecture behave of count6 is
signal count:std_logic_vector(2 downto 0);  --计数信号
begin

process(clk1khz)
begin
if clk1khz'event and clk1khz='1' then
	if count="101" then
		count<="000";
	else count<=count+1;
	end if;
end if;
count6out<=count;
end process;

end behave;
 