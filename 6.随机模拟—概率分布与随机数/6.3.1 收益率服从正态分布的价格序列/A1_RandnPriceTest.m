%RandnPriceTest
Price0=10;
%假设预期年收益率为10%
%每年250个交易日，预期日收益率为mu
mu=1.1^(1/250)-1; %注：(1+mu)^250=1.1,年あたり250期間の複利
%假设预期年波动率为30%
%每年250个交易日，预期日波动率为sigma
sigma=.30/sqrt(250)%注：ボラティリティ,250*sigma^2=0.3
%为了2年随机价格
N=250*2;
Price=RandnPrice(Price0,mu,sigma,N)

plot(Price(:,1))%注：所有行第一列
xlabel('time')
ylabel('price')

% 注：期待収益率（リターン）と標準偏差（ボラティリティ）