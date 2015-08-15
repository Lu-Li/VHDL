library ieee;
use ieee.std_logic_1164.all;
entity decount is
port (timeset:in integer range 0 to 90;  --�趨����ʱʱ�������Զ�ʱ�벻��ʱģ��
	  reset:in std_logic;  --��λ���رգ��źţ���λ�����û�ģʽ�������û���ʱ�źţ��ر��ź����Թر�ģ��
	  clk1Hz:in std_logic;  --ʱ�����룬����ʱ��ģ��
	  timecontrol:out std_logic;  --״̬��ת�źţ����ڱ���ģʽ�Զ�ת��Ϊ�峴ģʽ�������ģʽ����ģ��
	  close:out std_logic;  --�ر��źţ�����ʱ���ʱ�����źţ�������ر�ģ��
	  leftimetemp:out integer range 0 to 90000);  --ʣ��ʱ�䣬����1kHz�źż�ʱ�������������ģ���������ģ��
end decount;

architecture behave of decount is
begin

process(clk1Hz)
variable timecount:integer range 0 to 90000;  --������������0��ʼ����
variable timesetemp:integer range 0 to 90;  --��ֹ��λ�źŲ����ӳ٣�ʹ���ӳٹ���timeset
variable mask:std_logic:='0';  --��ʼ�����帨������
begin
if clk1Hz'event and clk1Hz='1' then
	if mask ='0' then  --��ʼ����ֵ
	timesetemp:=timeset;mask:='1';timecount:=0;
	end if;
	timecontrol<='0';
	timecount:=timecount+1;  --������
	leftimetemp<=timesetemp*1000-timecount;
	if reset='1' then  --��λ�źţ��ָ���ʼ״̬
	mask:='0';timecount:=0;
	leftimetemp<=timeset*1000;
	timesetemp:=timeset;
	end if;
	if timecount>= timesetemp*1000 then  --����ʱ���
		if timeset =3 then  --����ʱΪ3s��ʱ�򲻲����ر��źţ�������״̬��ת
			close<='0';timecontrol<='1';
		else  close<='1';
		end if;
	else close<='0';
	end if;
	if timesetemp = 0  then  --������õ���ʱʱ��Ϊ0���������ر��źţ���ʾʣ��ʱ��Ϊ0
	close<='0';leftimetemp<=0;
	end if;
end if;
end process;

end behave;