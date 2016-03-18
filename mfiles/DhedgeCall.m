%
% DhedgeCall.m (複製ポートフォリオの追従性能とリバランスの回数)
%

disp('  ');
disp('  コールオプションに対して複製ポートフォリオを構成します。');
disp('  GBmotion.m, BScall.mを実行した後に、実行してください。');
input('  準備ができているならば、何かキーを押してください。');

disp('  ');
disp('  リバランスの数を設定します。分割数より少ない数を設定して下さい。');
M=input('    リバランスの数 = ');

Omega = []; Cdel = []; 
  Omega(1) = vecC(1); 
if M > 0,
  Cdel(1)=blsdelta(vecS(1),K,r,vectau(1),sigma,0);
  CDtmp = []; CDtmp(1) = Cdel(1);
  kk = 1; jj=N/M;
  for nn = 1:N,
    if nn/jj <= kk,
      Cdel(nn)=CDtmp(kk);
    else, 
      Cdel(nn)=blsdelta(vecS(nn),K,r,vectau(nn),sigma,0);
      CDtmp(kk+1) = Cdel(nn); kk = kk+1;
    end
    Omega(nn+1)=exp(r*dt)*Omega(nn)+Cdel(nn)*(vecS(nn+1)-exp(r*dt)*vecS(nn));
  end
else,
  Omega = vecC(1)*ones(size(vecC));
end

disp('  ');
disp('  複製ポートフォリオの価格変動(実線)を表示します。');
disp('  点線は、同じ時点におけるコールオプションの価格です。');

figure(3)
hold off;
plot(vecT,Omega,'b-',vecT,vecC,'r:');
xlabel('期間(年)')
ylabel('複製ポートフォリオ価格(実線)とコールオプション価格(点線)')

disp('  ');
disp('  ヘッジ誤差(満期時点のオプションとポートフォリオ価値の差)を計算します。');
disp('  ');
stat = sprintf('  リバランス数%2.0f回のヘッジ誤差は %2.4f です。',...
M,Omega(length(vecC))-vecC(length(vecC)));
disp(stat);


