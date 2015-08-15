library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count8 is
port(clk1kHz:in std_logic;  --时钟输入
	 count8out:out std_logic_vector(2 downto 0);  --循环计数输出
	 co:out std_logic);  --进位输出
end count8;

architecture behave of count8 is
signal count:std_logic_vector(2 downto 0);  --计数信号
begin 

process(clk1khz)
begin
if clk1khz'event and clk1khz='1' then
	if count="111" then
		count<="000";co<='1';
	else count<=count+1;co<='0';
	end if;
end if;
count8out<=count;
end process;

end behave;
 