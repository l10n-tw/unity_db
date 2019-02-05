# 正體中文字彙統一工具

# 相關常數
AUTHOR="  程式：pan93412
  感謝以下 Telegram 群組人員的貢獻！
    https://t.me/l10n_tw
    https://t.me/translation_zh_hant"
VERSION="1.1.0"

DOWNURL="https://github.com/l10n-tw/unity_db/raw/master/"

TMPPATH="~/.cache/"
GITTMP="${TMPPATH}UnityDB"

# 統一字串函式
# $1 = replace_list
# $2 = filename
function unityString {
    for from in $1
    do
      echo -ne "\r正在統一 $2 檔案的字串…         "
      bash -c "exec sed -r$1 $2"
    done
}

# 遞迴函式
function reverse {
  # 載入字彙資料庫
  source glossary_data.sh

  export toUnity=""
  export IFS=$'\n'
  for fromOrderID in ${!glossary_order[*]}
  do
    from=${glossary_order[$fromOrderID]}
    to=${glossary[$from]}
    
    export toUnity="$toUnity -i 's/$from/$to/g'"
  done
  
  export IFS=" "
  # 假如想要排除某個目錄，請增加 `! -path "*/<資料夾名稱>/*"`
  for filename in $(find $1 ! -path "*/.git/*" ! -path "*/.svn/*" ! -path "*/_svn/*" -type f)
  do
      unityString "$toUnity" "$filename"
  done
  
  export -n toUnity
}

# 更新函式
function update {
  curl -Lso $1 "${DOWNURL}""$1"
  if [[ "$?" == "127" ]]
  then
    echo "請先在您的電腦上安裝 curl。"
    exit 1
  else
    # 載入詞彙資料庫
    source glossary_data.sh
    echo "[完成] $2 更新完成。"
    exit 0
  fi
}

# 主程式
if [[ "$1" == "" ]]
then
  echo "正體中文字彙統一工具
作者：
${AUTHOR}
版本：${VERSION}（字彙版本：${GLOSSARY_VER}）

用法：$0 [資料夾名稱]
或：$0 --update [更新項目] (更新)
   <更新項目> 可為 all (全部更新)、program (僅更新主程式)、
             glossary (僅更新詞彙庫)。

若您目前沒有 Git 版本庫的存取權限，以下為幾個您可以
上傳字彙資料庫的地方：
  Telegram: https://t.me/l10n_tw     (正體中文化群組)
            https://t.me/byStarTW_TW (作者)
  Gmail:    pan93412@gmail.com       (作者)
  GitHub:   請 clone 以下版本庫，推送新字彙資料庫之後建立 Pull Request：
            $GITURL
"
elif [[ "$1" == "--update" ]]
then
  case $2 in
    all)
      update "glossary_data.sh" "詞彙庫"
      update "glossary.sh" "主程式"
      exit 0
      ;;
    program)
      update "glossary.sh" "主程式"
      exit 0
      ;;
    glossary)
      update "glossary_data.sh" "詞彙庫"
      exit 0
      ;;
    *)
      echo "<更新項目> ($2) 無效。"
      exit 1
      ;;
  esac
else
  if [[ ! -d $1 ]]
  then
    echo "找不到資料夾「$1」。"
    exit 2
  else
    if [[ ! -f glossary_data.sh ]]
    then
      echo "找不到詞彙資料庫。請先執行 $0 --update。"
      exit 4
    fi
    reverse "$1"
    echo "" # \n
  fi
fi
