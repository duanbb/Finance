%����ʲ��۸�
Price=100;%ע��S������Ԥ�Ƶģ��ǵ�ǰ�Ĺɼۣ�
%ִ�м۸�
Strike=95; %ע��K��ע��S>K��in the money��
%�޷��������ʣ��껯��
Rate=0.1;%10%
%ʣ��ʱ��
Time=3/12;%=0.25;
%�껯������ %ע������ʲ��۸��~
Volatility=0.5;
[CallDelta, PutDelta] = blsprice(Price, Strike, Rate, Time, Volatility)