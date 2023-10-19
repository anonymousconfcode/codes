set -e

scale=$1
dataset_name=$2
device=$3

llm_path="seeklhy/codes-$scale"

if [ $dataset_name = "spider" ]
then
    sic_path="sic_ckpts/sic_spider"
    llm_path="seeklhy/codes-$scale-spider"
    dataset_path="data/sft_spider_dev_text2sql.json"
elif [ $dataset_name = "spider_dk" ]
then
    sic_path="sic_ckpts/sic_spider"
    llm_path="seeklhy/codes-$scale-spider"
    dataset_path="data/sft_spider_dk_text2sql.json"
elif [ $dataset_name = "spider_syn" ]
then
    sic_path="sic_ckpts/sic_spider"
    llm_path="seeklhy/codes-$scale-spider"
    dataset_path="data/sft_spider_syn_text2sql.json"
elif [ $dataset_name = "spider_realistic" ]
then
    sic_path="sic_ckpts/sic_spider"
    llm_path="seeklhy/codes-$scale-spider"
    dataset_path="data/sft_spider_realistic_text2sql.json"
elif [ $dataset_name = "dr_spider" ]
then
    sic_path="sic_ckpts/sic_spider"
    llm_path="seeklhy/codes-$scale-spider"
    dataset_path="data/sft_dr_spider_text2sql.json"
elif [ $dataset_name = "bird" ]
then
    sic_path="sic_ckpts/sic_bird"
    llm_path="seeklhy/codes-$scale-bird"
    dataset_path="data/sft_bird_dev_text2sql.json"
elif [ $dataset_name = "bird_with_evidence" ]
then
    sic_path="sic_ckpts/sic_bird_with_evidence"
    llm_path="seeklhy/codes-$scale-bird-with-evidence"
    dataset_path="data/sft_bird_with_evidence_dev_text2sql.json"
elif [ $dataset_name = "bank" ]
then
    sic_path="sic_ckpts/sic_bird"
    llm_path="seeklhy/codes-7b-bank"
    dataset_path="data/sft_bank_financials_dev_text2sql.json"
elif [ $dataset_name = "aminer" ]
then
    sic_path="sic_ckpts/sic_bird"
    llm_path="seeklhy/codes-7b-aminer"
    dataset_path="data/sft_aminer_simplified_dev_text2sql.json"
elif [ $dataset_name = "bank_merged" ]
then
    sic_path="sic_ckpts/sic_bird"
    llm_path="seeklhy/codes-7b-merged"
    dataset_path="data/sft_bank_financials_dev_text2sql.json"
elif [ $dataset_name = "aminer_merged" ]
then
    sic_path="sic_ckpts/sic_bird"
    llm_path="seeklhy/codes-7b-merged"
    dataset_path="data/sft_aminer_simplified_dev_text2sql.json"
else
    echo "The second arg must in [spider, spider_dk, spider_syn, spider_realistic, dr_spider, bird, bird_with_evidence, bank, aminer]."
    exit
fi

CUDA_VISIBLE_DEVICES=$device python -u text2sql_zero_shot.py \
    --llm_path $llm_path \
    --sic_path $sic_path \
    --table_num 6 \
    --column_num 10 \
    --dataset_path $dataset_path \
    --max_tokens 4096 \
    --max_new_tokens 256
