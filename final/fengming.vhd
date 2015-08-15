library ieee;
use ieee.std_logic_1164.all;
entity fengming is 
port(input:in std_logic;  --输入的信号，来自用户定时输入（BTN4）
	 clk1kHz:in std_logic;  --时钟信号，来自时钟模块
	 reset:in std_logic;  --复位（关闭）信号，来自关闭模块
	 output:out std_logic);  --输出信号，输出至蜂鸣器
end fengming;

architecture behave of fengming is
begin

process(clk1kHz)
variable count:integer range 0 to 30;  --计数变量，计算延时脉冲的长度
variable mask:std_logic:='0';  --初始化辅助变量
begin
if clk1kHz'event and clk1kHz ='1' then
	if input ='1' then  --初始化
		count:=0;mask:='1';
	end if;
	if reset ='1' then   --复位
		count:=0;mask:='0';
	end if;
	count:=count+1;  --计数增加
	if mask='1' and count<10 then
		output<='1';  --延迟持续输出，蜂鸣器工作
	else
		output<='0';mask:='0';  --释放延迟，蜂鸣器停止工作
	end if;
end if;
end process;

end behave;