# 正體中文字彙統一工具

# 相關變數
AUTHOR="  程式：pan93412
  感謝以下 Telegram 群組人員的貢獻！
    https://t.me/l10n_tw
    https://t.me/translation_zh_hant"
VERSION="1.0.0"
GLOSSARY_URL="https://github.com/l10n-tw/unity_db/raw/master/glossary_data.sh"
GITURL="https://github.com/l10n-tw/unity_db"
GITSSH="git@github.com:l10n-tw/unity_db.git"
GITTMP="~/.cache/glossary_tmp"

# 統一字串函式
# $1 = fromList
# $2 = to
# $3 = filename
function unityString {
    for from in $1
    do
      echo -ne "\r正在統一 $3 檔案的 $from 字串至 $2               "
      sed -ri "s/$from/$2/g" $3
    done
}

# 遞迴函式
function reverse {
  # 載入字彙資料庫
  source glossary_data.sh
  
  # 假如想要排除某個目錄，請增加 `! -path "*/<資料夾名稱>/*"`
  export toConvertFile=$(find $1 ! -path "*/.git/*" ! -path "*/.svn/*" ! -path "*/_svn/*" -type f)

  for filename in $toConvertFile
  do
    export IFS=$(echo -ne "\r")
    for fromOrderID in ${!glossary_order[*]}
    do
      fromOrder=${glossary_order[$fromOrderID]}
      to=${glossary[$fromOrder]}
      unityString "$fromOrder" "$to" "$filename"
    done
    export IFS=" "
  done
  export -n toConvertFile
}

# 主程式
if [[ "$1" == "" ]]
then
  echo "正體中文字彙統一工具
作者：
${AUTHOR}
版本：${VERSION}（字彙版本：${GLOSSARY_VER}）

用法：$0 [資料夾名稱]
或：$0 --update (更新詞彙資料庫)
或：$0 --push [模式] (推送到 Git 版本庫)
   <模式> 可為 ssh 或 http。

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
  curl -Lso glossary_data.sh "${GLOSSARY_URL}"
  if [[ "$?" == "127" ]]
  then
    echo "請先在您的電腦上安裝 curl。"
    exit 1
  else
    # 載入詞彙資料庫
    source glossary_data.sh
    echo "更新完成。詞彙庫已更新到 $GLOSSARY_VER 版。"
    exit 0
  fi
elif [[ "$1" == "--push" ]]
then
  # 載入詞彙資料庫
  source glossary_data.sh
  
  # 檢查是否有 ~/.cache 資料夾
  if [ ! -d ~/.cache ]
  then
    mkdir ~/.cache
  fi
  
  rm -rf $GITTMP
  
  # 模式
  if [[ "$2" == "ssh" ]]
  then
    git clone --depth 1 $GITSSH $GITTMP
  elif [[ "$2" == "http" ]]
  then
    git clone --depth 1 $GITURL $GITTMP
  else
    echo "<模式> 無效。"
    exit 3
  fi
  
  cp -f "./glossary_data.sh" $GITTMP
  currentPath=$(pwd)
  
  # 切換工作目錄
  cd $GITTMP
  git add -A
  git commit -m "更新詞彙資料庫至 $GLOSSARY_VER"
  git push origin master
  
  # 復位
  cd $currentPath
  rm -rf $GITTMP
  
  echo "上傳完成！"
  exit 0
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
