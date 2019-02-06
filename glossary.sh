# 正體中文字彙統一工具

# 相關常數
AUTHOR="  程式：pan93412, 2019.
  感謝以下 Telegram 群組人員的貢獻！
    https://t.me/l10n_tw
    https://t.me/translation_zh_hant
  以及這些人員：
    Neo_Chen <chenkolei@gmail.com>, 2019."
VERSION="1.2.1"

DOWNURL="https://github.com/l10n-tw/unity_db/raw/master/"

TMPPATH="~/.cache/"
# ~/.cache/UnityDB
GITTMP="${TMPPATH}UnityDB"

GLOSFILE="glossary_data.sed"
GLOSSARY="$(dirname $0)/$GLOSFILE"

# 統一字串函式
# $1 = filename
function unityString {
    echo -ne "\r正在統一 $1 檔案的字串…     "
    sed -i -f $GLOSSARY $1
}

# 遞迴函式
# $1: 資料夾名稱
function reverse {  
  filename_list=$(find $1 ! -path "*/.git/*" ! -path "*/.svn/*" ! -path "*/_svn/*" -type f)
  # 假如想要排除某個目錄，請增加 `! -path "*/<資料夾名稱>/*"`
  for filename in $filename_list
  do
      unityString "$filename"
  done
}

# 更新函式
# $1: 檔名
# $2: 描述
function update {
  curl -Lso "$(dirname $0)/$1" "${DOWNURL}""$1"
  if [[ "$?" == "127" ]]
  then
    echo "請先在您的電腦上安裝 curl。"
    exit 1
  else
    echo "[完成] $2 更新完成。"
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
      update "$GLOSFILE" "詞彙庫"
      update "glossary.sh" "主程式"
      exit 0
      ;;
    program)
      update "glossary.sh" "主程式"
      exit 0
      ;;
    glossary)
      update "$GLOSFILE" "詞彙庫"
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
    if [[ ! -f $GLOSSARY ]]
    then
      echo "找不到詞彙資料庫。請先執行 $0 --update all。
若不想更新主程式，請改執行 $0 --update glossary，
但建議一併更新主程式，以防止執行 bug。"
      exit 4
    fi
    reverse "$1"
    echo "" # \n
  fi
fi
