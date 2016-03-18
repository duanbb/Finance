Price=100;
Strike=95;
Rate=0.10;
Time=1.0;
Volatility=0:0.1:2.0;%注：波动率从0到20%
n=length(Volatility);
Call=zeros(n,1);
Put=zeros(n,1);
for i=1:n %注：分别计算看涨期权价格与看跌期权价格
    [Call(i),Put(i)] = blsprice(Price, Strike, Rate, Time, Volatility(i));
end
%注：画子图
subplot(2,1,1)
plot(Volatility,Call,'-*');
legend('CallPrice')
subplot(2,1,2)
plot(Volatility,Put,'-o');
legend('PutPrice')