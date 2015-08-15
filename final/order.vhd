library ieee;
use ieee.std_logic_1164.all;
entity order is
port (ordercontrol:in std_logic;  --�û���ʱ�����źţ�BTN4��
	  clk1kHz:in std_logic;  --ʱ������
	  reset:in std_logic;  --��λ���رգ��źţ��ر��ź����û�ģʽѡ���źŹ�ͬ����
	  timeset:out integer range 0 to 90;  --����ʱ�趨�źţ����������ʱ��
	  norder:out std_logic);  --�Զ���ʱ�����źţ�����ֶ���ʱΪs0�������Զ���ʱ�����򲻿���
end;

architecture behave of order is
type type_state is (s0,s5,s10,s30,s60);  --״̬����������״̬���ֱ�Ϊ����ʱ����ʱ5s��10s��30s��60s,��ʼ��Ϊ����ʱ״̬s0
signal present_state,next_state:type_state;  --���嵱ǰ��������һ������
begin

nextstate_logic:process(present_state,ordercontrol)  --״̬ת�ƽ���
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

state_register:process(clk1kHz)  --ʱ�ӽ���
begin
if clk1kHz'event and clk1kHz='1' then
	present_state<= next_state;
	if reset= '1' then
		present_state<=s0;
	 end if;
end if;
end process;

output_logic:process(present_state)  --״̬�������
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