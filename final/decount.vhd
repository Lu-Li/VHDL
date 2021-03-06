library ieee;
use ieee.std_logic_1164.all;
entity decount is
port (timeset:in integer range 0 to 90;  --设定倒计时时长，来自定时与不定时模块
	  reset:in std_logic;  --复位（关闭）信号，复位来自用户模式控制与用户定时信号，关闭信号来自关闭模块
	  clk1Hz:in std_logic;  --时钟输入，来自时钟模块
	  timecontrol:out std_logic;  --状态跳转信号，用于爆炒模式自动转换为煎炒模式，输出至模式控制模块
	  close:out std_logic;  --关闭信号，倒计时完毕时产生信号，输出至关闭模块
	  leftimetemp:out integer range 0 to 90000);  --剩余时间，采用1kHz信号计时，输出至进度条模块与数码管模块
end decount;

architecture behave of decount is
begin

process(clk1Hz)
variable timecount:integer range 0 to 90000;  --计数变量，从0开始计数
variable timesetemp:integer range 0 to 90;  --防止复位信号产生延迟，使用延迟过的timeset
variable mask:std_logic:='0';  --初始化定义辅助变量
begin
if clk1Hz'event and clk1Hz='1' then
	if mask ='0' then  --初始化赋值
	timesetemp:=timeset;mask:='1';timecount:=0;
	end if;
	timecontrol<='0';
	timecount:=timecount+1;  --计数器
	leftimetemp<=timesetemp*1000-timecount;
	if reset='1' then  --复位信号，恢复初始状态
	mask:='0';timecount:=0;
	leftimetemp<=timeset*1000;
	timesetemp:=timeset;
	end if;
	if timecount>= timesetemp*1000 then  --倒计时完成
		if timeset =3 then  --倒计时为3s的时候不产生关闭信号，仅仅是状态跳转
			close<='0';timecontrol<='1';
		else  close<='1';
		end if;
	else close<='0';
	end if;
	if timesetemp = 0  then  --如果设置倒计时时长为0，不产生关闭信号，显示剩余时间为0
	close<='0';leftimetemp<=0;
	end if;
end if;
end process;

end behave;