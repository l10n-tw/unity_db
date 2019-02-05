# 此為詞彙庫，請勿直接執行

# 如何新增詞彙庫：
# 格式：["要被轉換內容"]="目標文字" # 英文原文
#  e.x ["插件"]="外掛程式" # plugin
#      ["軟件"]="軟體"    # software

# 版本號碼
# 格式：[年年年年][月月][日日]-[本日修訂版]
# ex. 20190205-1
GLOSSARY_VER="20190205-2"

# 字彙資料庫
declare -A glossary=(
    ["插件"]="外掛程式" # plugin
    ["設備"]="裝置"    # device
    ["圖標"]="圖示"    # icon
    ["配置"]="設定"    # config, configure
    ["字體"]="字型"    # font (因為 font 和 typeface 的界線已經模糊，且譯者可能會搞混其中差別。)
    ["數據"]="資料"    # data
    ["鼠標"]="游標"    # cursor
    ["遊標"]="游標"    # cursor
    ["組件"]="元件"    # compoment
    ["點擊"]="按一下"  # click，參考微軟翻譯。
    ["你"]="您"       # you
    ["妳"]="您"       # you
)