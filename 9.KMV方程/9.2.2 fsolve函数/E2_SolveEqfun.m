x0 = [-5; -5];%ע����ʼ������
options=optimset('Display','iter');  %ע����ʾ�������̽��
[x,fval] = fsolve(@Eqfun,x0,options) %ע������ fsolve �����������
