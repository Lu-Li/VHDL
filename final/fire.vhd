library ieee;
use ieee.std_logic_1164.all;
entity fire is
port( clk1kHz:in std_logic;  --ʱ������
      up:in std_logic;  --�����������루BTN6��
      down:in std_logic;  --�����������루BTN6��
      state:in std_logic_vector(2 downto 0);  --��ȡ��ǰ״̬��������ģʽʱ���Ϊ1900
      reset:in std_logic;  --��λ���ػ����ź�
      out1,out2,out3,out4:out std_logic_vector(3 downto 0) );  --�����λ���֣�out1~4�����λ����λ����BCD���ʾ
end fire;

architecture behave of fire is
type state_type is (f1900,f1500,f1100,f600,f100);  --״̬�����ܹ���Ϊ����״̬���ֱ��Ӧ����Ϊ1900,1500,1100,600,100
signal present_state:state_type;  --��ǰ״̬
signal next_state:state_type;  --��һ��״̬
begin

nextstate_logic:process(present_state,up,down)  --״̬ת�ƽ���
begin 
  case present_state is
  when f1900 => if up='1' then
					next_state<= f1900;
				elsif down='1' then
						next_state<= f1500;
				else next_state<= f1900;
				end if;
  when f1500 => if up='1' then
					next_state<= f1900;
				elsif down='1' then
						next_state<= f1100;
				else next_state<= f1500;
                end if;
  when f1100 => if up='1' then
					next_state<= f1500;
				elsif down='1' then
					next_state<= f600;
				else next_state<=f1100;
				end if;
  when f600 =>  if up='1' then
					next_state<= f1100;
				elsif down='1' then
					next_state<= f100;
					else next_state<=f600;
				end if;
  when f100 =>  if up='1' then
					next_state<= f600;
				elsif down='1' then
					next_state<= f100;
				else next_state<=f100;
				end if;
  end case;
if state = "011" then
	next_state<= f1900;
end if;
end process;

state_register:process(clk1kHz)  --ʱ�ӽ���
begin 
if clk1kHz'event and clk1kHz='1' then
	present_state<= next_state;
	if reset = '1' then
		present_state<= f1900;
	end if;
end if;
end process;

output_logic:process(present_state)  --״̬���������
begin
case present_state is
  when f1900 => out1<="0001";out2<="1001";out3<="0000";out4<="0000";  --1900
  when f1500 => out1<="0001";out2<="0101";out3<="0000";out4<="0000";  --1500
  when f1100 => out1<="0001";out2<="0001";out3<="0000";out4<="0000";  --1100
  when f600  => out1<="0000";out2<="0110";out3<="0000";out4<="0000";  --600
  when f100  => out1<="0000";out2<="0001";out3<="0000";out4<="0000";  --100
end case;
end process;

end behave;