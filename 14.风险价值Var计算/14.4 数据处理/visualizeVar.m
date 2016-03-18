%ע
function simulationResults = visualizeVar (returnsPortfolio, marketValuePortfolio)
pricesPortfolioSimulated = returnsPortfolio*marketValuePortfolio;%ΪʲôҪ�����һ�����ֵ
simulationResults = [pricesPortfolioSimulated returnsPortfolio];

subplot(2,1,1)
plot(simulationResults(:,1))
title('Simulated Portfolio Returns')
xlabel('Time (days)')
ylabel('Amount ($)')
subplot(2,1,2)
hist(simulationResults(:,2), 100)%��������̬�ֲ���ͼ
title('Distribution of Portfolio Returns')
xlabel('Return')
ylabel('Number of occurences')