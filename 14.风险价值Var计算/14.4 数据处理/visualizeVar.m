%注
function simulationResults = visualizeVar (returnsPortfolio, marketValuePortfolio)
pricesPortfolioSimulated = returnsPortfolio*marketValuePortfolio;%为什么要乘最后一天的市值
simulationResults = [pricesPortfolioSimulated returnsPortfolio];

subplot(2,1,1)
plot(simulationResults(:,1))
title('Simulated Portfolio Returns')
xlabel('Time (days)')
ylabel('Amount ($)')
subplot(2,1,2)
hist(simulationResults(:,2), 100)%类似于正态分布的图
title('Distribution of Portfolio Returns')
xlabel('Return')
ylabel('Number of occurences')