%
% BScall.m (�R�[���I�v�V�������i�ϓ��̌v�Z)
%

disp('  ');
disp('  �����Y���i�ϓ��ɑ΂���R�[���I�v�V�������i�̕ϓ����v�Z���܂��B');
disp('  GBmotion.m �����s������ɁA���s���Ă��������B');
input('  �������ł��Ă���Ȃ�΁A�����L�[�������Ă��������B');

disp('  ');
disp('  �s�g���i����͂��ĉ������B');
K=input('    �s�g���i = ');
if isempty(K)>0, K = S0; end;

disp('  ');
disp('  �����X�N���q������͂��ĉ������B');
r=input('    �����X�N���q�� = ');
  if isempty(r)>0, r = 0.05; end;

vecC = [];
vectau = T*ones(size(vecT)); vectau = vectau-vecT;
for nn = 1:N+1,
  vecC(nn) = blsprice(vecS(nn),K,r,vectau(nn),sigma,0);
end

disp('  ');
disp('  ���[���s�A���R�[���I�v�V�������i��\�����܂��B');
disp('  �����́A�I�v�V�������i�ƕۗL���ԂƂ̊֌W��\���A');
disp('  �_���́A�{�����lmax(S-K,0)��\���܂��B');

figure(2)
hold off;
ival = vecS-K*ones(size(vecS));
for ii = 1:length(ival),
  ival(ii) = max(ival(ii),0);
end

plot(vecT,vecC,'b-',vecT,ival,'r:');
xlabel('����(�N)')
ylabel('���[���s�A���R�[���I�v�V�������i(����)�Ɩ{�����lmax[S-K,0](�_��)')

