ZSreturn=-0.5:0.05:0.5%注：招商银行收益率
Preturn=max(0,-ZSreturn*125.94/100);%125.94是执行价格（决定斜率）
plot(ZSreturn,Preturn)
xlabel('招行收益率')
ylabel('产品收益率')
hold on
plot(0,-0.2,'.')