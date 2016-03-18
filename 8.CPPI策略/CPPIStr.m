%ע��8.3.2
function [F,E,A,G,SumTradeFee,portFreez]=CPPIStr(PortValue,Riskmulti,GuarantRatio,TradeDayTimeLong,...
    TradeDayOfYear,adjustCycle,RisklessReturn,TradeFee,SData)
%code by ariszheng@gmail.com
%2009-6-30
%intput:
%PortValue,Riskmulti,GuarantRatio,TradeDayTimeLong,TradeDayOfYear,adjustCycle,RisklessReturn,TradeFee,
%SData is simulation index data
%output
%F,E,A,G,SumTradeFee
%SumTradeFee
%portFreez default is 0,  if portFreez=1, portfolio freez  there would have no risk--investment
%%
SumTradeFee=0;%ע����ʼ���׷��ã�����Ӷ��Ϊ 0
%ע��F��E��A��G�ĳ�ʼ��������Ϊ N + 1
F=zeros(1,TradeDayTimeLong+1);%ע����ȫ����
E=zeros(1,TradeDayTimeLong+1);%ע������Ͷ���ڣ������ʲ��������ޣ�
A=zeros(1,TradeDayTimeLong+1);%ע����Ʒ��ֵ
G=zeros(1,TradeDayTimeLong+1);%ע������Ͷ���ڣ��޷����ʲ��������ޣ�
%ע������ F,E,A,G �ĳ�ʼֵ
A(1)=PortValue;%ע����ʼ����ʲ�
F(1)=GuarantRatio*PortValue*exp(-RisklessReturn*TradeDayTimeLong/TradeDayOfYear);%ע����ʼ��ȫ����
E(1)=max(0,Riskmulti*(A(1)-F(1)));%ע����Ͷ���ڷ����ʲ������ޣ�����������ճ���M���䣬�㶨����ģʽ��
G(1)=A(1)-E(1);%ע����Ͷ�����޷����ʲ�������
%%
%ע����Ϸ����ʲ��Ƿ����ƽ�֣�0 Ϊδ���ַ����ʲ�ƽ�֣�1 Ϊ���ַ����ʲ�ƽ��
portFreez=0; %if portFreez=1, portfolio freez  there would have no risk--investment 
%%
for i=2:TradeDayTimeLong+1 %ע����ʼ����ģ�⣬ѭ�����㣬���� T- 1 ������� T ���г����飬���� T �ղ�Ʒ��ֵ
    E(i)=E(i-1)*(1+(SData(i)-SData(i-1))/(1+SData(i-1)));%ע����������仯�ʵĻ�ΪʲôSData(i-1)Ҫ+1��
    G(i)=G(i-1)*(1+RisklessReturn/TradeDayOfYear);%ע���޷��ճ����������赥�������з��տ����ţ����踴����
    A(i)=E(i)+G(i);
    F(i)=GuarantRatio*PortValue*exp(-RisklessReturn*(TradeDayTimeLong-i+1)/TradeDayOfYear);
    
    if mod(i,adjustCycle)==0%ע�������ڿ�ʼ��������������E
        temp=E(i);
        E(i)=max(0, Riskmulti*(A(i)-F(i)) );
        SumTradeFee=SumTradeFee + TradeFee*abs(E(i)-temp);%ע���ܽ��׷���
        G(i)=A(i)-E(i)-TradeFee*abs(E(i)-temp);
    end
    
    if E(i)==0
        A(i)=G(i);
        portFreez=1;
    end    
end
    