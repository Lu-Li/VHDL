library ieee;
use ieee.std_logic_1164.all;
entity norder is
port(state:in std_logic_vector(2 downto 0);  --获取当前烹饪状态，来源为模式模块
	 timeset:out integer range 0 to 90;  --倒计时设定信号，输出至倒计时器模块
     reset:in std_logic);  --复位（关闭）信号，来源为手动控制模块和关闭模块
end;

architecture behave of norder is
begin
process(state,reset)
begin
case state is
	when "011" => timeset<=3;
	when "101" => timeset<=20;
	when "001" => timeset<=90;
	when "010" => timeset<=90;
	when "100" => timeset<=90;
	when others=> timeset<=0;
end case;
if reset='1' then  --自动设定模块关闭
  timeset<=0;
end if;
end process;

end behave;