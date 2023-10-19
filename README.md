# CodeS: Towards Building Open-source Language Models for Text-to-SQL

**CodeS** is a series of **Code** LLMs specifically pre-trained for text-to-**S**QL. CodeS is **incrementally pre-trained** based on StarCoder using a large SQL-centric corpus. 

The CodeS series encompasses four distinct scales: 1B, 3B, 7B, and 15B. CodeS-1B, 3B, and 7B are based on StarCoderBase-1B, 3B, and 7B and support the max length of 8,192. Meanwhile, CodeS-15B, derived from StarCoder-15B, accommodates sequences of up to 6,144 tokens due to computational constraints.

## Reproduce our results
You can effortlessly replicate the results by utilizing the checkpoints and scripts we've released.

### Step1: prepare environments
First, you should create the Anaconda environment and install the required modules:
```
conda create -n codes python=3.8.5
conda activate codes
conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7 -c pytorch -c nvidia
pip install -r requirements.txt
```
Then, you'll need to install SimCSE, a tool employed for retrieving relevant demonstrations in the few-shot in-context learning:
```
cd SimCSE
python setup.py install
cd ..
```
Lastly, make sure to download the datasets [data.zip](https://drive.google.com/file/d/1y_s5xoeiHk3OawA3gRk1vXhqDf2iqL-L/view?usp=sharing), the schema item classifier checkpoints [sic_ckpts.zip](https://drive.google.com/file/d/19JEC5Ld2Q6K80pUhFOGVCVHMD6t2eupc/view?usp=sharing), and Spider's evaluation scripts [test_suite_sql_eval.zip](https://drive.google.com/file/d/1HIKBL7pP_hzWH1ryRNsjPO-N__UluOlK/view?usp=sharing). Once downloaded, simply unzip these files in the root folder.
```
unzip data.zip
unzip sic_ckpts.zip
unzip test_suite_sql_eval.zip
```

### Step2: run inference scripts
**Few-shot CodeS**

We provide a script to run the few-shot CodeS:
```
sh scripts/few_shot.sh $scale $dataset_name $num_of_demonstrations $device
```
The arguments can be selected from the following choices:
- `$scale`: {1b, 3b, 7b, 15b}
- `$dataset_name`: {spider, bird, bird_with_evidence, bank, aminer}
- `$num_of_demonstrations`: {1, 3, 5}
- `$device`: {0, 1, ...}

**Supervised Fine-tuned (SFT) CodeS**

We also provide another script to run the SFT CodeS:
```
sh scripts/sft.sh $scale $dataset_name $device
```
The arguments can be selected from the following choices:
- `$scale`: {1b, 3b, 7b, 15b}
- `$dataset_name`: {spider, spider_dk, spider_syn, spider_realistic, dr_spider, bird, bird_with_evidence, bank, aminer, bank_merged, aminer_merged}
- `$device`: {0, 1, ...}

As we described in the paper, we highlighted that for `bank, aminer, bank_merged, and aminer_merged`, we opted to fine-tune only CodeS-7B. This choice represents an optimal balance between performance and developmental expenses.