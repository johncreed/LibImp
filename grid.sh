
ocmf_det(){
logs_path='logs/ocmf.det'
mkdir -p $logs_path
for k in 8 16 32 64
do
    for l in 1 0.1 0.01 0.001 0.0001
    do
        for w in 1 0.1 0.01 0.001
        do
            for a in 1.8
            do
                echo "./train -l $l -w $w -a $a -k ${k} -t 100 -c 4 -p yh.va yh.f.tr > $logs_path/yh.$k.$l.$w.$a.det.oc" >> .task.tmp
            done
        done
    done
done
}

IPS_det(){
logs_path='logs/IPS.det'
mkdir -p $logs_path
for k in 8 16 32 64
do
    for l in 1 0.1 0.01 0.001 0.0001
    do
        echo "./train -l $l -w 0 -a 0 -k $k -t 100 -c 4 --weighted -p yh.va yh.f.tr.ps > $logs_path/yh.$k.$l.det.ps" >> .task.tmp
    done
done
}

mf_det(){
logs_path='logs/mf.det'
mkdir -p $logs_path
for k in 8 16 32 64
do
    for l in 1 0.1 0.01 0.001 0.0001
    do
        echo "./train -l $l -w 0 -a 0 -k ${k} -t 100 -c 4 -p yh.va yh.f.tr > $logs_path/yh.$k.$l.det" >> .task.tmp
    done
done
}

# =========================================== #


# Clear jobs
rm -f .task.tmp
# Config jobs
ocmf_det
IPS_det
mf_det
# Run
#cat .task.tmp
cat .task.tmp | xargs -P 5 -I {} sh -c {} &

exit

# =========================================== #

