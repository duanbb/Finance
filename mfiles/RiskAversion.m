%
% RiskAversion.m (UtilityEstimate.m�����s���ċ��܂������ʂ��A�ׂ����p�֐�
%                 f(x) = x^gamma �ŋߎ����A���ΓI���X�N����W����\������B
%                 UtilityEstimate.m�̌�Ɏ��s�B) 
% 

gtmp = [];

for ii=1:length(C)-2,
  gtmp(ii) = log(U(ii+1))/log(C(ii+1));
end

gamma = mean(gtmp);

Y = []; Z = [];
for ii=1:101,
  Y(ii) = 0.01*(ii-1);
  Z(ii) = (Y(ii))^gamma;
end

plot(Y,Z,'r--')

stat = sprintf('  ���Ȃ���(���ΓI)���X�N����W����%2.4f�ł��B',1-gamma);
disp('  ');
disp(stat);

