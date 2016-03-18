%
% BSput.m
%

disp('  ');
disp('  原資産価格変動に対するプットオプション価格の変動を計算します。');
disp('  GBmotion.m を実行した後に、実行してください。');
input('  準備ができているならば、何かキーを押してください。');

disp('  ');
disp('  行使価格を入力して下さい。');
K=input('    行使価格 = ');
if isempty(K)>0, K = S0; end;

disp('  ');
disp('  無リスク利子率を入力して下さい。');
r=input('    無リスク利子率 = ');
  if isempty(r)>0, r = 0.05; end;

vecP = [];
vectau = T*ones(size(vecT)); vectau = vectau-vecT;
for nn = 1:N+1,
  [Ctmp,Ptmp] = blsprice(vecS(nn),K,r,vectau(nn),sigma,0);
  vecP(nn) = Ptmp;
end

disp('  ');
disp('  ヨーロピアンプットオプション価格を表示します。');
disp('  実線は、オプション価格と保有期間との関係を表し、');
disp('  点線は、本質価値max(K-S,0)を表します。');

figure(2)
hold off;
ival = K*ones(size(vecS))-vecS;
for ii = 1:length(ival),
  ival(ii) = max(ival(ii),0);
end

plot(vecT,vecP,'b-',vecT,ival,'r:');
xlabel('期間(年)')
ylabel('ヨーロピアンプットオプション価格(実線)と本質価値max[K-S,0](点線)')

