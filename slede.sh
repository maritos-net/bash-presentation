#!/bin/bash

# スライドのディレクトリ指定
SLIDE_DIR="slides"
CONFIG_FILE="config.txt"

# デフォルトの表示メッセージ
DEFAULT_PROMPT="次のスライドに進むには Enter キーを押してください..."
DEFAULT_END_MESSAGE="すべてのプレゼンテーションが終了しました。このプレゼンテーションはbash-presentationで作成されました。"

# 設定ファイル読み込み処理
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    SLIDE_PROMPT="$DEFAULT_PROMPT"
    SLIDE_END_MESSAGE="$DEFAULT_END_MESSAGE"
fi

# 指定したディレクトリが存在するか確認
if [[ ! -d "$SLIDE_DIR" ]]; then
    echo "エラー: スライド用ディレクトリ '$SLIDE_DIR' が見つかりません。"
    exit 1
fi

# 指定ディレクトリ内のファイルを昇順で取得（.txt ファイルのみ）
slides=($(find "$SLIDE_DIR" -maxdepth 1 -type f -name "*.txt" | sort -V))

# ファイルが見つからない場合の処理
if [[ ${#slides[@]} -eq 0 ]]; then
    echo "エラー: '$SLIDE_DIR' 内にスライド用のテキストファイルが見つかりません。"
    exit 1
fi

# 各スライドを順番に表示するループ
for slide in "${slides[@]}"; do
    clear
    cat "$slide"

    echo
    read -p "$SLIDE_PROMPT"
done

# 全スライドが終わったら終了
clear
echo "$SLIDE_END_MESSAGE"
