library ieee;
use ieee.std_logic_1164.all;
entity bar is
port(leftime:in integer range 0 to 90000;  --ʣ��ʱ�����룬���Ե���ʱģ��
	 timeset:in integer range 0 to 90;  --ʱ���趨ģ�飬�����ֶ�����ʱ���Զ�����ʱģ��
	 reset:in std_logic;  --��λ���رգ��źţ��ر��ź����Թر�ģ��
	 light:out std_logic_vector(7 downto 0));  --LED����źţ������8��LED��
end bar;

architecture behave of bar is
signal number:integer range 0 to 8;  --��¼��ǰʣ�µ�LED��������8����ȫ��Ϩ��7��������8���������Դ����ƣ�
begin

process(leftime)
variable step:integer range 0 to 20000;  --���ò�����ÿ�ξ���һ�β��������Ƶ���������һ��
begin 
step:=timeset*1000/8;  --���㲽��
number<=leftime/step;  --�������Ƶ�����
if reset = '1' then  --�ر�״̬������ȫ��
number<= 8;
end if;
end process;

process(number)
begin
case number is
when 8 => light<="00000000";  --�ر�״̬�����е�ȫ��Ϩ��
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

 

