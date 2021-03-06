library ieee;
use ieee.std_logic_1164.all;
entity select6to1 is
port(no1,no2,no3,no4,no5,no6:in std_logic_vector(3 downto 0);  --六个信号输入
						count6in:in std_logic_vector(2 downto 0);  --选择控制信号,由0~5的六位循环加法器输入
						selectout:out std_logic_vector(3 downto 0);  --数据选择器结果输出
						cat:out std_logic_vector(5 downto 0));  --选择数码管亮的控制信号
end select6to1;

architecture behave of select6to1 is
begin

process(count6in)
begin
case count6in is
	when "101"=>selectout<=no6;cat<="111110";  --cat0选通
	when "100"=>selectout<=no5;cat<="111101";  --cat1选通
	when "011"=>selectout<=no4;cat<="111011";  --cat2选通
	when "010"=>selectout<=no3;cat<="110111";  --cat3选通
	when "001"=>selectout<=no2;cat<="101111";  --cat4选通
	when "000"=>selectout<=no1;cat<="011111";  --cat5选通
	when others=>selectout<="1111";cat<="111111";  --所有数码管均未选通
end case;
end process;

end behave;