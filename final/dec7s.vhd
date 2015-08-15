library ieee;
use ieee.std_logic_1164.all;
entity dec7s is
port(input:in std_logic_vector(3 downto 0);  --输入信号，格式为BCD码
	 led7s:out std_logic_vector(6 downto 0));  --输出信号，输出信号传递给abcdefg端
end dec7s;

architecture behave of dec7s is
begin

process(input)
begin
case input is
	when"0000"=>led7s<="1111110";  --0
	when"0001"=>led7s<="0110000";  --1
	when"0010"=>led7s<="1101101";  --2
	when"0011"=>led7s<="1111001";  --3
	when"0100"=>led7s<="0110011";  --4
	when"0101"=>led7s<="1011011";  --5
	when"0110"=>led7s<="1011111";  --6
	when"0111"=>led7s<="1110000";  --7
	when"1000"=>led7s<="1111111";  --8
	when"1001"=>led7s<="1111011";  --9
	when others=>led7s<="0000000";  --不显示
end case;
end process;

end behave;
    