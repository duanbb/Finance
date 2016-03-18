%
% EarlyEx.m (早期行使確率の計算; AmericanCall.mもしくはAmericanPut.m
%            の後に実行する.)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. パラメータの設定(AmericanCall.mもしくはAmericanPut.mと同じ)
% 
% 新しく設定するパラメータ
% mu; 実確率ドリフト項
% tau_max; 早期行使を計算する上限となる時点
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu = 0.2;            
    % 実確率ドリフト項．早期行使確率を計算するのに使用．
af_r = exp((mu-rho)*dt); 
    % 実確率に基づく配当を考慮した1期間のaccumulation factor
c = 0.9;
tau_max = floor(c*N);  
    % 早期行使がtau_max以前である確率を計算．
    % ただし，cは推定する早期行使確率の満期時点に対する比であり，
    % Prob(tau <= tau_max)を計算する．

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 早期行使確率の計算(Indicator functionの期待値を計算)
% 
% Q; 早期行使がtau_max以前の早期行使判定行列 (N+1行N+1列)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q = Dk; 
if tau_max < N, 
  for nn = tau_max+2:N+1,
    for jj = 1:nn,
       Q(jj,nn) = 0;
    end
  end
end

Qc = Q;
pp = (af_r-d)/(u-d); qq = 1-pp;
for nn = N:-1:1,
  for jj = 1:nn,
    Qc_d = pp*Qc(jj,nn+1)+qq*Qc(jj+1,nn+1); % 継続価値の計算
    Qc(jj,nn)= max(Qc_d,Q(jj,nn));          % 行使価値との比較
  end
end

Pk = Qc(1,1);
disp('  早期行使確率 Pk = ');
disp(Pk)
