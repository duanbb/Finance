%
% EarlyEx.m (�����s�g�m���̌v�Z; AmericanCall.m��������AmericanPut.m
%            �̌�Ɏ��s����.)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. �p�����[�^�̐ݒ�(AmericanCall.m��������AmericanPut.m�Ɠ���)
% 
% �V�����ݒ肷��p�����[�^
% mu; ���m���h���t�g��
% tau_max; �����s�g���v�Z�������ƂȂ鎞�_
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu = 0.2;            
    % ���m���h���t�g���D�����s�g�m�����v�Z����̂Ɏg�p�D
af_r = exp((mu-rho)*dt); 
    % ���m���Ɋ�Â��z�����l������1���Ԃ�accumulation factor
c = 0.9;
tau_max = floor(c*N);  
    % �����s�g��tau_max�ȑO�ł���m�����v�Z�D
    % �������Cc�͐��肷�鑁���s�g�m���̖������_�ɑ΂����ł���C
    % Prob(tau <= tau_max)���v�Z����D

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. �����s�g�m���̌v�Z(Indicator function�̊��Ғl���v�Z)
% 
% Q; �����s�g��tau_max�ȑO�̑����s�g����s�� (N+1�sN+1��)
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
    Qc_d = pp*Qc(jj,nn+1)+qq*Qc(jj+1,nn+1); % �p�����l�̌v�Z
    Qc(jj,nn)= max(Qc_d,Q(jj,nn));          % �s�g���l�Ƃ̔�r
  end
end

Pk = Qc(1,1);
disp('  �����s�g�m�� Pk = ');
disp(Pk)
