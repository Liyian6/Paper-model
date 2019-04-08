%clc
%%ʹ�����Ȩֵ����ֵ
inputnum=size(P,1);
outputnum=size(T,1);
net=newff(minmax(P),[hiddennum,outputnum],{'tansig','logsig'},'trainlm');
%%���������������ѵ������Ϊ100��ѵ��Ŀ��Ϊ0.01��ѧϰ����Ϊ0.1
net.trainParam.epochs=1000;
net.trainParam.goal=0.01;
LP.lr=0.1;
%%ѵ������
net=train(net,P,T);

%% ��������
disp(['1��ʹ�����Ȩֵ����ֵ '])
disp('��������Ԥ������')
Y1=sim(net,P_test);
err1=norm(Y1-T_test);%���������ķ������
err2=norm(sim(net,P)-T);
disp(['���������ķ������:',num2str(err1)])
disp(['ѵ�������ķ������:',num2str(err11)])

%% ʹ���Ż����Ȩֵ����ֵ
nputnum=size(P,1);       % �������Ԫ���� 
outputnum=size(T,1);      % �������Ԫ����
net=newff(P,T,[hiddennum,outputnum],{'tansig','logsig'},'trainlm');
%%���������������ѵ������Ϊ100��ѵ��Ŀ��Ϊ0.01��ѧϰ����Ϊ0.1
net.trainParam.epochs=1000;
net.trainParam.goal=0.01;
LP.lr=0.1;
w1num=inputnum*hiddennum;
w2num=hiddennum*outputnum;
w1=bestX(1:w1num);
B1=bestX(w1num+1:w1num+hiddennum);
w2=bestX(w1num+1:w1num+hiddennum+hiddennum+w2num);
B2=bestX(w1num+hiddennum+w2num+1:w1num+hiddennum+w2num+outputnum);
net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=reshape(B2,outputnum,1);
%%ѵ������
net=train(net,P,T);

%% ��������
disp(['2��ʹ���Ż����Ȩֵ����ֵ'])
disp('��������Ԥ������')
Y2=sim(net,P_test);
err2=norm(Y2-T_test)
err21=norm(sim(net,P)-T);
disp(['���������ķ������:',num2str(err2)])
disp(['ѵ�������ķ������:',num2str(err21)])

