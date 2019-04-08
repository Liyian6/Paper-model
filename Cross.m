function ret=Cross(FitnV,lenchrom,chrom,sizepop,bound)
%�������
%FitnV����Ⱥ��Ӧ��ֵ
%lenchrom:Ⱦɫ�峤��
%chrom��Ⱦɫ��Ⱥ
%sizepop����Ⱥ��ģ
%ret��������Ⱦɫ��
%pcross:�������

for i=1:sizepop   %�Ƿ���н������ɽ�����ʾ�����continue���ƣ�
    %���ѡ������Ⱦɫ����н���
    pick=rand(1,2);
    while prod(pick)==0
        pick=rand(1,2);
    end
    index=ceil(pick.*sizepop);
    FitnVavg=mean(FitnV);
    if max(FitnV(max(index))<=FitnVavg)
        pcross=1-0.5/(1+exp(acos(pi*(FitnVavg-FitnV(max(index)))/(FitnVavg-FitnV(max(index))))));
    else
        pcross=1.0;
    end
    
    %������ʾ����Ƿ���н���
    pick=rand;
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    flag=0;
    while flag==0
        %���ѡ�񽻲�λ��
        pick=rand;
        while pick==0;
            pick=rand;
        end
        pos=ceil(pick.*sum(lenchrom));%���ѡ����н����λ��
        pick=rand;%���濪ʼ
        v1=chrom(index(1),pos);
        v2=chrom(index(2),pos);
        chrom(index(1),pos)=pick*v2+(1-pick)*v1;
        chrom(index(2),pos)=pick*v1+(1-pick)*v2; %�������
        flag1=test(lenchrom,bound,chrom(index(1),:),fcode);
        flag2=test(lenchrom,bound,chrom(index(2),:),fcode);
        if flag1*flag2==0
            flag=0;          %�������Ⱦɫ�嶼���ǿ��еģ������½���
        else
            flag=1;       
        end
    end
end
ret=chrom;