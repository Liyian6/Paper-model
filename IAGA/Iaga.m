%IAGA?
function best=ga
clear
MAX_gen=200;%����������
best.max_f=0;%��ǰ������Ӧ��?STOP_f=14.5;????????????%ֹͣѭ������Ӧ��?
RANGE=[0 255];%��ʼȡֵ��Χ[0?255]?SPEEDUP_INTER=5;???????%������ٵ����ļ��
advance_k=0;%�Ż��Ĵ���?
popus=init;%��ʼ��?for?gen=1:MAX_gen
for gen=1:MAX_gen
    fitness=fit(popus,RANGE);%����Ӧ��????
    f=fitness.f;
    picked=choose(popus,fitness);%ѡ��
    popus=intercross(popus,picked);%�ӽ�?????
    popus=aberrance(popus,picked);%����
    if max(f)>best.max_f
        advance_k=advance_k+1;
        x_better(advance_k)=fitness.x;
        best.max_f=max(f);
        best.popus=popus;
        best.x=fitness.x;
    end
    if mod(advance_k,SPEEDUP_INTER==0)
        RANGE=minmax(x_better);
        RANGE
        advance=0;
    end
end
return;
function popus=init;
M=50;
N=30;
popus=round(rand(M,N));
return;