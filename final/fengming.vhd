library ieee;
use ieee.std_logic_1164.all;
entity fengming is 
port(input:in std_logic;  --������źţ������û���ʱ���루BTN4��
	 clk1kHz:in std_logic;  --ʱ���źţ�����ʱ��ģ��
	 reset:in std_logic;  --��λ���رգ��źţ����Թر�ģ��
	 output:out std_logic);  --����źţ������������
end fengming;

architecture behave of fengming is
begin

process(clk1kHz)
variable count:integer range 0 to 30;  --����������������ʱ����ĳ���
variable mask:std_logic:='0';  --��ʼ����������
begin
if clk1kHz'event and clk1kHz ='1' then
	if input ='1' then  --��ʼ��
		count:=0;mask:='1';
	end if;
	if reset ='1' then   --��λ
		count:=0;mask:='0';
	end if;
	count:=count+1;  --��������
	if mask='1' and count<10 then
		output<='1';  --�ӳٳ������������������
	else
		output<='0';mask:='0';  --�ͷ��ӳ٣�������ֹͣ����
	end if;
end if;
end process;

end behave;