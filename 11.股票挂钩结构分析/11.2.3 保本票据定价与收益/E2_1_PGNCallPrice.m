Price=20;%注：标的股票价格
Strike=20;%注：执行价格
Rate=0.1;%注：无风险利率
Volatility=0.3;%注：年化波动率
%%
subplot(2,1,1)
t=1:-0.05:0;
%t=0:0.05:1;%注：此处指的是中途取出；与t=1:-0.05:0;相同
Num=length(t);
PGNPrice=zeros(1,Num);
for i=1:Num;
    [Call, Put] = blsprice(Price, Strike, Rate, t(i), Volatility);%注：只用到Call，没用到Put
    PGNPrice(i)=1e4*(1.1)^(t(i)-1)+271.6027*Call;%注：理财产品面值（无风险+有风险的总和，固定）1e4，购入风险产品数量271，风险产品单价Call。
    %注：为什么用不同的ti减一，因为求的是取出时（停止交易时）的价值（收入）。（所以股票部分不用折现（不太懂。））
end
plot(t,PGNPrice,'-*')
legend('PGNPrice,Price=20')
%%
t=0.5;
subplot(2,1,2)
Price=10:1:30;%t时股票的收益（这才是理财产品关注的地方,赌股票会涨。）
Num=length(Price);
PGNPrice=zeros(1,Num);
for i=1:Num;
    [Call, Put] = blsprice(Price(i), Strike, Rate, t, Volatility);
     PGNPrice(i)=1e4*(1.1)^(t-1)+271.6027*Call;
end
plot(Price,  PGNPrice,'-o')
legend('PGNPrice,Time=0.5')