set -e

scale=$1
dataset_name=$2
num_of_demonstrations=$3
device=$4

if [ $scale = "1b" ] || [ $scale = "3b" ] || [ $scale = "7b" ]
then
    max_tokens=8192
elif [ $scale = "15b" ]
then
    max_tokens=6144
else
    echo "The first arg must in [1b, 3b, 7b, 15b]."
    exit
fi

llm_path="seeklhy/codes-$scale"

if [ $dataset_name = "spider" ]
then
    sic_path="sic_ckpts/sic_spider"
    dataset_path="data/sft_spider_dev_text2sql.json"
    demonstration_set_path="data/sft_spider_train_text2sql.json"
elif [ $dataset_name = "bird" ]
then
    sic_path="sic_ckpts/sic_bird"
    dataset_path="data/sft_bird_dev_text2sql.json"
    demonstration_set_path="data/sft_bird_train_text2sql.json"
elif [ $dataset_name = "bird_with_evidence" ]
then
    sic_path="sic_ckpts/sic_bird_with_evidence"
    dataset_path="data/sft_bird_with_evidence_dev_text2sql.json"
    demonstration_set_path="data/sft_bird_with_evidence_train_text2sql.json"
elif [ $dataset_name = "bank" ]
then
    sic_path="sic_ckpts/sic_bird"
    dataset_path="data/sft_bank_financials_dev_text2sql.json"
    demonstration_set_path="data/sft_bank_financials_few_shot_train_text2sql.json"
elif [ $dataset_name = "aminer" ]
then
    sic_path="sic_ckpts/sic_bird"
    dataset_path="data/sft_aminer_simplified_dev_text2sql.json"
    demonstration_set_path="data/sft_aminer_simplified_few_shot_train_text2sql.json"
else
    echo "The second arg must in [spider, bird, bird_with_evidence, bank, aminer]."
    exit
fi

CUDA_VISIBLE_DEVICES=$device python -u text2sql_few_shot.py \
    --llm_path $llm_path \
    --sic_path $sic_path \
    --table_num 5 \
    --column_num 6 \
    --dataset_path $dataset_path \
    --demonstration_set_path $demonstration_set_path \
    --num_of_demonstrations $num_of_demonstrations \
    --max_tokens $max_tokens \
    --max_new_tokens 256
