library ieee;
use ieee.std_logic_1164.all;
entity mode is 
port(clk1kHz:in std_logic;  --时钟输入，来自时钟模块
	 modecontrol:in std_logic;  --用户模式控制键输入（BTN7）
	 timecontrol:in std_logic;  --自动模式切换控制输入（当爆炒模式运行3s后自动进入煎炒模式），来自倒计时模块
	 reset:in std_logic;  --复位（关闭）信号，来自关闭模块
	 state:out std_logic_vector(2 downto 0));  --输出当前的状态，输出至火力模块，计时模块
end mode;

architecture behave of mode is
type state_type is (C,H,J,B,T,Z);  --状态机，总共有六种状态，分别为C（关机），H，J，B，T，Z
signal present_state:state_type;  --当前状态
signal next_state:state_type;  --下一个状态
begin

nextstate_logic:process(present_state,modecontrol,timecontrol)  --状态转移进程
begin
	case present_state is
		when C     => if modecontrol='1' then
						next_state<= H;
					  else
						next_state<= C;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
		when H     => if modecontrol='1' then
						next_state<= J;
					  else
						next_state<= H;
						if reset= '1' then
							next_state<=C;
	                    end if;
					  end if;
		when J	   => if modecontrol='1' then
							next_state<= B;
						else
							next_state<= J;
							if reset= '1' then
								next_state<=C;
							end if;
					  end if;
		when B     => if modecontrol='1' then
							next_state<= T;
					  else
						if timecontrol='1' then
							next_state<= J;
						else next_state<= B;
						end if; 
						if reset= '1' then
							next_state<=C;
						end if; 
					  end if;
		when T     => if modecontrol='1' then
						next_state<= Z;
					  else
						next_state<= T;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
		when Z     => if modecontrol='1' then
						next_state<= H;
					  else
						next_state<= Z;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
	end case;
end process;

state_register:process(clk1kHz)  --时钟进程
begin
	if clk1kHz'event and clk1kHz='1' then
		present_state<= next_state;
	end if;
end process;

output_logic:process(present_state)  --状态机输出进程
begin
  case present_state is
	when C      => state <="000";
	when H      => state <="001";
	when J      => state <="010";
	when B      => state <="011";
	when T      => state <="100";
	when Z      => state <="101";
	when others => state <="111";
  end case;
end process;

end behave;