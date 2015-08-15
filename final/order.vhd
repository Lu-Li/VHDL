library ieee;
use ieee.std_logic_1164.all;
entity order is
port (ordercontrol:in std_logic;  --用户定时输入信号（BTN4）
	  clk1kHz:in std_logic;  --时钟输入
	  reset:in std_logic;  --复位（关闭）信号，关闭信号与用户模式选择信号共同控制
	  timeset:out integer range 0 to 90;  --倒计时设定信号，输出给倒计时器
	  norder:out std_logic);  --自动定时控制信号，如果手动定时为s0，则开启自动定时，否则不开启
end;

architecture behave of order is
type type_state is (s0,s5,s10,s30,s60);  --状态机，有六种状态，分别为不定时、定时5s、10s、30s、60s,初始化为不定时状态s0
signal present_state,next_state:type_state;  --定义当前进程与下一个进程
begin

nextstate_logic:process(present_state,ordercontrol)  --状态转移进程
begin
case present_state is
	when s0 => if ordercontrol = '1' then
					next_state<=s5;
				else
					next_state<=s0;
				end if;
	when s5    => if ordercontrol = '1' then
					next_state<=s10;
				else
					next_state<=s5;
				end if;
	when s10   => if ordercontrol = '1' then
					next_state<=s30;
				else
					next_state<=s10;
				end if;
	when s30   => if ordercontrol = '1' then
					next_state<=s60;
				else
					next_state<=s30;
				end if;
	when s60   => if ordercontrol = '1' then
					next_state<=s0;
				else
					next_state<=s60;
				end if;
end case;
end process;

state_register:process(clk1kHz)  --时钟进程
begin
if clk1kHz'event and clk1kHz='1' then
	present_state<= next_state;
	if reset= '1' then
		present_state<=s0;
	 end if;
end if;
end process;

output_logic:process(present_state)  --状态输出进程
begin
case present_state is
	when s0    => timeset<=0;norder<='0';
	when s5    => timeset<=5;norder<='1';
	when s10   => timeset<=10;norder<='1';
	when s30   => timeset<=30;norder<='1';
	when s60   => timeset<=60;norder<='1';
end case;
end process;

end behave;