%%
%set value
PortValue=100; %Portfoilo Value %注：产品组合初始价值（A0）
Riskmulti=2;%注：CPPI 策略的风险乘数（M）
GuarantRatio=1.00;%注：产品的保本率（100%完全保本）（lambda，初始风险控制水平）
TradeDayTimeLong=250;%注：产品期限，以交易日计数，250个交易日
TradeDayOfYear=250;%注：模拟假设一年交易为 250 个
adjustCycle=10;%注：调整周期为每 10 个交易日调整一次
RisklessReturn=0.05;%注：无风险资产年化收益率（r）
TradeFee=0.005;%注：风险资产的交易费用（%）
%%
%to generate random number
Mean=1.2^(1/TradeDayOfYear)-1;%注：风险资产（深300）的预期收益率（0.2），年化转日化。（1+日）^250=1.2
Std=0.3/sqrt(TradeDayOfYear);%注：风险资产（深300）的预期波动率（标准差，0.3），年化转日化
Price0=100;%注：风险资产的初始价格
SData=RandnPrice(Price0,Mean,Std,TradeDayOfYear)%注：模拟风险资产（沪深300指数）收益序列，布朗运动（根据正态分布（走势）生成变化后的价格的序列）
SData=[Price0;SData]%注：将初始价格并人随机价格序列，%[X0,Xl,...,Xn]
%%
%to computer
[F,E,A,G,SumTradeFee,portFreez]=CPPIStr(PortValue,Riskmulti,GuarantRatio,...
    TradeDayTimeLong,TradeDayOfYear,adjustCycle,RisklessReturn,TradeFee,SData);
%%
%to plot
figure;
%注：子图1，模拟助岛、险费苦的价格序列
subplot(2,1,1)
plot(SData)
xlabel('t');
ylabel('price')
legend('Hs300-Simulation')
%注：子图2，CPPI 策略的运行情况
subplot(2,1,2)
plot(A,'-.')  
hold on
plot(E,'--')
plot(F,'-k')  
plot(G,'-x')
%注：标记线形
legend('PortValue','RiskAssect','GuarantLine','RisklessAssect')
xlabel('t');
ylabel('price')
SumTradeFee