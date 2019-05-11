

CausE_det(){
logs_path='logs/CausE.det'
mkdir -p $logs_path
for k in 8 16 32 64
do
    for lt in 1 0.1 0.01 0.001 0.0001
    do
        for lc in 1 0.1 0.01 0.001 0.0001
        do
            for ldiff in 1 0.1 0.01 0.001 0.0001
            do
                echo "./train -lt $lt -lc $lc -ldiff ${ldiff} -w 0 -a 0 -k ${k} -t 100 -c 4 -p yh.va yh.f.tr > $logs_path/yh.$k.$lt.$lc.${ldiff}.det" >> .task.tmp
            done
        done
    done
done
}

# =========================================== #


# Clear jobs
rm -f .task.tmp
# Config jobs
CausE_det
# Run
#cat .task.tmp
cat .task.tmp | xargs -P 5 -I {} sh -c {} &

exit

# =========================================== #

