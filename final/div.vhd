library ieee;
use ieee.std_logic_1164.all;
entity div is 
port (input:in integer range 0 to 90000;  --倒计时输入，来自倒计时模块
      outen,outone:out integer range 0 to 10);  --分离显示倒计时（秒）的十位与个位，输出至数码管模块
end div;

architecture behave of div is
begin

process(input)
variable seconds:integer range 0 to 90;  --转换input为秒
begin
seconds:=input/1000;  --转换input为秒
outen<=seconds/10;  --分离出来input的十位
outone<=seconds mod 10;  --分离出来input的个位
end process;

end behave;