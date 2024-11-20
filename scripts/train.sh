NPROC_PER_NODE=8 \
MASTER_PORT=29511 \
USE_HF=1 \
swift sft \
    --model_id_or_path deepseek-ai/deepseek-coder-6.7b-base \
    --sft_type full \
    --template_type AUTO \
    --dtype AUTO \
    --output_dir output \
    --dataset ./data/oss-train-38k.jsonl \
    --num_train_epochs 2 \
    --max_length 2048 \
    --check_dataset_strategy warning \
    --gradient_checkpointing true \
    --batch_size 24 \
    --weight_decay 0.1 \
    --learning_rate 1e-5 \
    --gradient_accumulation_steps 2 \
    --max_grad_norm 0.5 \
    --warmup_steps 15 \
    --eval_steps 50 \
    --save_only_model true \
    --save_total_limit 2 \
    --logging_steps 10 \
    --use_flash_attn true \
    --preprocess_num_proc 8 \
    --deepspeed 'default-zero2'