library ieee;
use ieee.std_logic_1164.all;
entity bar is
port(leftime:in integer range 0 to 90000;  --剩余时间输入，来自倒计时模块
	 timeset:in integer range 0 to 90;  --时间设定模块，来自手动倒计时与自动倒计时模块
	 reset:in std_logic;  --复位（关闭）信号，关闭信号来自关闭模块
	 light:out std_logic_vector(7 downto 0));  --LED输出信号，输出至8个LED灯
end bar;

architecture behave of bar is
signal number:integer range 0 to 8;  --记录当前剩下的LED亮灯数（8代表全部熄灭，7代表亮灯8个，其余以此类推）
begin

process(leftime)
variable step:integer range 0 to 20000;  --设置步长，每次经过一次步长，亮灯的数量减少一个
begin 
step:=timeset*1000/8;  --计算步长
number<=leftime/step;  --计算亮灯的数量
if reset = '1' then  --关闭状态，亮灯全灭
number<= 8;
end if;
end process;

process(number)
begin
case number is
when 8 => light<="00000000";  --关闭状态，所有灯全部熄灭
when 7 => light<="11111111";
when 6 => light<="01111111";
when 5 => light<="00111111";
when 4 => light<="00011111";
when 3 => light<="00001111";
when 2 => light<="00000111";
when 1 => light<="00000011";
when 0 => light<="00000001";
end case;
end process;

end behave;

 

