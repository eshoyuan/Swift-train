sh scripts/train.sh


CKPT_PATH=$(ls -d output/v0-*/checkpoint-* | sort -V | tail -n 1)
TARGET_PATH="result/"


swift infer \
--ckpt_dir "$CKPT_PATH" \
--val_dataset "./data/test.jsonl" \
--infer_backend vllm \
--max_new_tokens 2048 \
--max_model_len 4096

INFER_RESULT_PATH="${CKPT_PATH}/infer_result"

if [ -d "$INFER_RESULT_PATH" ]; then
  # Find the jsonl file inside the infer_result directory
  JSONL_FILE=$(find "$INFER_RESULT_PATH" -name "*.jsonl" | head -n 1)
  
  if [ -n "$JSONL_FILE" ]; then
    # Copy the jsonl file to the target path
    echo "Copying $JSONL_FILE to $TARGET_PATH"
    cp "$JSONL_FILE" "$TARGET_PATH"
  else
    echo "No jsonl file found in $INFER_RESULT_PATH."
  fi
else
  echo "infer_result folder not found in $CKPT_PATH."
fi

# clean output folder
rm -rf output