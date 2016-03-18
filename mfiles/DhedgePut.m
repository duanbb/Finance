%
% DhedgePut.m
%

disp('  ');
disp('  プットオプションに対して複製ポートフォリオを構成します。');
disp('  GBmotion.m, BSput.mを実行した後に、実行してください。');
input('  準備ができているならば、何かキーを押してください。');

disp('  ');
disp('  リバランスの数を設定します。分割数より少ない数を設定して下さい。');
M=input('    リバランスの数 = ');

Omega = []; Pdel = []; 
if M > 0,
  Omega(1) = vecP(1); 
  [CD,PD]=blsdelta(vecS(1),K,r,vectau(1),sigma,0);
  Pdel(1)=PD;
  PDtmp = []; PDtmp(1) = Pdel(1);
  kk = 1; jj=N/M;
  for nn = 1:N,
    if nn/jj <= kk,
      Pdel(nn)=PDtmp(kk);
    else, 
      [CD,PD]=blsdelta(vecS(nn),K,r,vectau(nn),sigma,0);
      Pdel(nn)=PD;
      PDtmp(kk+1) = Pdel(nn); kk = kk+1;
    end
    Omega(nn+1)=exp(r*dt)*Omega(nn)+Pdel(nn)*(vecS(nn+1)-exp(r*dt)*vecS(nn));
  end
else,
  Omega = vecP(1)*ones(size(vecP));
end

disp('  ');
disp('  複製ポートフォリオの価格変動(実線)を表示します。');
disp('  点線は、同じ時点におけるプットオプションの価格です。');

figure(3)
hold off;
plot(vecT,Omega,'b-',vecT,vecP,'r:');
xlabel('期間(年)')
ylabel('複製ポートフォリオ価格(実線)とプットオプション価格(点線)')

disp('  ');
disp('  ヘッジ誤差(満期時点のオプションとポートフォリオ価値の差)を計算します。');
disp('  ');
stat = sprintf('  リバランス数%2.0f回のヘッジ誤差は %2.4f です。',...
M,Omega(length(vecP))-vecP(length(vecP)));
disp(stat);


