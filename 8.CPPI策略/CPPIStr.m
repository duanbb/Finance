%注：8.3.2
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
SumTradeFee=0;%注：初始交易费用（交易佣金）为 0
%注：F，E，A，G的初始化，长度为 N + 1
F=zeros(1,TradeDayTimeLong+1);%注：安全底线
E=zeros(1,TradeDayTimeLong+1);%注：（可投资于）风险资产（的上限）
A=zeros(1,TradeDayTimeLong+1);%注：产品净值
G=zeros(1,TradeDayTimeLong+1);%注：（可投资于）无风险资产（的下限）
%注：给定 F,E,A,G 的初始值
A(1)=PortValue;%注：初始组合资产
F(1)=GuarantRatio*PortValue*exp(-RisklessReturn*TradeDayTimeLong/TradeDayOfYear);%注：初始安全底线
E(1)=max(0,Riskmulti*(A(1)-F(1)));%注：可投资于风险资产的上限（此例假设风险乘数M不变，恒定比例模式）
G(1)=A(1)-E(1);%注：可投资于无风险资产的下限
%%
%注：组合风险资产是否出现平仓，0 为未出现风险资产平仓，1 为出现风险资产平仓
portFreez=0; %if portFreez=1, portfolio freez  there would have no risk--investment 
%%
for i=2:TradeDayTimeLong+1 %注：开始逐日模拟，循环计算，根据 T- 1 日情况与 T 日市场行情，计算 T 日产品净值
    E(i)=E(i-1)*(1+(SData(i)-SData(i-1))/(1+SData(i-1)));%注：不懂，算变化率的话为什么SData(i-1)要+1？
    G(i)=G(i-1)*(1+RisklessReturn/TradeDayOfYear);%注：无风险除天数（假设单利），有风险开根号（假设复利）
    A(i)=E(i)+G(i);
    F(i)=GuarantRatio*PortValue*exp(-RisklessReturn*(TradeDayTimeLong-i+1)/TradeDayOfYear);
    
    if mod(i,adjustCycle)==0%注：到周期开始调整，调整的是E
        temp=E(i);
        E(i)=max(0, Riskmulti*(A(i)-F(i)) );
        SumTradeFee=SumTradeFee + TradeFee*abs(E(i)-temp);%注：总交易费用
        G(i)=A(i)-E(i)-TradeFee*abs(E(i)-temp);
    end
    
    if E(i)==0
        A(i)=G(i);
        portFreez=1;
    end    
end
    