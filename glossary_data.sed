# 此為詞彙庫，請勿直接執行
#
# 如何新增詞彙庫：
# 格式：s/要被轉換內容/目標文字/g # 英文原文
# e.x: s/插件/外掛程式/g # plugin
#      s/軟件/軟體/g    # software
# 支援 Regex (Perl)。
#
# 保護部份只需將該字串想盡辦法不被修改即可。
# 但記得在「解除保護部份」還原成原始字串。

# 版本號碼：20190206-1
# 格式：[年年年年][月月][日日]-[本日修訂版]

# 保護部份

# 轉換部份
1,$ {
s/(擴展|)插件/外掛程式/g  # plugin
s/設備/裝置/g  # device
s/(?!檢)視圖/檢視/g  # view
s/(?!地)圖標(?!記|紀|題|提|示)/圖示/g  # icon，排除「地圖」、和「標記/紀/題/提/示」
s/字體/字型/g  # font (因為 font 和 typeface 的界線已經模糊，且譯者可能會搞混其中差別。)
s/(?!行動)數據(?!機)/資料/g  # data，排除「行動數據」和「數據機」
s/(?!滑)(遊|鼠)標/游標/g  # cursor
s/組件/元件/g  # compoment
s/點擊(時|)/點選/g  # click
s/(你|妳)/您/g  # you
s/特別檔案/特殊檔案/g  # special file
s/相依性/依賴關係/g  # dependent
s/相依/依賴/g  # depend
s/搜索/搜尋/g  # search
s/命令稿/指令碼/g  # script
s/命令/指令/g  # command
s/當前/目前/g  # current
s/引數/參數/g  # argument, parameter
s/不明/未知/g  # unknown
s/KDE( |)連線/KDE Connect /g  # KDE Connect
s/自定義/自訂/g  # customize, custom
s/剪貼板/剪貼簿/g  # clipboard
s/套件庫/軟體庫/g  # repository
s/(高亮|突顯|反白(?!顯示))/反白顯示/g  # highlight
s/衕步/同步/g  # sync
s/偵錯/除錯/g  # debug
s/鏈結/連結/g  # link
s/正確安裝/安裝正確/g  # installed properly
s/(更改|更變)/變更/g  # edit
s/本地/本機/g  # local
s/運行/執行/g  # execute, run
s/于/於/g  # 簡->繁
s/彩現/渲染/g  # render
s/用戶/使用者/g  # user
s/令牌/權杖/g  # token
s/(後置字元|後綴)/後置詞/g  # suffix
s/(前置字元|前綴)/前置詞/g  # prefix

# 復原改錯部份
s/定義未知/定義不明/g
s/鉛字型/鉛字體/g  # typeface

# 錯字修正
s/啟始/起始/g  # Start

# 解除保護部份
}
