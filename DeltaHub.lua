-- Delta Hub | by Claude | v3.0
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ======= CAMINHOS =======
local SAVE_PATH    = "DeltaHub/"
local SCRIPTS_PATH = "DeltaHub/scripts/"
local CONFIG_FILE  = "DeltaHub/config.json"

if not isfolder(SAVE_PATH)    then makefolder(SAVE_PATH) end
if not isfolder(SCRIPTS_PATH) then makefolder(SCRIPTS_PATH) end

-- ======= SCRIPTS =======
local function saveScript(name, code)
    writefile(SCRIPTS_PATH .. name .. ".lua", code)
end
local function deleteScript(name)
    local p = SCRIPTS_PATH .. name .. ".lua"
    if isfile(p) then delfile(p) end
end
local function getAllScripts()
    local t = {}
    for _, path in pairs(listfiles(SCRIPTS_PATH)) do
        local name = path:gsub(SCRIPTS_PATH,""):gsub("%.lua$","")
        table.insert(t, {name=name, code=readfile(path)})
    end
    return t
end

-- ======= CONFIG =======
local function saveConfig(lang, border)
    writefile(CONFIG_FILE, '{"lang":"'..lang..'","border":"'..border..'"}')
end
local function loadConfig()
    if isfile(CONFIG_FILE) then
        local ok, d = pcall(readfile, CONFIG_FILE)
        if ok then
            return d:match('"lang":"([^"]+)"') or "pt_BR",
                   d:match('"border":"([^"]+)"') or "rgb"
        end
    end
    return "pt_BR", "rgb"
end

-- ======= TRADUÇÕES =======
local TRANSLATIONS = {
    pt_BR = {
        hub_title="📁 Delta Hub", config_title="⚙️ Configurações",
        btn_new="+", btn_config="⚙️",
        empty="Nenhum script salvo.\nClique em  +  para adicionar!",
        editor_new="✏️ Novo Script", editor_edit="✏️ Editando: ",
        editor_name_label="Nome do Script:", editor_code_label="Código (Lua):",
        editor_name_ph="Ex: MeuFly_v2", editor_code_ph="-- Cole seu script aqui...",
        btn_save="💾 Salvar", btn_cancel="✕ Cancelar", btn_run="▶ Executar",
        lang_btn="🌐 Idioma", color_btn="🎨 Cor da Borda",
        daynight_btn="🌙 Mudar para Noite", daynight_day="☀️ Mudar para Dia",
        fps_btn="⚡ FPS Boost", fps_on="⚡ FPS Boost: ON ✓",
        ping_btn="🏓 Ver Ping",
        notif_ping="🏓 Ping: ", notif_ping_err="❌ Ping indisponível",
        notif_saved="💾 Salvo: ", notif_deleted="🗑 Deletado: ",
        notif_executed="▶ Executado: ", notif_error="❌ Erro no script!",
        notif_warn_name="⚠️ Dê um nome ao script!",
        notif_warn_code="⚠️ O código está vazio!",
        notif_night="🌙 Boa noite!", notif_day="☀️ Bom dia!",
        notif_fps_on="⚡ FPS Boost ativado!", notif_fps_off="FPS Boost desativado",
        notif_color="🎨 Cor alterada!", notif_loaded="📁 Delta Hub carregado!",
        notif_lang_saved="🌐 Idioma salvo!", notif_custom_color="🎨 Cor personalizada!",
        lang_window_title="🌐 Selecionar Idioma",
        lang_confirm="✔ Confirmar", lang_search_btn="🔍 Pesquisar",
        search_ph="Pesquisar idioma...", search_window_title="🔍 Pesquisar Idioma",
        search_btn_go="Pesquisar",
        color_window_title="🎨 Cor da Borda",
        color_rgb="🌈 RGB (padrão)", color_orange="🟠 Laranja",
        color_blue="🔵 Azul", color_green="🟢 Verde",
        color_red="🔴 Vermelho", color_off="⬜ Desativado",
        color_adv="🎨 Avançado", color_use="Usar", color_active="✓ Ativo",
        palette_title="🎨 Cor Avançada", palette_close="✕ Fechar",
        loading="Carregando...",
        card_run="▶", card_edit="✏", card_delete="🗑",
        community_title="🌐 コミュニティ",
        community_new="＋ 新しい公開スクリプト",
        community_empty="スクリプトなし。最初に投稿しよう！",
        community_loading="読み込み中...",
        pub_title="📤 スクリプト公開",
        pub_name="名前:",
        pub_name_ph="例: フライハック v2",
        pub_code="コード (Lua):",
        pub_code_ph="-- ここに貼り付け...",
        pub_game="ゲームID (任意):",
        pub_game_ph="例: 142823291",
        pub_tags="機能:",
        pub_btn="📤 公開",
        pub_cancel="✕ キャンセル",
        pub_warn_name="⚠️ 名前を入力!",
        pub_warn_code="⚠️ コードが空!",
        pub_warn_junk="⚠️ 無効なスクリプト!",
        pub_ok="✅ 公開完了!",
        pub_err="❌ エラー!",
        exec_title="▶ スクリプト実行",
        exec_confirm="▶ 実行",
        exec_cancel="✕ キャンセル",
        exec_ok="✅ 実行完了!",
        exec_err="❌ エラー!",
        report_title="🚨 通報",
        report_confirm="🚨 通報する",
        report_cancel="✕ キャンセル",
        report_ok="✅ 通報完了!",
        comment_title="💬 コメント",
        comment_ph="コメントを書く...",
        comment_send="送信",
        comment_warn="⚠️ コメントが空!",
        comment_warn_link="⚠️ リンク不可!",
        comment_ok="✅ コメント送信!",
        stars_title="⭐ 評価",
        stars_own="⚠️ 自分のスクリプトは評価不可!",
        stars_ok="✅ 評価完了!",
        game_info_title="🎮 ゲーム情報",
        btn_exec="▶",
        btn_comment="💬",
        btn_report="🚨",
        btn_stars="⭐",
        tag_key="🔑 Key",
        tag_autofarm="🌾 Auto Farm",
        tag_esp="👁 ESP",
        tag_fly="🕊 Fly",
        tag_speed="⚡ Speed",
        tag_noclip="👻 NoClip",
        tag_inf_jump="🦘 Inf Jump",
        tag_aimbot="🎯 Aimbot",
        tag_kill_all="💀 Kill All",
        tag_god="🛡 God Mode",
        tag_tp="🌀 Teleport",
        tag_free="✅ Free",
        community_title="🌐 Comunidad",
        community_new="＋ Nuevo Script Público",
        community_empty="Sin scripts publicados. ¡Sé el primero!",
        community_loading="Cargando scripts...",
        pub_title="📤 Publicar Script",
        pub_name="Nombre:",
        pub_name_ph="Ej: Fly Hack v2",
        pub_code="Código (Lua):",
        pub_code_ph="-- Pega tu script aquí...",
        pub_game="ID del Juego (opcional):",
        pub_game_ph="Ej: 142823291",
        pub_tags="Funciones:",
        pub_btn="📤 Publicar",
        pub_cancel="✕ Cancelar",
        pub_warn_name="⚠️ Escribe un nombre!",
        pub_warn_code="⚠️ El código está vacío!",
        pub_warn_junk="⚠️ Script inválido!",
        pub_ok="✅ ¡Script publicado!",
        pub_err="❌ Error al publicar!",
        exec_title="▶ Ejecutar Script",
        exec_confirm="▶ Ejecutar",
        exec_cancel="✕ Cancelar",
        exec_ok="✅ ¡Ejecutado!",
        exec_err="❌ Error!",
        report_title="🚨 Denunciar Script",
        report_confirm="🚨 Denunciar",
        report_cancel="✕ Cancelar",
        report_ok="✅ Denuncia enviada!",
        comment_title="💬 Comentarios",
        comment_ph="Escribe un comentario...",
        comment_send="Enviar",
        comment_warn="⚠️ Comentario vacío!",
        comment_warn_link="⚠️ ¡Links no permitidos!",
        comment_ok="✅ Comentario enviado!",
        stars_title="⭐ Calificar Script",
        stars_own="⚠️ No puedes calificar tu script!",
        stars_ok="✅ Calificación enviada!",
        game_info_title="🎮 Info del Juego",
        btn_exec="▶",
        btn_comment="💬",
        btn_report="🚨",
        btn_stars="⭐",
        tag_key="🔑 Key",
        tag_autofarm="🌾 Auto Farm",
        tag_esp="👁 ESP",
        tag_fly="🕊 Fly",
        tag_speed="⚡ Speed",
        tag_noclip="👻 NoClip",
        tag_inf_jump="🦘 Inf Jump",
        tag_aimbot="🎯 Aimbot",
        tag_kill_all="💀 Kill All",
        tag_god="🛡 God Mode",
        tag_tp="🌀 Teleport",
        tag_free="✅ Free",
        community_title="🌐 Community",
        community_new="＋ New Public Script",
        community_empty="No scripts published yet. Be the first!",
        community_loading="Loading scripts...",
        pub_title="📤 Publish Script",
        pub_name="Script Name:",
        pub_name_ph="Ex: Fly Hack v2",
        pub_code="Code (Lua):",
        pub_code_ph="-- Paste your script here...",
        pub_game="Game ID (optional):",
        pub_game_ph="Ex: 142823291",
        pub_tags="Features:",
        pub_btn="📤 Publish",
        pub_cancel="✕ Cancel",
        pub_warn_name="⚠️ Enter a script name!",
        pub_warn_code="⚠️ The code is empty!",
        pub_warn_junk="⚠️ Invalid or empty script!",
        pub_ok="✅ Script published!",
        pub_err="❌ Publish error!",
        exec_title="▶ Execute Script",
        exec_confirm="▶ Execute",
        exec_cancel="✕ Cancel",
        exec_ok="✅ Executed!",
        exec_err="❌ Execution error!",
        report_title="🚨 Report Script",
        report_confirm="🚨 Report",
        report_cancel="✕ Cancel",
        report_ok="✅ Report sent!",
        comment_title="💬 Comments",
        comment_ph="Write a comment...",
        comment_send="Send",
        comment_warn="⚠️ Empty comment!",
        comment_warn_link="⚠️ Links are not allowed!",
        comment_ok="✅ Comment sent!",
        stars_title="⭐ Rate Script",
        stars_own="⚠️ You can't rate your own script!",
        stars_ok="✅ Rating sent!",
        game_info_title="🎮 Game Info",
        btn_exec="▶",
        btn_comment="💬",
        btn_report="🚨",
        btn_stars="⭐",
        tag_key="🔑 Key",
        tag_autofarm="🌾 Auto Farm",
        tag_esp="👁 ESP",
        tag_fly="🕊 Fly",
        tag_speed="⚡ Speed",
        tag_noclip="👻 NoClip",
        tag_inf_jump="🦘 Inf Jump",
        tag_aimbot="🎯 Aimbot",
        tag_kill_all="💀 Kill All",
        tag_god="🛡 God Mode",
        tag_tp="🌀 Teleport",
        tag_free="✅ Free",
        community_title="🌐 Comunidade",
        community_new="＋ Novo Script Público",
        community_empty="Nenhum script publicado ainda. Seja o primeiro!",
        community_loading="Carregando scripts...",
        pub_title="📤 Publicar Script",
        pub_name="Nome do Script:",
        pub_name_ph="Ex: Fly Hack v2",
        pub_code="Código (Lua):",
        pub_code_ph="-- Cole seu script aqui...",
        pub_game="ID do Jogo (opcional):",
        pub_game_ph="Ex: 142823291",
        pub_tags="Funcionalidades:",
        pub_btn="📤 Publicar",
        pub_cancel="✕ Cancelar",
        pub_warn_name="⚠️ Dê um nome ao script!",
        pub_warn_code="⚠️ O código está vazio!",
        pub_warn_junk="⚠️ Script inválido ou sem conteúdo!",
        pub_ok="✅ Script publicado!",
        pub_err="❌ Erro ao publicar!",
        exec_title="▶ Executar Script",
        exec_confirm="▶ Executar",
        exec_cancel="✕ Cancelar",
        exec_ok="✅ Executado!",
        exec_err="❌ Erro ao executar!",
        report_title="🚨 Denunciar Script",
        report_confirm="🚨 Denunciar",
        report_cancel="✕ Cancelar",
        report_ok="✅ Denúncia enviada!",
        comment_title="💬 Comentários",
        comment_ph="Escreva um comentário...",
        comment_send="Enviar",
        comment_warn="⚠️ Comentário vazio!",
        comment_warn_link="⚠️ Links não são permitidos!",
        comment_ok="✅ Comentário enviado!",
        stars_title="⭐ Avaliar Script",
        stars_own="⚠️ Você não pode avaliar seu próprio script!",
        stars_ok="✅ Avaliação enviada!",
        game_info_title="🎮 Info do Jogo",
        btn_exec="▶",
        btn_comment="💬",
        btn_report="🚨",
        btn_stars="⭐",
        tag_key="🔑 Key",
        tag_autofarm="🌾 Auto Farm",
        tag_esp="👁 ESP",
        tag_fly="🕊 Fly",
        tag_speed="⚡ Speed",
        tag_noclip="👻 NoClip",
        tag_inf_jump="🦘 Inf Jump",
        tag_aimbot="🎯 Aimbot",
        tag_kill_all="💀 Kill All",
        tag_god="🛡 God Mode",
        tag_tp="🌀 Teleport",
        tag_free="✅ Free",
        games_title="🎮 Jogos", games_back="◀ Voltar",
        game_iy="📍 Infinite Yield",
        game_iy_script="Admin Commands",
        game_iy_tag="✨ DESTAQUE",
        game_mm2="🔪 Murder Mystery 2", game_yarhm="YARHM - sem chave",
        game_run="▶ Executar", game_cancel="✕ Cancelar",
        game_confirm_title="🔪 YARHM - MM2",
        game_executing="⚡ Executando...",
        game_executed="✅ Script executado!", game_error="❌ Erro ao executar!",
    },
    en_US = {
        hub_title="📁 Delta Hub", config_title="⚙️ Settings",
        btn_new="+", btn_config="⚙️",
        empty="No scripts saved.\nClick  +  to add one!",
        editor_new="✏️ New Script", editor_edit="✏️ Editing: ",
        editor_name_label="Script Name:", editor_code_label="Code (Lua):",
        editor_name_ph="Ex: MyFly_v2", editor_code_ph="-- Paste your script here...",
        btn_save="💾 Save", btn_cancel="✕ Cancel", btn_run="▶ Execute",
        lang_btn="🌐 Language", color_btn="🎨 Border Color",
        daynight_btn="🌙 Switch to Night", daynight_day="☀️ Switch to Day",
        fps_btn="⚡ FPS Boost", fps_on="⚡ FPS Boost: ON ✓",
        ping_btn="🏓 View Ping",
        notif_ping="🏓 Ping: ", notif_ping_err="❌ Ping unavailable",
        notif_saved="💾 Saved: ", notif_deleted="🗑 Deleted: ",
        notif_executed="▶ Executed: ", notif_error="❌ Script error!",
        notif_warn_name="⚠️ Enter a script name!",
        notif_warn_code="⚠️ The code is empty!",
        notif_night="🌙 Good night!", notif_day="☀️ Good morning!",
        notif_fps_on="⚡ FPS Boost enabled!", notif_fps_off="FPS Boost disabled",
        notif_color="🎨 Color changed!", notif_loaded="📁 Delta Hub loaded!",
        notif_lang_saved="🌐 Language saved!", notif_custom_color="🎨 Custom color!",
        lang_window_title="🌐 Select Language",
        lang_confirm="✔ Confirm", lang_search_btn="🔍 Search",
        search_ph="Search language...", search_window_title="🔍 Search Language",
        search_btn_go="Search",
        color_window_title="🎨 Border Color",
        color_rgb="🌈 RGB (default)", color_orange="🟠 Orange",
        color_blue="🔵 Blue", color_green="🟢 Green",
        color_red="🔴 Red", color_off="⬜ Disabled",
        color_adv="🎨 Advanced", color_use="Use", color_active="✓ Active",
        palette_title="🎨 Advanced Color", palette_close="✕ Close",
        loading="Loading...",
        card_run="▶", card_edit="✏", card_delete="🗑",
        games_title="🎮 Games", games_back="◀ Back",
        game_iy="📍 Infinite Yield",
        game_iy_script="Admin Commands",
        game_iy_tag="✨ FEATURED",
        game_mm2="🔪 Murder Mystery 2", game_yarhm="YARHM - no key",
        game_run="▶ Execute", game_cancel="✕ Cancel",
        game_confirm_title="🔪 YARHM - MM2",
        game_executing="⚡ Executing...",
        game_executed="✅ Script executed!", game_error="❌ Execution error!",
    },
    es_ES = {
        hub_title="📁 Delta Hub", config_title="⚙️ Configuración",
        btn_new="+", btn_config="⚙️",
        empty="Sin scripts.\n¡Clic en  +  para agregar!",
        editor_new="✏️ Nuevo Script", editor_edit="✏️ Editando: ",
        editor_name_label="Nombre:", editor_code_label="Código (Lua):",
        editor_name_ph="Ej: MiVuelo_v2", editor_code_ph="-- Pega tu script aquí...",
        btn_save="💾 Guardar", btn_cancel="✕ Cancelar", btn_run="▶ Ejecutar",
        lang_btn="🌐 Idioma", color_btn="🎨 Color de Borde",
        daynight_btn="🌙 Cambiar a Noche", daynight_day="☀️ Cambiar a Día",
        fps_btn="⚡ FPS Boost", fps_on="⚡ FPS Boost: ON ✓",
        ping_btn="🏓 Ver Ping",
        notif_ping="🏓 Ping: ", notif_ping_err="❌ Ping no disponible",
        notif_saved="💾 Guardado: ", notif_deleted="🗑 Eliminado: ",
        notif_executed="▶ Ejecutado: ", notif_error="❌ Error en script!",
        notif_warn_name="⚠️ Escribe un nombre!",
        notif_warn_code="⚠️ El código está vacío!",
        notif_night="🌙 Buenas noches!", notif_day="☀️ Buenos días!",
        notif_fps_on="⚡ FPS Boost activado!", notif_fps_off="FPS Boost desactivado",
        notif_color="🎨 Color cambiado!", notif_loaded="📁 Delta Hub cargado!",
        notif_lang_saved="🌐 Idioma guardado!", notif_custom_color="🎨 Color personalizado!",
        lang_window_title="🌐 Seleccionar Idioma",
        lang_confirm="✔ Confirmar", lang_search_btn="🔍 Buscar",
        search_ph="Buscar idioma...", search_window_title="🔍 Buscar Idioma",
        search_btn_go="Buscar",
        color_window_title="🎨 Color de Borde",
        color_rgb="🌈 RGB (predeterminado)", color_orange="🟠 Naranja",
        color_blue="🔵 Azul", color_green="🟢 Verde",
        color_red="🔴 Rojo", color_off="⬜ Desactivado",
        color_adv="🎨 Avanzado", color_use="Usar", color_active="✓ Activo",
        palette_title="🎨 Color Avanzado", palette_close="✕ Cerrar",
        loading="Cargando...",
        card_run="▶", card_edit="✏", card_delete="🗑",
        games_title="🎮 Juegos", games_back="◀ Volver",
        game_iy="📍 Infinite Yield",
        game_iy_script="Comandos Admin",
        game_iy_tag="✨ DESTACADO",
        game_mm2="🔪 Murder Mystery 2", game_yarhm="YARHM - sin clave",
        game_run="▶ Ejecutar", game_cancel="✕ Cancelar",
        game_confirm_title="🔪 YARHM - MM2",
        game_executing="⚡ Ejecutando...",
        game_executed="✅ ¡Script ejecutado!", game_error="❌ ¡Error al ejecutar!",
    },
    ja_JP = {
        hub_title="📁 Delta Hub", config_title="⚙️ 設定",
        btn_new="+", btn_config="⚙️",
        empty="スクリプトなし。\n+をクリックして追加！",
        editor_new="✏️ 新しいスクリプト", editor_edit="✏️ 編集中: ",
        editor_name_label="スクリプト名:", editor_code_label="コード (Lua):",
        editor_name_ph="例: マイフライ_v2", editor_code_ph="-- ここに貼り付け...",
        btn_save="💾 保存", btn_cancel="✕ キャンセル", btn_run="▶ 実行",
        lang_btn="🌐 言語", color_btn="🎨 ボーダーカラー",
        daynight_btn="🌙 夜に変更", daynight_day="☀️ 昼に変更",
        fps_btn="⚡ FPS ブースト", fps_on="⚡ FPS ブースト: ON ✓",
        ping_btn="🏓 Ping 確認",
        notif_ping="🏓 Ping: ", notif_ping_err="❌ Ping 利用不可",
        notif_saved="💾 保存: ", notif_deleted="🗑 削除: ",
        notif_executed="▶ 実行: ", notif_error="❌ スクリプトエラー!",
        notif_warn_name="⚠️ 名前を入力!", notif_warn_code="⚠️ コードが空!",
        notif_night="🌙 おやすみ!", notif_day="☀️ おはよう!",
        notif_fps_on="⚡ FPS ブースト有効!", notif_fps_off="FPS ブースト無効",
        notif_color="🎨 カラー変更!", notif_loaded="📁 Delta Hub 完了!",
        notif_lang_saved="🌐 言語保存済み!", notif_custom_color="🎨 カスタムカラー!",
        lang_window_title="🌐 言語選択",
        lang_confirm="✔ 確認", lang_search_btn="🔍 検索",
        search_ph="言語を検索...", search_window_title="🔍 言語検索",
        search_btn_go="検索",
        color_window_title="🎨 ボーダーカラー",
        color_rgb="🌈 RGB (デフォルト)", color_orange="🟠 オレンジ",
        color_blue="🔵 青", color_green="🟢 緑",
        color_red="🔴 赤", color_off="⬜ 無効",
        color_adv="🎨 詳細", color_use="使用", color_active="✓ 有効",
        palette_title="🎨 詳細カラー", palette_close="✕ 閉じる",
        loading="読み込み中...",
        card_run="▶", card_edit="✏", card_delete="🗑",
        games_title="🎮 ゲーム", games_back="◀ 戻る",
        game_iy="📍 Infinite Yield",
        game_iy_script="管理者コマンド",
        game_iy_tag="✨ 注目",
        game_mm2="🔪 Murder Mystery 2", game_yarhm="YARHM - キーなし",
        game_run="▶ 実行", game_cancel="✕ キャンセル",
        game_confirm_title="🔪 YARHM - MM2",
        game_executing="⚡ 実行中...",
        game_executed="✅ 実行完了!", game_error="❌ 実行エラー!",
    },
}
setmetatable(TRANSLATIONS, {__index=function() return TRANSLATIONS.en_US end})

local LANGS = {
    {code="pt_BR",flag="🇧🇷",name="Português (BR)"},
    {code="pt_PT",flag="🇵🇹",name="Português (PT)"},
    {code="en_US",flag="🇺🇸",name="English (US)"},
    {code="en_GB",flag="🇬🇧",name="English (UK)"},
    {code="en_AU",flag="🇦🇺",name="English (AU)"},
    {code="en_JM",flag="🇯🇲",name="English (Jamaica)"},
    {code="en_LR",flag="🇱🇷",name="English (Liberia)"},
    {code="es_ES",flag="🇪🇸",name="Español (España)"},
    {code="es_CL",flag="🇨🇱",name="Español (Chile)"},
    {code="es_UY",flag="🇺🇾",name="Español (Uruguay)"},
    {code="ja_JP",flag="🇯🇵",name="日本語"},
    {code="ko_KR",flag="🇰🇷",name="한국어"},
    {code="zh_CN",flag="🇨🇳",name="中文 (简体)"},
    {code="zh_TW",flag="🇹🇼",name="中文 (繁體)"},
    {code="hi_IN",flag="🇮🇳",name="हिन्दी"},
    {code="ar_SA",flag="🇸🇦",name="العربية"},
    {code="ru_RU",flag="🇷🇺",name="Русский"},
    {code="fr_FR",flag="🇫🇷",name="Français"},
    {code="de_DE",flag="🇩🇪",name="Deutsch"},
    {code="it_IT",flag="🇮🇹",name="Italiano"},
    {code="tr_TR",flag="🇹🇷",name="Türkçe"},
    {code="vi_VN",flag="🇻🇳",name="Tiếng Việt"},
    {code="th_TH",flag="🇹🇭",name="ภาษาไทย"},
    {code="id_ID",flag="🇮🇩",name="Bahasa Indonesia"},
    {code="ms_MY",flag="🇲🇾",name="Bahasa Melayu"},
    {code="pl_PL",flag="🇵🇱",name="Polski"},
    {code="nl_NL",flag="🇳🇱",name="Nederlands"},
    {code="sv_SE",flag="🇸🇪",name="Svenska"},
    {code="no_NO",flag="🇳🇴",name="Norsk"},
    {code="da_DK",flag="🇩🇰",name="Dansk"},
    {code="fi_FI",flag="🇫🇮",name="Suomi"},
    {code="el_GR",flag="🇬🇷",name="Ελληνικά"},
    {code="bg_BG",flag="🇧🇬",name="Български"},
    {code="cs_CZ",flag="🇨🇿",name="Čeština"},
    {code="ro_RO",flag="🇷🇴",name="Română"},
    {code="hu_HU",flag="🇭🇺",name="Magyar"},
    {code="uk_UA",flag="🇺🇦",name="Українська"},
    {code="he_IL",flag="🇮🇱",name="עברית"},
    {code="fa_IR",flag="🇮🇷",name="فارسی"},
    {code="ur_PK",flag="🇵🇰",name="اردو"},
    {code="bn_BD",flag="🇧🇩",name="বাংলা"},
    {code="sw_KE",flag="🇰🇪",name="Kiswahili"},
    {code="tl_PH",flag="🇵🇭",name="Filipino"},
    {code="af_ZA",flag="🇿🇦",name="Afrikaans"},
    {code="cy_GB",flag="🏴󠁧󠁢󠁷󠁬󠁳󠁿",name="Cymraeg"},
    {code="ga_IE",flag="🇮🇪",name="Gaeilge"},
    {code="is_IS",flag="🇮🇸",name="Íslenska"},
    {code="mk_MK",flag="🇲🇰",name="Македонски"},
    {code="sr_RS",flag="🇷🇸",name="Српски"},
    {code="lt_LT",flag="🇱🇹",name="Lietuvių"},
    {code="lv_LV",flag="🇱🇻",name="Latviešu"},
    {code="et_EE",flag="🇪🇪",name="Eesti"},
    {code="ka_GE",flag="🇬🇪",name="ქართული"},
    {code="hy_AM",flag="🇦🇲",name="Հայերեն"},
    {code="mn_MN",flag="🇲🇳",name="Монгол"},
    {code="km_KH",flag="🇰🇭",name="ភាសាខ្មែរ"},
    {code="ne_NP",flag="🇳🇵",name="नेपाली"},
    {code="mg_MG",flag="🇲🇬",name="Malagasy"},
    {code="ht_HT",flag="🇭🇹",name="Kreyòl"},
    {code="eo",   flag="🌍",  name="Esperanto"},
    {code="la_VA",flag="🇻🇦",name="Latina"},
}

-- ======= ESTADO =======
local currentLang, borderMode = loadConfig()
local customColor = Color3.fromRGB(255,100,0)

local function T(k)
    return (TRANSLATIONS[currentLang] or TRANSLATIONS.en_US)[k]
        or TRANSLATIONS.en_US[k] or k
end

local function getBorderColor(hue)
    if     borderMode=="rgb"      then return Color3.fromHSV(hue,1,1)
    elseif borderMode=="orange"   then return Color3.fromRGB(255,140,0)
    elseif borderMode=="blue"     then return Color3.fromRGB(0,150,255)
    elseif borderMode=="green"    then return Color3.fromRGB(0,210,80)
    elseif borderMode=="red"      then return Color3.fromRGB(220,50,50)
    elseif borderMode=="off"      then return Color3.fromRGB(80,80,80)
    elseif borderMode=="advanced" then return customColor
    end
    return Color3.fromHSV(hue,1,1)
end

-- ======= GUI BASE =======
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 9999
ScreenGui.Parent = player.PlayerGui

local rgbStrokes = {}

-- ======= HELPERS =======
local function makeFrame(parent, size, pos, bg, zi)
    local F = Instance.new("Frame")
    F.Size = size; F.Position = pos or UDim2.new(0,0,0,0)
    F.BackgroundColor3 = bg or Color3.fromRGB(13,13,18)
    F.BorderSizePixel = 0; F.ZIndex = zi or 1; F.Parent = parent
    local S = Instance.new("UIStroke"); S.Thickness=2; S.Parent=F
    table.insert(rgbStrokes, S)
    return F, S
end

local function makeBtn(parent, txt, size, pos, zi)
    local B = Instance.new("TextButton")
    B.Size=size; B.Position=pos
    B.BackgroundColor3=Color3.fromRGB(20,20,30)
    B.Text=txt; B.TextColor3=Color3.fromRGB(240,240,245)
    B.Font=Enum.Font.GothamBold; B.TextSize=13
    B.BorderSizePixel=0; B.ZIndex=zi or 1; B.Parent=parent
    local S=Instance.new("UIStroke"); S.Thickness=2; S.Parent=B
    table.insert(rgbStrokes, S)
    return B
end

local function makeLbl(parent, txt, size, pos, zi, align, color, fs)
    local L = Instance.new("TextLabel")
    L.Size=size; L.Position=pos; L.BackgroundTransparency=1
    L.Text=txt; L.TextColor3=color or Color3.fromRGB(240,240,245)
    L.Font=Enum.Font.GothamBold; L.TextSize=fs or 13
    L.ZIndex=zi or 1; L.TextXAlignment=align or Enum.TextXAlignment.Center
    L.Parent=parent; return L
end

local function makeScroll(parent, size, pos, zi)
    local S=Instance.new("ScrollingFrame")
    S.Size=size; S.Position=pos; S.BackgroundTransparency=1
    S.BorderSizePixel=0; S.ScrollBarThickness=3
    S.ScrollBarImageColor3=Color3.fromRGB(110,60,255)
    S.CanvasSize=UDim2.new(0,0,0,0); S.ZIndex=zi or 1; S.Parent=parent
    local L=Instance.new("UIListLayout"); L.Padding=UDim.new(0,5); L.Parent=S
    local P=Instance.new("UIPadding")
    P.PaddingTop=UDim.new(0,4); P.PaddingLeft=UDim.new(0,4); P.PaddingRight=UDim.new(0,4); P.Parent=S
    L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        S.CanvasSize=UDim2.new(0,0,0,L.AbsoluteContentSize.Y+10)
    end)
    return S
end

-- ======= NOTIFICAÇÃO =======
local function notify(msg, r, g, b)
    local N=Instance.new("Frame")
    N.Size=UDim2.new(0,280,0,48); N.Position=UDim2.new(0.5,-140,0,-60)
    N.BackgroundColor3=Color3.fromRGB(r or 110,g or 60,b or 255)
    N.BorderSizePixel=0; N.ZIndex=500; N.Parent=ScreenGui
    local NS=Instance.new("UIStroke"); NS.Thickness=2; NS.ZIndex=501; NS.Parent=N
    table.insert(rgbStrokes, NS)
    makeLbl(N, msg, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), 501, nil, nil, 13)
    TweenService:Create(N, TweenInfo.new(0.4,Enum.EasingStyle.Back),
        {Position=UDim2.new(0.5,-140,0,15)}):Play()
    task.delay(2.8, function()
        TweenService:Create(N,TweenInfo.new(0.3),
            {Position=UDim2.new(0.5,-140,0,-65)}):Play()
        task.delay(0.35, function() N:Destroy() end)
    end)
end

-- ======= LOADING =======
LoadOverlay=Instance.new("Frame")
LoadOverlay.Size=UDim2.new(1,0,1,0)
LoadOverlay.BackgroundColor3=Color3.fromRGB(0,0,0)
LoadOverlay.BackgroundTransparency=0.4
LoadOverlay.BorderSizePixel=0; LoadOverlay.ZIndex=1000
LoadOverlay.Visible=false; LoadOverlay.Parent=ScreenGui
LoadLbl=makeLbl(LoadOverlay, T("loading"),
    UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), 1001, nil, nil, 22)

local function showLoading(cb)
    LoadLbl.Text=T("loading")
    LoadOverlay.Visible=true
    task.delay(8, function()
        LoadOverlay.Visible=false
        local sp="DeltaHub/DeltaHub.lua"
        if isfile(sp) then
            ScreenGui:Destroy()
            local ok,err=pcall(loadstring(readfile(sp)))
            if not ok then print("Erro reload:",err) end
        else
            if cb then cb() end
        end
    end)
end

-- ========================================================
-- TODAS AS JANELAS FLUTUANTES (declaradas antes do Main)
-- ========================================================

-- ======= PALETA =======
PaletteWindow,PaletteStroke=makeFrame(ScreenGui,
    UDim2.new(0,290,0,310), UDim2.new(0.5,-145,0.5,-155),
    Color3.fromRGB(13,13,18), 300)
PaletteWindow.Visible=false
PalTBar,_=makeFrame(PaletteWindow,
    UDim2.new(1,0,0,36), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 301)
PalTitleLbl=makeLbl(PalTBar, T("palette_title"),
    UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 302, Enum.TextXAlignment.Left)
BtnPalClose=makeBtn(PaletteWindow, T("palette_close"),
    UDim2.new(1,-20,0,34), UDim2.new(0,10,1,-44), 302)
BtnPalClose.MouseButton1Click:Connect(function() PaletteWindow.Visible=false end)

local paletteColors={
    Color3.fromRGB(255,0,0),Color3.fromRGB(255,80,0),Color3.fromRGB(255,160,0),
    Color3.fromRGB(255,220,0),Color3.fromRGB(180,255,0),Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,255,150),Color3.fromRGB(0,255,255),Color3.fromRGB(0,180,255),
    Color3.fromRGB(0,80,255),Color3.fromRGB(80,0,255),Color3.fromRGB(180,0,255),
    Color3.fromRGB(255,0,200),Color3.fromRGB(255,0,100),Color3.fromRGB(255,140,140),
    Color3.fromRGB(140,255,140),Color3.fromRGB(140,140,255),Color3.fromRGB(255,200,140),
    Color3.fromRGB(140,220,255),Color3.fromRGB(255,160,220),Color3.fromRGB(160,255,220),
    Color3.fromRGB(220,160,255),Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200),
    Color3.fromRGB(150,150,150),Color3.fromRGB(100,100,100),Color3.fromRGB(50,50,50),
    Color3.fromRGB(0,0,0),Color3.fromRGB(80,40,0),Color3.fromRGB(40,80,40),
}
for i,col in ipairs(paletteColors) do
    local row=math.floor((i-1)/6); local column=(i-1)%6
    Sw=Instance.new("TextButton")
    Sw.Size=UDim2.new(0,36,0,36); Sw.Position=UDim2.new(0,10+column*42,0,44+row*42)
    Sw.BackgroundColor3=col; Sw.Text=""; Sw.BorderSizePixel=0; Sw.ZIndex=302; Sw.Parent=PaletteWindow
    local swc=col
    Sw.MouseButton1Click:Connect(function()
        customColor=swc; borderMode="advanced"
        saveConfig(currentLang, borderMode)
        notify(T("notif_custom_color"),110,60,255)
        PaletteWindow.Visible=false
    end)
end

-- ======= JANELA COR =======
local colorSelBtns={}
ColorWindow,_=makeFrame(ScreenGui,
    UDim2.new(0,310,0,360), UDim2.new(0.5,-155,0.5,-180),
    Color3.fromRGB(13,13,18), 200)
ColorWindow.Visible=false
ColTBar,_=makeFrame(ColorWindow,
    UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 201)
ColTitleLbl=makeLbl(ColTBar, T("color_window_title"),
    UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 202, Enum.TextXAlignment.Left)
BtnColClose=makeBtn(ColTBar,"✕",UDim2.new(0,26,0,26),UDim2.new(1,-32,0.5,-13),202)
BtnColClose.MouseButton1Click:Connect(function() ColorWindow.Visible=false end)

local colorOptions={
    {mode="rgb",     lkey="color_rgb",    col=Color3.fromRGB(180,80,255)},
    {mode="orange",  lkey="color_orange", col=Color3.fromRGB(255,140,0)},
    {mode="blue",    lkey="color_blue",   col=Color3.fromRGB(0,150,255)},
    {mode="green",   lkey="color_green",  col=Color3.fromRGB(0,210,80)},
    {mode="red",     lkey="color_red",    col=Color3.fromRGB(220,50,50)},
    {mode="off",     lkey="color_off",    col=Color3.fromRGB(80,80,80)},
    {mode="advanced",lkey="color_adv",    col=Color3.fromRGB(255,100,0)},
}
for i,opt in ipairs(colorOptions) do
    Row,RowS=makeFrame(ColorWindow,
        UDim2.new(1,-16,0,40), UDim2.new(0,8,0,44+(i-1)*44),
        Color3.fromRGB(22,22,30), 201)
    RowS.Transparency=0.5
    Dot=Instance.new("Frame")
    Dot.Size=UDim2.new(0,18,0,18); Dot.Position=UDim2.new(0,8,0.5,-9)
    Dot.BackgroundColor3=opt.col; Dot.BorderSizePixel=0; Dot.ZIndex=202; Dot.Parent=Row
    Lbl=makeLbl(Row, T(opt.lkey),
        UDim2.new(1,-85,1,0), UDim2.new(0,34,0,0), 202, Enum.TextXAlignment.Left, nil, 12)
    SelBtn=makeBtn(Row, (borderMode==opt.mode) and T("color_active") or T("color_use"),
        UDim2.new(0,58,0,28), UDim2.new(1,-65,0.5,-14), 202)
    SelBtn.TextSize=12
    colorSelBtns[opt.mode]={btn=SelBtn, lbl=Lbl, lkey=opt.lkey}
    local optMode=opt.mode
    SelBtn.MouseButton1Click:Connect(function()
        if optMode=="advanced" then
            PaletteWindow.Visible=true
        else
            borderMode=optMode
            saveConfig(currentLang, borderMode)
            for m,ref in pairs(colorSelBtns) do
                ref.btn.Text=(m==borderMode) and T("color_active") or T("color_use")
            end
            notify(T("notif_color"),110,60,255)
            ColorWindow.Visible=false
        end
    end)
end

-- ======= JANELA PESQUISA =======
SearchWindow,_=makeFrame(ScreenGui,
    UDim2.new(0,310,0,115), UDim2.new(0.5,-155,0.5,-57),
    Color3.fromRGB(13,13,18), 300)
SearchWindow.Visible=false
SrchTBar,_=makeFrame(SearchWindow,
    UDim2.new(1,0,0,36), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 301)
SrchTitleLbl=makeLbl(SrchTBar, T("search_window_title"),
    UDim2.new(1,-20,1,0), UDim2.new(0,12,0,0), 302, Enum.TextXAlignment.Left)
SearchBox=Instance.new("TextBox")
SearchBox.Size=UDim2.new(1,-20,0,38); SearchBox.Position=UDim2.new(0,10,0,42)
SearchBox.BackgroundColor3=Color3.fromRGB(22,22,30); SearchBox.BorderSizePixel=0
SearchBox.PlaceholderText=T("search_ph"); SearchBox.TextColor3=Color3.fromRGB(240,240,245)
SearchBox.PlaceholderColor3=Color3.fromRGB(100,100,120); SearchBox.Font=Enum.Font.Gotham
SearchBox.TextSize=13; SearchBox.ZIndex=301; SearchBox.ClearTextOnFocus=false
SearchBox.Text=""; SearchBox.Parent=SearchWindow
local sbp=Instance.new("UIPadding"); sbp.PaddingLeft=UDim.new(0,10); sbp.Parent=SearchBox
BtnSearchGo=makeBtn(SearchWindow, T("search_btn_go"),
    UDim2.new(1,-20,0,33), UDim2.new(0,10,0,84), 302)

-- ======= JANELA IDIOMA =======
LangWindow,_=makeFrame(ScreenGui,
    UDim2.new(0,330,0,420), UDim2.new(0.5,-165,0.5,-210),
    Color3.fromRGB(13,13,18), 200)
LangWindow.Visible=false
LangTBar,_=makeFrame(LangWindow,
    UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 201)
LangTitleLbl=makeLbl(LangTBar, T("lang_window_title"),
    UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 202, Enum.TextXAlignment.Left)
LangScroll=makeScroll(LangWindow,
    UDim2.new(1,-12,1,-100), UDim2.new(0,6,0,44), 201)
local selectedLangCode=currentLang

local function buildLangList(filter)
    for _,c in pairs(LangScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local f=(filter or ""):lower()
    for _,lang in pairs(LANGS) do
        if f=="" or lang.name:lower():find(f,1,true) or lang.code:lower():find(f,1,true) then
            local isSel=(lang.code==selectedLangCode)
            B=Instance.new("TextButton")
            B.Size=UDim2.new(1,0,0,38)
            B.BackgroundColor3=isSel and Color3.fromRGB(50,40,80) or Color3.fromRGB(22,22,30)
            B.Text=lang.flag.."  "..lang.name..(isSel and "  ✓" or "")
            B.TextColor3=isSel and Color3.fromRGB(200,160,255) or Color3.fromRGB(240,240,245)
            B.Font=Enum.Font.GothamBold; B.TextSize=12
            B.TextXAlignment=Enum.TextXAlignment.Left
            B.BorderSizePixel=0; B.ZIndex=202; B.Parent=LangScroll
            local bp=Instance.new("UIPadding"); bp.PaddingLeft=UDim.new(0,10); bp.Parent=B
            local bs=Instance.new("UIStroke"); bs.Thickness=1; bs.Transparency=0.5; bs.Parent=B
            table.insert(rgbStrokes, bs)
            local lcode=lang.code
            B.MouseButton1Click:Connect(function()
                selectedLangCode=lcode; buildLangList(filter)
            end)
        end
    end
end

BtnLangConfirm=makeBtn(LangWindow, T("lang_confirm"),
    UDim2.new(0,140,0,35), UDim2.new(0,10,1,-45), 202)
BtnLangSearch=makeBtn(LangWindow, T("lang_search_btn"),
    UDim2.new(0,140,0,35), UDim2.new(1,-150,1,-45), 202)

BtnSearchGo.MouseButton1Click:Connect(function()
    buildLangList(SearchBox.Text); SearchWindow.Visible=false
end)
BtnLangSearch.MouseButton1Click:Connect(function()
    SearchBox.Text=""; SearchWindow.Visible=true
end)

-- ======= JANELA YARHM =======
YARHMWindow,_=makeFrame(ScreenGui,
    UDim2.new(0,300,0,180), UDim2.new(0.5,-150,0.5,-90),
    Color3.fromRGB(13,13,18), 150)
YARHMWindow.Visible=false
YARHMTBar,_=makeFrame(YARHMWindow,
    UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 151)
YARHMTitleLbl=makeLbl(YARHMTBar, T("game_confirm_title"),
    UDim2.new(1,-20,1,0), UDim2.new(0,12,0,0), 152, Enum.TextXAlignment.Left, nil, 14)
YARHMDesc=makeLbl(YARHMWindow, T("game_yarhm"),
    UDim2.new(1,-20,0,22), UDim2.new(0,10,0,48), 151,
    Enum.TextXAlignment.Left, Color3.fromRGB(180,180,200), 12)
makeLbl(YARHMWindow, "rawscripts.net",
    UDim2.new(1,-20,0,16), UDim2.new(0,10,0,72), 151,
    Enum.TextXAlignment.Left, Color3.fromRGB(100,100,130), 10)
BtnYARHMRun=makeBtn(YARHMWindow, T("game_run"),
    UDim2.new(0,120,0,36), UDim2.new(0,12,1,-48), 152)
BtnYARHMCancel=makeBtn(YARHMWindow, T("game_cancel"),
    UDim2.new(0,120,0,36), UDim2.new(1,-132,1,-48), 152)
BtnYARHMCancel.MouseButton1Click:Connect(function() YARHMWindow.Visible=false end)
BtnYARHMRun.MouseButton1Click:Connect(function()
    BtnYARHMRun.Text=T("game_executing")
    YARHMWindow.Visible=false
    notify(T("game_executing"),110,60,255)
    task.delay(0.5, function()
        local ok,err=pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-YARHM-12403"))()
        end)
        notify(ok and T("game_executed") or T("game_error"),
            ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if not ok then print("YARHM Erro:",err) end
        BtnYARHMRun.Text=T("game_run")
    end)
end)

-- ======= JANELA CONFIG =======
Config,_=makeFrame(ScreenGui,
    UDim2.new(0,300,0,310), UDim2.new(0.5,-150,0.5,-155),
    Color3.fromRGB(13,13,18), 100)
Config.Visible=false
ConfigTBar,_=makeFrame(Config,
    UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 101)
ConfigTitleLbl=makeLbl(ConfigTBar, T("config_title"),
    UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 102, Enum.TextXAlignment.Left, nil, 14)
BtnConfigClose=makeBtn(ConfigTBar,"✕",
    UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 102)
BtnConfigClose.MouseButton1Click:Connect(function() Config.Visible=false end)

local function makeConfigBtn(txt, y)
    return makeBtn(Config, txt, UDim2.new(1,-16,0,40), UDim2.new(0,8,0,y), 101)
end
BtnLangOpt  = makeConfigBtn(T("lang_btn"),      48)
BtnColorOpt = makeConfigBtn(T("color_btn"),     98)
Sep=Instance.new("Frame"); Sep.Size=UDim2.new(1,-16,0,2)
Sep.Position=UDim2.new(0,8,0,148); Sep.BackgroundColor3=Color3.fromRGB(50,50,70)
Sep.BorderSizePixel=0; Sep.ZIndex=101; Sep.Parent=Config
BtnDayNight = makeConfigBtn(T("daynight_btn"),  160)
BtnFPS      = makeConfigBtn(T("fps_btn"),       210)
BtnPing     = makeConfigBtn(T("ping_btn"),      260)

BtnLangOpt.MouseButton1Click:Connect(function()
    selectedLangCode=currentLang; buildLangList(); LangWindow.Visible=true
end)
BtnColorOpt.MouseButton1Click:Connect(function()
    ColorWindow.Visible=true
end)

local isNight=false
BtnDayNight.MouseButton1Click:Connect(function()
    isNight=not isNight
    if isNight then
        game.Lighting.ClockTime=0; game.Lighting.Brightness=0.5
        BtnDayNight.Text=T("daynight_day"); notify(T("notif_night"),0,50,150)
    else
        game.Lighting.ClockTime=14; game.Lighting.Brightness=2
        BtnDayNight.Text=T("daynight_btn"); notify(T("notif_day"),200,150,0)
    end
end)
local fpsOn=false
BtnFPS.MouseButton1Click:Connect(function()
    fpsOn=not fpsOn
    if fpsOn then
        game.Lighting.GlobalShadows=false; settings().Rendering.QualityLevel=1
        BtnFPS.Text=T("fps_on"); notify(T("notif_fps_on"),0,180,80)
    else
        game.Lighting.GlobalShadows=true; settings().Rendering.QualityLevel=21
        BtnFPS.Text=T("fps_btn"); notify(T("notif_fps_off"),100,100,100)
    end
end)
BtnPing.MouseButton1Click:Connect(function()
    local ok,ping=pcall(function()
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    notify(ok and T("notif_ping")..ping.."ms" or T("notif_ping_err"),
        ok and 0 or 180, ok and 160 or 50, ok and 255 or 50)
end)

BtnLangConfirm.MouseButton1Click:Connect(function()
    currentLang=selectedLangCode
    saveConfig(currentLang, borderMode)
    LangWindow.Visible=false
    showLoading(function()
        notify(T("notif_lang_saved"),110,60,255)
    end)
end)

-- ========================================================
-- JANELA PRINCIPAL (declarada depois de todas as flutuantes)
-- ========================================================

Main,MainStroke=makeFrame(ScreenGui,
    UDim2.new(0,560,0,280), UDim2.new(0.5,-280,0.5,-140),
    Color3.fromRGB(13,13,18), 2)

TitleBar,TitleStroke=makeFrame(Main,
    UDim2.new(1,0,0,45), UDim2.new(0,0,0,0),
    Color3.fromRGB(20,20,30), 3)

TitleLbl=makeLbl(TitleBar, T("hub_title"),
    UDim2.new(1,-230,1,0), UDim2.new(0,15,0,0), 4,
    Enum.TextXAlignment.Left, nil, 15)

local function makeTBtn(txt, x)
    return makeBtn(TitleBar, txt, UDim2.new(0,28,0,28), UDim2.new(1,x,0.5,-14), 5)
end
BtnClose    = makeTBtn("✕",  -10)
BtnMinimize = makeTBtn("─",  -44)
BtnExpand   = makeTBtn("⛶",  -78)
BtnGames     = makeTBtn("🎮", -115)
BtnCommunity = makeTBtn("🌐", -152)
BtnVote      = makeTBtn("👥", -189)
BtnNew       = makeTBtn("+",  -226)
BtnCfg       = makeTBtn("⚙️", -263)

-- Content
Content=Instance.new("Frame")
Content.Size=UDim2.new(1,0,1,-50); Content.Position=UDim2.new(0,0,0,50)
Content.BackgroundTransparency=1; Content.Parent=Main

-- ======= VIEW: LISTA DE SCRIPTS =======
ScriptsView=Instance.new("Frame")
ScriptsView.Size=UDim2.new(1,0,1,0); ScriptsView.BackgroundTransparency=1
ScriptsView.Visible=true; ScriptsView.ZIndex=3; ScriptsView.Parent=Content

EmptyLbl=makeLbl(ScriptsView, T("empty"),
    UDim2.new(1,0,0,50), UDim2.new(0,0,0.4,0), 3,
    nil, Color3.fromRGB(140,140,165), 13)

Scroll=makeScroll(ScriptsView,
    UDim2.new(1,-14,1,-10), UDim2.new(0,7,0,5), 3)

-- ======= VIEW: JOGOS =======
GamesView=Instance.new("Frame")
GamesView.Size=UDim2.new(1,0,1,0); GamesView.BackgroundTransparency=1
GamesView.Visible=false; GamesView.ZIndex=3; GamesView.Parent=Content

GamesTitleLbl=makeLbl(GamesView, T("games_title"),
    UDim2.new(1,0,0,30), UDim2.new(0,0,0,5), 4, nil, nil, 15)

-- Card MM2
-- Card IY (com borda destaque RGB)
IYCard,IYCS=makeFrame(GamesView,
    UDim2.new(1,-16,0,62), UDim2.new(0,8,0,42),
    Color3.fromRGB(22,22,30), 4)
IYCS.Thickness=3  -- borda mais grossa para destaque
makeLbl(IYCard,"📍",UDim2.new(0,50,1,0),UDim2.new(0,0,0,0),5,nil,nil,24)

-- Badge destaque
IYBadge=Instance.new("Frame")
IYBadge.Size=UDim2.new(0,80,0,18)
IYBadge.Position=UDim2.new(0,55,0,4)
IYBadge.BackgroundColor3=Color3.fromRGB(110,60,255)
IYBadge.BorderSizePixel=0; IYBadge.ZIndex=6; IYBadge.Parent=IYCard
IYBadgeStroke=Instance.new("UIStroke"); IYBadgeStroke.Thickness=1; IYBadgeStroke.Parent=IYBadge
table.insert(rgbStrokes, IYBadgeStroke)
IYTagLbl=makeLbl(IYBadge, T("game_iy_tag"),
    UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), 7, nil, Color3.fromRGB(255,255,255), 9)

IYName=makeLbl(IYCard, T("game_iy"),
    UDim2.new(1,-120,0,18), UDim2.new(0,55,0,24), 5,
    Enum.TextXAlignment.Left, nil, 13)
IYScript=makeLbl(IYCard, T("game_iy_script"),
    UDim2.new(1,-120,0,14), UDim2.new(0,55,0,44), 5,
    Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
BtnIY=makeBtn(IYCard, T("game_run"),
    UDim2.new(0,55,0,36), UDim2.new(1,-62,0.5,-18), 5)
BtnIY.TextSize=12

-- Separador entre IY e MM2
GamesSep=Instance.new("Frame")
GamesSep.Size=UDim2.new(1,-16,0,2)
GamesSep.Position=UDim2.new(0,8,0,114)
GamesSep.BackgroundColor3=Color3.fromRGB(40,40,60)
GamesSep.BorderSizePixel=0; GamesSep.ZIndex=4; GamesSep.Parent=GamesView

-- Card MM2
MM2Card,MM2CS=makeFrame(GamesView,
    UDim2.new(1,-16,0,62), UDim2.new(0,8,0,124),
    Color3.fromRGB(22,22,30), 4)
MM2CS.Transparency=0.3
makeLbl(MM2Card,"🔪",UDim2.new(0,50,1,0),UDim2.new(0,0,0,0),5,nil,nil,24)
MM2Name=makeLbl(MM2Card, T("game_mm2"),
    UDim2.new(1,-120,0,22), UDim2.new(0,55,0,6), 5,
    Enum.TextXAlignment.Left, nil, 13)
MM2Script=makeLbl(MM2Card, T("game_yarhm"),
    UDim2.new(1,-120,0,16), UDim2.new(0,55,0,30), 5,
    Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
BtnMM2=makeBtn(MM2Card, T("game_run"),
    UDim2.new(0,55,0,36), UDim2.new(1,-62,0.5,-18), 5)
BtnMM2.TextSize=12

BtnGamesBack=makeBtn(GamesView, T("games_back"),
    UDim2.new(1,-16,0,34), UDim2.new(0,8,1,-40), 4)

-- ======= SISTEMA DE BAN LOCAL =======
BAN_FILE = "DeltaHub/admin/banlist.dat"
VOTE_FILE = "DeltaHub/admin/votelist.dat"
local _pw = "AHFI2TF92956929DUJWSHJOWF"

if not isfolder("DeltaHub/admin/") then makefolder("DeltaHub/admin/") end
if not isfile(BAN_FILE) then writefile(BAN_FILE, "##".._pw.."##\n") end
if not isfile(VOTE_FILE) then writefile(VOTE_FILE, '{"votes":[],"total":0}') end

local function getBannedList()
    if not isfile(BAN_FILE) then return {} end
    local content = readfile(BAN_FILE)
    if not content:find("^##".._pw.."##") then return {} end
    local t = {}
    for line in content:gmatch("[^\n]+") do
        if not line:find("^##") then
            local id = line:match("^%[([^%]]+)%]")
            if id then t[id:lower()] = true end
        end
    end
    return t
end

local function isBanned(name)
    return getBannedList()[name:lower()] == true
end

local function banUser(name, pw)
    if pw ~= _pw then return false, "senha" end
    if isBanned(name) then return false, "ja" end
    local c = readfile(BAN_FILE)
    writefile(BAN_FILE, c .. "[" .. name:lower() .. "]\n")
    return true
end

-- ======= GITHUB =======
local GH_TOKEN = "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"
local GH_USER  = "josevitor8247-png"
local GH_REPO  = "-scripts-"
local RAW = "https://raw.githubusercontent.com/"..GH_USER.."/"..GH_REPO.."/main/"
local API = "https://api.github.com/repos/"..GH_USER.."/"..GH_REPO.."/contents/"
local ADMIN = {"noob_artl2","noob_arl2"}

local function isAdmin()
    local n = player.Name:lower()
    for _,a in ipairs(ADMIN) do if n==a then return true end end
    return false
end

-- Detecta função HTTP do executor
local _req = nil
task.spawn(function()
    for _, fn in ipairs({
        function() return request end,
        function() return syn and syn.request end,
        function() return http_request end,
        function() return http and http.request end,
    }) do
        local ok, r = pcall(fn)
        if ok and type(r) == "function" then _req = r break end
    end
end)

local function b64(s)
    local t = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local r, bytes = "", {tostring(s):byte(1,-1)}
    for i=1,#bytes,3 do
        local a,b,c = bytes[i], bytes[i+1] or 0, bytes[i+2] or 0
        local n = a*65536 + b*256 + c
        r = r
            ..t:sub(math.floor(n/262144)%64+1, math.floor(n/262144)%64+1)
            ..t:sub(math.floor(n/4096)%64+1, math.floor(n/4096)%64+1)
            ..t:sub(math.floor(n/64)%64+1, math.floor(n/64)%64+1)
            ..t:sub(n%64+1, n%64+1)
    end
    if #bytes%3==1 then r=r:sub(1,-3).."=="
    elseif #bytes%3==2 then r=r:sub(1,-2).."=" end
    return r
end

local function je(s)
    return tostring(s):gsub("\\","\\\\"):gsub('"','\\"'):gsub("\n","\\n"):gsub("\r",""):gsub("\t"," ")
end

local function ghRaw(f)
    local ok,r = pcall(function()
        return game:HttpGet(RAW..f.."?t="..os.time(), true)
    end)
    return ok and r or nil
end

local function ghSHA(f)
    local ok,r = pcall(function() return game:HttpGet(API..f, true) end)
    if not ok then return nil end
    return r:match('"sha":"([^"]+)"')
end

local function ghPut(f, content)
    if not _req then return false end
    local sha = ghSHA(f)
    local body = '{"message":"update","content":"'..b64(content)..'"'
    if sha then body = body..',"sha":"'..sha..'"' end
    body = body.."}"
    local ok,res = pcall(_req, {
        Url = API..f,
        Method = "PUT",
        Headers = {
            ["Authorization"] = "token "..GH_TOKEN,
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/vnd.github.v3+json",
        },
        Body = body,
    })
    if not ok then return false end
    local st = res and (res.StatusCode or res.status or 0) or 0
    return st >= 200 and st < 300
end

local function isJunk(name, code)
    if #name < 2 or #code < 10 then return true end
    for _,k in ipairs({"function","local","game","print","loadstring","script","end","if ","for ","while ","return"}) do
        if code:lower():find(k, 1, true) then return false end
    end
    return true
end

-- ======= VIEW COMUNIDADE =======
CommunityView = Instance.new("Frame")
CommunityView.Size = UDim2.new(1,0,1,0)
CommunityView.BackgroundTransparency = 1
CommunityView.Visible = false
CommunityView.ZIndex = 3
CommunityView.Parent = Content

CommTitleLbl = makeLbl(CommunityView, T("community_title"),
    UDim2.new(1,-120,0,30), UDim2.new(0,4,0,5), 4, Enum.TextXAlignment.Left, nil, 14)

BtnNewPublic = makeBtn(CommunityView, T("community_new"),
    UDim2.new(0,110,0,28), UDim2.new(1,-114,0,8), 4)
BtnNewPublic.TextSize = 10

CommScroll = makeScroll(CommunityView,
    UDim2.new(1,-14,1,-48), UDim2.new(0,7,0,42), 3)

CommEmptyLbl = makeLbl(CommunityView, T("community_loading"),
    UDim2.new(1,0,0,50), UDim2.new(0,0,0.4,0), 3,
    nil, Color3.fromRGB(140,140,165), 13)

-- ======= VIEW VOTAÇÃO =======
VoteView = Instance.new("Frame")
VoteView.Size = UDim2.new(1,0,1,0)
VoteView.BackgroundTransparency = 1
VoteView.Visible = false
VoteView.ZIndex = 3
VoteView.Parent = Content

VoteTitleLbl = makeLbl(VoteView, "👥 Votação",
    UDim2.new(1,-120,0,30), UDim2.new(0,4,0,5), 4, Enum.TextXAlignment.Left, nil, 14)

-- Botão adicionar (só admin)
BtnAddVote = makeBtn(VoteView, "＋ Adicionar",
    UDim2.new(0,110,0,28), UDim2.new(1,-114,0,8), 4)
BtnAddVote.TextSize = 10
BtnAddVote.Visible = false -- só aparece para admin

VoteScroll = makeScroll(VoteView,
    UDim2.new(1,-14,1,-48), UDim2.new(0,7,0,42), 3)

VoteEmptyLbl = makeLbl(VoteView, "Nenhuma votação ativa.",
    UDim2.new(1,0,0,50), UDim2.new(0,0,0.4,0), 3,
    nil, Color3.fromRGB(140,140,165), 13)

-- ======= CARREGAR COMUNIDADE =======
local commScripts = {}

local function loadCommunity()
    CommEmptyLbl.Text = T("community_loading")
    CommEmptyLbl.Visible = true
    task.spawn(function()
        local raw = ghRaw("scripts.json")
        commScripts = {}
        if raw then
            for entry in raw:gmatch('{([^{}]+)}') do
                local id      = entry:match('"id":"([^"]*)"')
                local name    = entry:match('"name":"([^"]*)"')
                local author  = entry:match('"author":"([^"]*)"')
                local code    = entry:match('"code":"([^"]*)"')
                local gameId  = entry:match('"gameId":"([^"]*)"') or ""
                local tags    = entry:match('"tags":"([^"]*)"') or ""
                local stars   = tonumber(entry:match('"stars":([%d%.]+)')) or 0
                local likes   = tonumber(entry:match('"likes":(%d+)')) or 0
                local comments= tonumber(entry:match('"comments":(%d+)')) or 0
                local week    = entry:match('"week":"([^"]*)"') or ""
                if id and name and author and code then
                    code = code:gsub("\\n","\n"):gsub('\\"','"')
                    table.insert(commScripts, {
                        id=id, name=name, author=author, code=code,
                        gameId=gameId, tags=tags, stars=stars, likes=likes,
                        comments=comments, week=week
                    })
                end
            end
        end

        for _,c in pairs(CommScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        CommEmptyLbl.Visible = (#commScripts == 0)
        CommEmptyLbl.Text = T("community_empty")

        local banned = getBannedList()
        local weekStr = os.date and os.date("%Y-W%V") or ""

        for _,s in ipairs(commScripts) do
            local isTop = (s.stars >= 4 or s.comments >= 5) and s.week == weekStr
            Card, CS = makeFrame(CommScroll,
                UDim2.new(1,0,0,70), nil, Color3.fromRGB(22,22,30), 4)
            CS.Thickness = isTop and 3 or 2
            CS.Transparency = isTop and 0 or 0.4

            Strip = Instance.new("Frame")
            Strip.Size = UDim2.new(0,4,0.7,0)
            Strip.Position = UDim2.new(0,6,0.15,0)
            Strip.BackgroundColor3 = Color3.fromRGB(110,60,255)
            Strip.BorderSizePixel = 0; Strip.ZIndex = 5; Strip.Parent = Card

            local isBan = banned[s.author:lower()]
            makeLbl(Card, "📄 "..s.name,
                UDim2.new(1,-185,0,20), UDim2.new(0,18,0,5), 5,
                Enum.TextXAlignment.Left, nil, 12)
            makeLbl(Card, "👤 "..s.author..(isBan and " 🚫" or ""),
                UDim2.new(1,-185,0,14), UDim2.new(0,18,0,26), 5,
                Enum.TextXAlignment.Left,
                isBan and Color3.fromRGB(255,80,80) or Color3.fromRGB(140,140,165), 10)
            makeLbl(Card, "⭐"..string.format("%.1f",s.stars).." 💬"..s.comments,
                UDim2.new(1,-185,0,14), UDim2.new(0,18,0,44), 5,
                Enum.TextXAlignment.Left, Color3.fromRGB(180,160,255), 10)

            BRun = makeBtn(Card, "▶", UDim2.new(0,30,0,26), UDim2.new(1,-166,0.5,-13), 5)
            BCom = makeBtn(Card, "💬", UDim2.new(0,30,0,26), UDim2.new(1,-130,0.5,-13), 5)
            BSta = makeBtn(Card, "⭐", UDim2.new(0,30,0,26), UDim2.new(1,-94,0.5,-13), 5)
            BRep = makeBtn(Card, "🚨", UDim2.new(0,30,0,26), UDim2.new(1,-58,0.5,-13), 5)
            BRun.TextSize=11; BCom.TextSize=11; BSta.TextSize=11; BRep.TextSize=11

            if isAdmin() then
                BDel = makeBtn(Card, "🗑", UDim2.new(0,30,0,26), UDim2.new(1,-202,0.5,-13), 5)
                BDel.TextSize = 11
                BDel.BackgroundColor3 = Color3.fromRGB(80,20,20)
                local sc = s
                BDel.MouseButton1Click:Connect(function() openAdminWin(sc) end)
            end

            local sc = s
            BRun.MouseButton1Click:Connect(function() openExecWin(sc) end)
            BCom.MouseButton1Click:Connect(function() openCommWin(sc) end)
            BSta.MouseButton1Click:Connect(function() openStarsWin(sc) end)
            BRep.MouseButton1Click:Connect(function() openReportWin(sc) end)
        end
    end)
end

-- ======= CARREGAR VOTAÇÃO =======
local voteItems = {}

local function loadVotes()
    VoteEmptyLbl.Visible = true
    task.spawn(function()
        local raw = ghRaw("votes.json")
        voteItems = {}
        if raw and raw:find('"votes"') then
            for entry in raw:gmatch('{([^{}]+)}') do
                local id    = entry:match('"id":"([^"]*)"')
                local game  = entry:match('"game":"([^"]*)"')
                local script= entry:match('"script":"([^"]*)"')
                local otimo = tonumber(entry:match('"otimo":(%d+)')) or 0
                local sim   = tonumber(entry:match('"sim":(%d+)')) or 0
                local nao   = tonumber(entry:match('"nao":(%d+)')) or 0
                if id and game then
                    table.insert(voteItems, {id=id, game=game, script=script or "", otimo=otimo, sim=sim, nao=nao})
                end
            end
        end

        for _,c in pairs(VoteScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        VoteEmptyLbl.Visible = (#voteItems == 0)

        for _,v in ipairs(voteItems) do
            Card, CS = makeFrame(VoteScroll,
                UDim2.new(1,0,0,90), nil, Color3.fromRGB(22,22,30), 4)
            CS.Transparency = 0.3

            makeLbl(Card, "🎮 "..v.game,
                UDim2.new(1,-20,0,22), UDim2.new(0,10,0,5), 5,
                Enum.TextXAlignment.Left, nil, 13)
            makeLbl(Card, "📄 "..v.script,
                UDim2.new(1,-20,0,14), UDim2.new(0,10,0,28), 5,
                Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)

            -- Botões de votação com texto e emoji
            local total = v.otimo + v.sim + v.nao
            BOtimo = makeBtn(Card,
                "🌟 Ótimo ("..v.otimo..")",
                UDim2.new(0,118,0,26), UDim2.new(0,8,0,52), 5)
            BOtimo.TextSize = 10
            BOtimo.BackgroundColor3 = Color3.fromRGB(80,60,20)

            BSim = makeBtn(Card,
                "⭐ Sim ("..v.sim..")",
                UDim2.new(0,100,0,26), UDim2.new(0,130,0,52), 5)
            BSim.TextSize = 10
            BSim.BackgroundColor3 = Color3.fromRGB(20,60,20)

            BNao = makeBtn(Card,
                "👎 Não ("..v.nao..")",
                UDim2.new(0,90,0,26), UDim2.new(0,234,0,52), 5)
            BNao.TextSize = 10
            BNao.BackgroundColor3 = Color3.fromRGB(60,20,20)

            local vi = v
            local function castVote(tipo)
                task.spawn(function()
                    local raw2 = ghRaw("votes.json")
                    if not raw2 then notify("❌ Erro de conexão!",220,50,50) return end
                    local newRaw = raw2
                    if tipo == "otimo" then
                        newRaw = newRaw:gsub('("id":"'..vi.id..'"[^}]+"otimo":)(%d+)',
                            function(a,n) return a..tostring(tonumber(n)+1) end)
                    elseif tipo == "sim" then
                        newRaw = newRaw:gsub('("id":"'..vi.id..'"[^}]+"sim":)(%d+)',
                            function(a,n) return a..tostring(tonumber(n)+1) end)
                    elseif tipo == "nao" then
                        newRaw = newRaw:gsub('("id":"'..vi.id..'"[^}]+"nao":)(%d+)',
                            function(a,n) return a..tostring(tonumber(n)+1) end)
                    end
                    local ok = ghPut("votes.json", newRaw)
                    if ok then
                        notify("✅ Voto registrado!", 0, 180, 80)
                        loadVotes()
                    else
                        notify("❌ Erro ao votar!", 220, 50, 50)
                    end
                end)
            end

            BOtimo.MouseButton1Click:Connect(function() castVote("otimo") end)
            BSim.MouseButton1Click:Connect(function() castVote("sim") end)
            BNao.MouseButton1Click:Connect(function() castVote("nao") end)

            if isAdmin() then
                BDelV = makeBtn(Card, "🗑", UDim2.new(0,28,0,22), UDim2.new(1,-34,0,4), 5)
                BDelV.TextSize = 11; BDelV.BackgroundColor3 = Color3.fromRGB(80,20,20)
                local vi2 = v
                BDelV.MouseButton1Click:Connect(function()
                    task.spawn(function()
                        local raw2 = ghRaw("votes.json")
                        if not raw2 then return end
                        local entries = {}
                        for entry in raw2:gmatch('{([^{}]+)}') do
                            local eid = entry:match('"id":"([^"]*)"')
                            if eid and eid ~= vi2.id then
                                table.insert(entries, "{"..entry.."}")
                            end
                        end
                        local total2 = #entries
                        local newRaw = '{"votes":['..table.concat(entries,",")..',"total":'..total2..'}'
                        newRaw = '{"votes":['..table.concat(entries,",")..'],"total":'..total2..'}'
                        local ok = ghPut("votes.json", newRaw)
                        if ok then notify("✅ Removido!",0,180,80) loadVotes() end
                    end)
                end)
            end
        end
    end)
end

-- ======= JANELA: ADICIONAR VOTAÇÃO (admin) =======
AddVoteWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,340,0,230), UDim2.new(0.5,-170,0.5,-115),
    Color3.fromRGB(13,13,18), 400)
AddVoteWin.Visible = false
AVTBar, _ = makeFrame(AddVoteWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
makeLbl(AVTBar, "＋ Nova Votação",
    UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left, nil, 14)
BtnAVClose = makeBtn(AVTBar, "✕", UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 402)
BtnAVClose.MouseButton1Click:Connect(function() AddVoteWin.Visible = false end)

makeLbl(AddVoteWin, "Nome do Jogo:",
    UDim2.new(1,-20,0,16), UDim2.new(0,10,0,46), 401,
    Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
AVGameBox = Instance.new("TextBox")
AVGameBox.Size = UDim2.new(1,-20,0,32); AVGameBox.Position = UDim2.new(0,10,0,64)
AVGameBox.BackgroundColor3 = Color3.fromRGB(22,22,30); AVGameBox.BorderSizePixel = 0
AVGameBox.PlaceholderText = "Ex: Blox Fruits"
AVGameBox.TextColor3 = Color3.fromRGB(240,240,245)
AVGameBox.PlaceholderColor3 = Color3.fromRGB(100,100,120)
AVGameBox.Font = Enum.Font.Gotham; AVGameBox.TextSize = 13
AVGameBox.ZIndex = 401; AVGameBox.ClearTextOnFocus = false; AVGameBox.Text = ""
AVGameBox.Parent = AddVoteWin
local p1 = Instance.new("UIPadding"); p1.PaddingLeft = UDim.new(0,10); p1.Parent = AVGameBox

makeLbl(AddVoteWin, "Nome do Script:",
    UDim2.new(1,-20,0,16), UDim2.new(0,10,0,104), 401,
    Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
AVScriptBox = Instance.new("TextBox")
AVScriptBox.Size = UDim2.new(1,-20,0,32); AVScriptBox.Position = UDim2.new(0,10,0,122)
AVScriptBox.BackgroundColor3 = Color3.fromRGB(22,22,30); AVScriptBox.BorderSizePixel = 0
AVScriptBox.PlaceholderText = "Ex: Script de Fly v3"
AVScriptBox.TextColor3 = Color3.fromRGB(240,240,245)
AVScriptBox.PlaceholderColor3 = Color3.fromRGB(100,100,120)
AVScriptBox.Font = Enum.Font.Gotham; AVScriptBox.TextSize = 13
AVScriptBox.ZIndex = 401; AVScriptBox.ClearTextOnFocus = false; AVScriptBox.Text = ""
AVScriptBox.Parent = AddVoteWin
local p2 = Instance.new("UIPadding"); p2.PaddingLeft = UDim.new(0,10); p2.Parent = AVScriptBox

BtnAVSubmit = makeBtn(AddVoteWin, "✅ Criar Votação",
    UDim2.new(0,155,0,34), UDim2.new(0,10,1,-44), 402)
BtnAVCancel = makeBtn(AddVoteWin, "✕ Cancelar",
    UDim2.new(0,145,0,34), UDim2.new(1,-155,1,-44), 402)
BtnAVCancel.MouseButton1Click:Connect(function() AddVoteWin.Visible = false end)
BtnAVSubmit.MouseButton1Click:Connect(function()
    local game_name = AVGameBox.Text
    local script_name = AVScriptBox.Text
    if game_name == "" then notify("⚠️ Nome do jogo vazio!",255,190,0) return end
    AddVoteWin.Visible = false
    notify("📤 Criando votação...", 110, 60, 255)
    task.spawn(function()
        local raw = ghRaw("votes.json") or '{"votes":[],"total":0}'
        local id = "vote_"..tostring(os.time())
        local entry = '{"id":"'..je(id)..'","game":"'..je(game_name)..'","script":"'..je(script_name)..'","otimo":0,"sim":0,"nao":0}'
        local newRaw
        if raw:find('"votes":%[%]') then
            newRaw = raw:gsub('"votes":%[%]', '"votes":['..entry..']')
        else
            newRaw = raw:gsub('"votes":%[', '"votes":['..entry..',')
        end
        local t = (tonumber(raw:match('"total":(%d+)')) or 0) + 1
        newRaw = newRaw:gsub('"total":%d+', '"total":'..t)
        local ok = ghPut("votes.json", newRaw)
        notify(ok and "✅ Votação criada!" or "❌ Erro!", ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if ok then AVGameBox.Text=""; AVScriptBox.Text=""; loadVotes() end
    end)
end)

-- ======= JANELA EXECUTAR =======
ExecWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,300,0,160), UDim2.new(0.5,-150,0.5,-80),
    Color3.fromRGB(13,13,18), 400)
ExecWin.Visible = false
ExecTBar, _ = makeFrame(ExecWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
ExecTitle = makeLbl(ExecTBar, T("exec_title"), UDim2.new(1,-20,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left, nil, 13)
ExecDesc = makeLbl(ExecWin, "", UDim2.new(1,-20,0,22), UDim2.new(0,10,0,46), 401, Enum.TextXAlignment.Left, Color3.fromRGB(180,180,200), 12)
ExecAuth = makeLbl(ExecWin, "", UDim2.new(1,-20,0,16), UDim2.new(0,10,0,70), 401, Enum.TextXAlignment.Left, Color3.fromRGB(120,120,150), 10)
BtnExecOk = makeBtn(ExecWin, T("exec_confirm"), UDim2.new(0,120,0,34), UDim2.new(0,10,1,-44), 402)
BtnExecNo = makeBtn(ExecWin, T("exec_cancel"), UDim2.new(0,120,0,34), UDim2.new(1,-130,1,-44), 402)
BtnExecNo.MouseButton1Click:Connect(function() ExecWin.Visible = false end)
local _curExec = nil
local function openExecWin(sc)
    if isBanned(sc.author) then notify("🚫 Usuário banido!", 220,50,50) return end
    _curExec = sc
    ExecTitle.Text = T("exec_title")
    ExecDesc.Text = "📄 "..sc.name
    ExecAuth.Text = "👤 "..sc.author
    BtnExecOk.Text = T("exec_confirm")
    BtnExecNo.Text = T("exec_cancel")
    ExecWin.Visible = true
end
BtnExecOk.MouseButton1Click:Connect(function()
    if not _curExec then return end
    ExecWin.Visible = false
    local ok, err = pcall(function()
        local fn = loadstring(_curExec.code)
        if fn then fn() end
    end)
    notify(ok and T("exec_ok") or T("exec_err"), ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
    if not ok then print("Exec err:", err) end
end)

-- ======= JANELA COMENTÁRIOS =======
CommWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,320,0,380), UDim2.new(0.5,-160,0.5,-190),
    Color3.fromRGB(13,13,18), 400)
CommWin.Visible = false
CommWTBar, _ = makeFrame(CommWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
CommWTitle = makeLbl(CommWTBar, T("comment_title"), UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left)
BtnCommClose = makeBtn(CommWTBar, "✕", UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 402)
BtnCommClose.MouseButton1Click:Connect(function() CommWin.Visible = false end)
CommList = makeScroll(CommWin, UDim2.new(1,-12,1,-100), UDim2.new(0,6,0,44), 401)
CommBox = Instance.new("TextBox")
CommBox.Size = UDim2.new(1,-90,0,34); CommBox.Position = UDim2.new(0,8,1,-44)
CommBox.BackgroundColor3 = Color3.fromRGB(22,22,30); CommBox.BorderSizePixel = 0
CommBox.PlaceholderText = T("comment_ph")
CommBox.TextColor3 = Color3.fromRGB(240,240,245)
CommBox.PlaceholderColor3 = Color3.fromRGB(100,100,120)
CommBox.Font = Enum.Font.Gotham; CommBox.TextSize = 12
CommBox.ZIndex = 401; CommBox.ClearTextOnFocus = false; CommBox.Text = ""
CommBox.Parent = CommWin
local cbp = Instance.new("UIPadding"); cbp.PaddingLeft = UDim.new(0,8); cbp.Parent = CommBox
BtnCommSend = makeBtn(CommWin, T("comment_send"), UDim2.new(0,74,0,34), UDim2.new(1,-82,1,-44), 402)
BtnCommSend.TextSize = 11
local _curComm = nil
local function openCommWin(sc)
    _curComm = sc
    CommWTitle.Text = T("comment_title").." - "..sc.name
    CommBox.Text = ""
    for _,c in pairs(CommList:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    CommWin.Visible = true
    task.spawn(function()
        local raw = ghRaw("scripts.json")
        if not raw then return end
        for entry in raw:gmatch('{([^{}]+)}') do
            if entry:find('"id":"'..sc.id..'"', 1, true) then
                local clist = entry:match('"comments_list":%[(.-)%]') or ""
                for a,t in clist:gmatch('"author":"([^"]+)","text":"([^"]+)"') do
                    CF, _ = makeFrame(CommList, UDim2.new(1,0,0,50), nil, Color3.fromRGB(22,22,30), 402)
                    makeLbl(CF, "👤 "..a, UDim2.new(1,-10,0,16), UDim2.new(0,8,0,4), 403, Enum.TextXAlignment.Left, Color3.fromRGB(180,160,255), 10)
                    local tl = makeLbl(CF, t, UDim2.new(1,-10,0,26), UDim2.new(0,8,0,22), 403, Enum.TextXAlignment.Left, Color3.fromRGB(220,220,240), 11)
                    tl.TextWrapped = true
                end
                break
            end
        end
    end)
end
BtnCommSend.MouseButton1Click:Connect(function()
    if not _curComm then return end
    local txt = CommBox.Text
    if txt == "" then notify(T("comment_warn"),255,190,0) return end
    if txt:lower():find("http") or txt:lower():find("www%.") then
        notify(T("comment_warn_link"),255,50,50) return
    end
    CommBox.Text = ""
    task.spawn(function()
        local raw = ghRaw("scripts.json")
        if not raw then notify(T("pub_err"),220,50,50) return end
        local sc = _curComm
        local entry = '{"author":"'..je(player.Name)..'","text":"'..je(txt)..'"}'
        local newRaw = raw:gsub('("id":"'..sc.id..'"[^}]+"comments":)(%d+)',
            function(a,n) return a..tostring(tonumber(n)+1) end)
        if newRaw:find('"comments_list":%[%]') then
            newRaw = newRaw:gsub('"comments_list":%[%]', '"comments_list":['..entry..']', 1)
        else
            newRaw = newRaw:gsub('"comments_list":%[', '"comments_list":['..entry..',', 1)
        end
        local ok = ghPut("scripts.json", newRaw)
        notify(ok and T("comment_ok") or T("pub_err"), ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if ok then openCommWin(sc) end
    end)
end)

-- ======= JANELA ESTRELAS =======
StarsWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,300,0,170), UDim2.new(0.5,-150,0.5,-85),
    Color3.fromRGB(13,13,18), 400)
StarsWin.Visible = false
StarsTBar, _ = makeFrame(StarsWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
StarsTitle = makeLbl(StarsTBar, T("stars_title"), UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left)
BtnStarsX = makeBtn(StarsTBar, "✕", UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 402)
BtnStarsX.MouseButton1Click:Connect(function() StarsWin.Visible = false end)
StarsDesc = makeLbl(StarsWin, "", UDim2.new(1,-20,0,18), UDim2.new(0,10,0,46), 401, Enum.TextXAlignment.Left, Color3.fromRGB(180,180,200), 12)
local selStars = 0
local starBtns = {}
for i = 1, 5 do
    local sb = makeBtn(StarsWin, i==5 and "🌟" or "⭐",
        UDim2.new(0,40,0,40), UDim2.new(0,-10+i*46,0,70), 402)
    sb.TextSize = 20; sb.BackgroundTransparency = 1
    table.insert(starBtns, sb)
    sb.MouseButton1Click:Connect(function()
        selStars = i
        for j,b in ipairs(starBtns) do
            b.BackgroundColor3 = j<=i and Color3.fromRGB(60,40,110) or Color3.fromRGB(20,20,30)
        end
    end)
end
BtnStarsSend = makeBtn(StarsWin, "⭐ Enviar",
    UDim2.new(1,-20,0,32), UDim2.new(0,10,1,-42), 402)
BtnStarsSend.TextSize = 12
local _curStars = nil
local function openStarsWin(sc)
    _curStars = sc
    StarsTitle.Text = T("stars_title")
    StarsDesc.Text = "📄 "..sc.name
    selStars = 0
    for _,b in ipairs(starBtns) do b.BackgroundColor3 = Color3.fromRGB(20,20,30) end
    StarsWin.Visible = true
end
BtnStarsSend.MouseButton1Click:Connect(function()
    if not _curStars then return end
    if _curStars.author:lower() == player.Name:lower() then
        notify(T("stars_own"),255,190,0) return
    end
    if selStars == 0 then notify("⚠️ Selecione uma estrela!",255,190,0) return end
    StarsWin.Visible = false
    task.spawn(function()
        local raw = ghRaw("scripts.json")
        if not raw then notify(T("pub_err"),220,50,50) return end
        local sc = _curStars
        local newLikes = sc.likes + 1
        local newStars = (sc.stars * sc.likes + selStars) / newLikes
        local newRaw = raw:gsub(
            '("id":"'..sc.id..'"[^}]+"stars":)([%d%.]+)([^}]+"likes":)(%d+)',
            function(a,_,b,_) return a..string.format("%.1f",newStars)..b..newLikes end)
        local ok = ghPut("scripts.json", newRaw)
        notify(ok and T("stars_ok") or T("pub_err"), ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if ok then loadCommunity() end
    end)
end)

-- ======= JANELA DENUNCIAR =======
ReportWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,310,0,170), UDim2.new(0.5,-155,0.5,-85),
    Color3.fromRGB(13,13,18), 400)
ReportWin.Visible = false
ReportTBar, _ = makeFrame(ReportWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
ReportTitle = makeLbl(ReportTBar, T("report_title"), UDim2.new(1,-20,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left, nil, 13)
ReportDesc = makeLbl(ReportWin, "", UDim2.new(1,-20,0,44), UDim2.new(0,10,0,46), 401, nil, Color3.fromRGB(200,180,180), 11)
ReportDesc.TextWrapped = true
BtnRepOk = makeBtn(ReportWin, T("report_confirm"), UDim2.new(0,130,0,34), UDim2.new(0,10,1,-44), 402)
BtnRepNo = makeBtn(ReportWin, T("report_cancel"), UDim2.new(0,130,0,34), UDim2.new(1,-140,1,-44), 402)
BtnRepNo.MouseButton1Click:Connect(function() ReportWin.Visible = false end)
local _curReport = nil
local function openReportWin(sc)
    _curReport = sc
    ReportTitle.Text = T("report_title")
    ReportDesc.Text = 'Denunciar "'..sc.name..'" por '..sc.author..'?'
    BtnRepOk.Text = T("report_confirm")
    BtnRepNo.Text = T("report_cancel")
    ReportWin.Visible = true
end
BtnRepOk.MouseButton1Click:Connect(function()
    if not _curReport then return end
    ReportWin.Visible = false
    task.spawn(function()
        local raw = ghRaw("reports.json") or '{"reports":[],"total":0}'
        local sc = _curReport
        local entry = '{"id":"'..je(sc.id)..'","name":"'..je(sc.name)..'","author":"'..je(sc.author)..'","reporter":"'..player.Name..'","time":"'..os.time()..'"}'
        local newRaw
        if raw:find('"reports":%[%]') then
            newRaw = raw:gsub('"reports":%[%]', '"reports":['..entry..']')
        else
            newRaw = raw:gsub('"reports":%[', '"reports":['..entry..',')
        end
        local t = (tonumber(raw:match('"total":(%d+)')) or 0) + 1
        newRaw = newRaw:gsub('"total":%d+', '"total":'..t)
        local ok = ghPut("reports.json", newRaw)
        notify(ok and T("report_ok") or T("pub_err"), ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
    end)
end)

-- ======= JANELA ADMIN =======
AdminWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,320,0,260), UDim2.new(0.5,-160,0.5,-130),
    Color3.fromRGB(13,13,18), 500)
AdminWin.Visible = false
AdminTBar, _ = makeFrame(AdminWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(40,10,10), 501)
makeLbl(AdminTBar, "🛡 Painel Admin", UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 502, Enum.TextXAlignment.Left, Color3.fromRGB(255,100,100), 14)
BtnAdmX = makeBtn(AdminTBar, "✕", UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 502)
BtnAdmX.MouseButton1Click:Connect(function() AdminWin.Visible = false end)
AdminScLbl = makeLbl(AdminWin, "", UDim2.new(1,-20,0,18), UDim2.new(0,10,0,46), 501, Enum.TextXAlignment.Left, Color3.fromRGB(220,200,200), 12)
AdminAuLbl = makeLbl(AdminWin, "", UDim2.new(1,-20,0,14), UDim2.new(0,10,0,66), 501, Enum.TextXAlignment.Left, Color3.fromRGB(180,140,140), 11)
makeLbl(AdminWin, "🔑 Senha:", UDim2.new(1,-20,0,16), UDim2.new(0,10,0,88), 501, Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
AdminPwBox = Instance.new("TextBox")
AdminPwBox.Size = UDim2.new(1,-20,0,32); AdminPwBox.Position = UDim2.new(0,10,0,106)
AdminPwBox.BackgroundColor3 = Color3.fromRGB(30,15,15); AdminPwBox.BorderSizePixel = 0
AdminPwBox.PlaceholderText = "Senha admin..."
AdminPwBox.TextColor3 = Color3.fromRGB(255,180,180)
AdminPwBox.PlaceholderColor3 = Color3.fromRGB(100,80,80)
AdminPwBox.Font = Enum.Font.Code; AdminPwBox.TextSize = 12
AdminPwBox.ZIndex = 501; AdminPwBox.ClearTextOnFocus = false; AdminPwBox.Text = ""
AdminPwBox.Parent = AdminWin
local apwp = Instance.new("UIPadding"); apwp.PaddingLeft = UDim.new(0,10); apwp.Parent = AdminPwBox

BtnAdmDel = makeBtn(AdminWin, "🗑 Deletar", UDim2.new(0,95,0,32), UDim2.new(0,10,0,148), 502)
BtnAdmDel.BackgroundColor3 = Color3.fromRGB(80,20,20); BtnAdmDel.TextSize = 12
BtnAdmBan = makeBtn(AdminWin, "🚫 Banir", UDim2.new(0,95,0,32), UDim2.new(0,110,0,148), 502)
BtnAdmBan.BackgroundColor3 = Color3.fromRGB(60,20,60); BtnAdmBan.TextSize = 12
BtnAdmBoth = makeBtn(AdminWin, "💀 Deletar + Banir", UDim2.new(1,-20,0,32), UDim2.new(0,10,0,188), 502)
BtnAdmBoth.BackgroundColor3 = Color3.fromRGB(80,10,10); BtnAdmBoth.TextSize = 12

local _curAdmin = nil
local function openAdminWin(sc)
    _curAdmin = sc; AdminPwBox.Text = ""
    AdminScLbl.Text = "📄 "..sc.name
    AdminAuLbl.Text = "👤 "..sc.author
    AdminWin.Visible = true
end

local function adminDelete(sc, pw)
    if pw ~= _pw then notify("❌ Senha errada!",220,50,50) return false end
    local raw = ghRaw("scripts.json")
    if not raw then notify("❌ Sem conexão!",220,50,50) return false end
    local entries = {}
    for entry in raw:gmatch('{([^{}]+)}') do
        local id = entry:match('"id":"([^"]*)"')
        if id and id ~= sc.id then
            table.insert(entries, "{"..entry.."}")
        end
    end
    local newRaw = '{"scripts":['..table.concat(entries,",")..'],"total":'..#entries..'}'
    local ok = ghPut("scripts.json", newRaw)
    if ok then notify("✅ Script deletado!",0,180,80); loadCommunity() end
    return ok
end

BtnAdmDel.MouseButton1Click:Connect(function()
    if not _curAdmin then return end
    AdminWin.Visible = false
    task.spawn(function() adminDelete(_curAdmin, AdminPwBox.Text) end)
end)
BtnAdmBan.MouseButton1Click:Connect(function()
    if not _curAdmin then return end
    local ok, reason = banUser(_curAdmin.author, AdminPwBox.Text)
    if ok then
        notify("🚫 "..(_curAdmin.author).." banido!",180,0,180)
        AdminWin.Visible = false; loadCommunity()
    elseif reason == "senha" then notify("❌ Senha errada!",220,50,50)
    elseif reason == "ja" then notify("⚠️ Já banido!",255,190,0) end
end)
BtnAdmBoth.MouseButton1Click:Connect(function()
    if not _curAdmin then return end
    local sc = _curAdmin; local pw = AdminPwBox.Text
    AdminWin.Visible = false
    task.spawn(function()
        if adminDelete(sc, pw) then
            local ok,_ = banUser(sc.author, pw)
            if ok then notify("💀 Deletado + Banido!",180,0,0) end
        end
    end)
end)

-- ======= JANELA PUBLICAR =======
PubWin, _ = makeFrame(ScreenGui,
    UDim2.new(0,370,0,480), UDim2.new(0.5,-185,0.5,-240),
    Color3.fromRGB(13,13,18), 400)
PubWin.Visible = false
PubTBar, _ = makeFrame(PubWin, UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 401)
makeLbl(PubTBar, T("pub_title"), UDim2.new(1,-40,1,0), UDim2.new(0,12,0,0), 402, Enum.TextXAlignment.Left, nil, 14)
BtnPubX = makeBtn(PubTBar, "✕", UDim2.new(0,26,0,26), UDim2.new(1,-32,0.5,-13), 402)
BtnPubX.MouseButton1Click:Connect(function() PubWin.Visible = false end)

local function plbl(txt, y)
    return makeLbl(PubWin, txt, UDim2.new(1,-20,0,16), UDim2.new(0,10,0,y),
        401, Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 11)
end
local function pbox(y, h, ph, isCode)
    local B = Instance.new("TextBox")
    B.Size = UDim2.new(1,-20,0,h); B.Position = UDim2.new(0,10,0,y)
    B.BackgroundColor3 = Color3.fromRGB(22,22,30); B.BorderSizePixel = 0
    B.PlaceholderText = ph
    B.TextColor3 = isCode and Color3.fromRGB(0,210,100) or Color3.fromRGB(240,240,245)
    B.PlaceholderColor3 = Color3.fromRGB(100,100,120)
    B.Font = isCode and Enum.Font.Code or Enum.Font.Gotham
    B.TextSize = isCode and 11 or 13; B.ZIndex = 401
    B.ClearTextOnFocus = false; B.Text = ""; B.Parent = PubWin
    if isCode then
        B.MultiLine = true
        B.TextXAlignment = Enum.TextXAlignment.Left
        B.TextYAlignment = Enum.TextYAlignment.Top
    end
    local p = Instance.new("UIPadding"); p.PaddingLeft = UDim.new(0,10)
    if isCode then p.PaddingTop = UDim.new(0,6) end; p.Parent = B
    return B
end

plbl(T("pub_name"), 46); local PubName = pbox(64, 32, T("pub_name_ph"), false)
plbl(T("pub_code"), 104); local PubCode = pbox(122, 110, T("pub_code_ph"), true)
plbl(T("pub_game"), 240); local PubGame = pbox(258, 30, T("pub_game_ph"), false)
plbl(T("pub_tags"), 296)

local TAGS = {
    {"tag_key","🔑"},{"tag_free","✅"},{"tag_autofarm","🌾"},{"tag_esp","👁"},
    {"tag_fly","🕊"},{"tag_speed","⚡"},{"tag_noclip","👻"},{"tag_aimbot","🎯"},
    {"tag_god","🛡"},{"tag_tp","🌀"},{"tag_inf_jump","🦘"},{"tag_kill_all","💀"},
}
local selTags = {}
for i, tag in ipairs(TAGS) do
    local row = math.floor((i-1)/4); local col = (i-1)%4
    TB = makeBtn(PubWin, tag[2].." "..T(tag[1]),
        UDim2.new(0,78,0,24), UDim2.new(0,10+col*88,0,314+row*28), 402)
    TB.TextSize = 9
    local tk = tag[1]
    TB.MouseButton1Click:Connect(function()
        selTags[tk] = not selTags[tk]
        TB.BackgroundColor3 = selTags[tk] and Color3.fromRGB(60,40,110) or Color3.fromRGB(20,20,30)
    end)
end

BtnPubOk = makeBtn(PubWin, T("pub_btn"), UDim2.new(0,155,0,34), UDim2.new(0,10,1,-44), 402)
BtnPubNo = makeBtn(PubWin, T("pub_cancel"), UDim2.new(0,155,0,34), UDim2.new(1,-165,1,-44), 402)
BtnPubNo.MouseButton1Click:Connect(function() PubWin.Visible = false end)
BtnPubOk.MouseButton1Click:Connect(function()
    local name = PubName.Text; local code = PubCode.Text
    if name == "" then notify(T("pub_warn_name"),255,190,0) return end
    if code == "" then notify(T("pub_warn_code"),255,190,0) return end
    if isJunk(name, code) then notify(T("pub_warn_junk"),255,80,0) return end
    if isBanned(player.Name) then notify("🚫 Você está banido!",220,50,50) return end
    local tagsStr = ""
    for k,v in pairs(selTags) do if v then tagsStr = tagsStr..k.."," end end
    local week = os.date and os.date("%Y-W%V") or "2026"
    local id = player.Name.."_"..tostring(os.time())
    local entry = '{"id":"'..je(id)..'","name":"'..je(name)..'","author":"'..je(player.Name)..'","code":"'..je(code)..'","gameId":"'..je(PubGame.Text)..'","tags":"'..tagsStr..'","likes":0,"stars":0,"comments":0,"comments_list":[],"week":"'..week..'"}'
    PubWin.Visible = false
    notify("📤 Publicando...", 110, 60, 255)
    task.spawn(function()
        local raw = ghRaw("scripts.json") or '{"scripts":[],"total":0}'
        local newRaw
        local total = (tonumber(raw:match('"total":(%d+)')) or 0) + 1
        if raw:find('"scripts":%[%]') then
            newRaw = raw:gsub('"scripts":%[%]', '"scripts":['..entry..']')
        else
            newRaw = raw:gsub('"scripts":%[', '"scripts":['..entry..',')
        end
        newRaw = newRaw:gsub('"total":%d+', '"total":'..total)
        local ok = ghPut("scripts.json", newRaw)
        notify(ok and T("pub_ok") or T("pub_err"), ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if ok then
            PubName.Text=""; PubCode.Text=""; PubGame.Text=""; selTags={}
            loadCommunity()
        end
    end)
end)

BtnNewPublic.MouseButton1Click:Connect(function()
    if isBanned(player.Name) then notify("🚫 Você está banido!",220,50,50) return end
    PubName.Text=""; PubCode.Text=""; PubGame.Text=""; selTags={}
    PubWin.Visible = true
end)

BtnAddVote.MouseButton1Click:Connect(function()
    AVGameBox.Text=""; AVScriptBox.Text=""
    AddVoteWin.Visible = true
end)

-- Toggle views
local gamesMode=false
local communityMode=false
local voteMode=false

local function showScripts()
    gamesMode=false; communityMode=false; voteMode=false
    GamesView.Visible=false
    CommunityView.Visible=false
    VoteView.Visible=false
    ScriptsView.Visible=true
    BtnNew.Visible=true
end
local function showGames()
    gamesMode=true
    ScriptsView.Visible=false; GamesView.Visible=true
    BtnNew.Visible=false
    GamesTitleLbl.Text=T("games_title")
    IYName.Text=T("game_iy"); IYScript.Text=T("game_iy_script")
    IYTagLbl.Text=T("game_iy_tag"); BtnIY.Text=T("game_run")
    MM2Name.Text=T("game_mm2"); MM2Script.Text=T("game_yarhm")
    BtnMM2.Text=T("game_run"); BtnGamesBack.Text=T("games_back")
end

local function showCommunity()
    communityMode=true; gamesMode=false
    ScriptsView.Visible=false; GamesView.Visible=false
    CommunityView.Visible=true; BtnNew.Visible=false
    CommTitleLbl.Text=T("community_title")
    BtnNewPublic.Text=T("community_new")
    loadCommunityScripts()
end
local function hideAll()
    communityMode=false; gamesMode=false
    CommunityView.Visible=false; GamesView.Visible=false
    ScriptsView.Visible=true; BtnNew.Visible=true
end
BtnCommunity.MouseButton1Click:Connect(function()
    if communityMode then hideAll() else showCommunity() end
end)
BtnGames.MouseButton1Click:Connect(function()
    if gamesMode then showScripts() else showGames() end
end)

BtnCommunity.MouseButton1Click:Connect(function()
    if communityMode then
        showScripts()
    else
        communityMode=true; gamesMode=false; voteMode=false
        ScriptsView.Visible=false; GamesView.Visible=false; VoteView.Visible=false
        CommunityView.Visible=true; BtnNew.Visible=false
        CommTitleLbl.Text=T("community_title")
        BtnNewPublic.Text=T("community_new")
        loadCommunity()
    end
end)

BtnVote.MouseButton1Click:Connect(function()
    if voteMode then
        showScripts()
    else
        voteMode=true; communityMode=false; gamesMode=false
        ScriptsView.Visible=false; GamesView.Visible=false; CommunityView.Visible=false
        VoteView.Visible=true; BtnNew.Visible=false
        VoteTitleLbl.Text="👥 Votação"
        BtnAddVote.Visible=isAdmin()
        loadVotes()
    end
end)
BtnGamesBack.MouseButton1Click:Connect(showScripts)

-- Hub confirmação IY
IYWindow,_=makeFrame(ScreenGui,
    UDim2.new(0,300,0,180), UDim2.new(0.5,-150,0.5,-90),
    Color3.fromRGB(13,13,18), 150)
IYWindow.Visible=false
IYTBar,_=makeFrame(IYWindow,
    UDim2.new(1,0,0,38), UDim2.new(0,0,0,0), Color3.fromRGB(20,20,30), 151)
IYTitleLbl=makeLbl(IYTBar, "📍 Infinite Yield",
    UDim2.new(1,-20,1,0), UDim2.new(0,12,0,0), 152, Enum.TextXAlignment.Left, nil, 14)
IYWDesc=makeLbl(IYWindow, T("game_iy_script"),
    UDim2.new(1,-20,0,22), UDim2.new(0,10,0,48), 151,
    Enum.TextXAlignment.Left, Color3.fromRGB(180,180,200), 12)
makeLbl(IYWindow, "github.com/EdgeIY/infiniteyield",
    UDim2.new(1,-20,0,16), UDim2.new(0,10,0,72), 151,
    Enum.TextXAlignment.Left, Color3.fromRGB(100,100,130), 10)
BtnIYRun=makeBtn(IYWindow, T("game_run"),
    UDim2.new(0,120,0,36), UDim2.new(0,12,1,-48), 152)
BtnIYCancel=makeBtn(IYWindow, T("game_cancel"),
    UDim2.new(0,120,0,36), UDim2.new(1,-132,1,-48), 152)
BtnIYCancel.MouseButton1Click:Connect(function() IYWindow.Visible=false end)
BtnIYRun.MouseButton1Click:Connect(function()
    BtnIYRun.Text=T("game_executing"); IYWindow.Visible=false
    notify(T("game_executing"),110,60,255)
    task.delay(0.5, function()
        local ok,err=pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end)
        notify(ok and T("game_executed") or T("game_error"),
            ok and 0 or 220, ok and 180 or 50, ok and 80 or 50)
        if not ok then print("IY Erro:",err) end
        BtnIYRun.Text=T("game_run")
    end)
end)

BtnIY.MouseButton1Click:Connect(function()
    IYTitleLbl.Text="📍 Infinite Yield"
    IYWDesc.Text=T("game_iy_script")
    BtnIYRun.Text=T("game_run"); BtnIYCancel.Text=T("game_cancel")
    IYWindow.Visible=true
end)

BtnMM2.MouseButton1Click:Connect(function()
    YARHMTitleLbl.Text=T("game_confirm_title")
    YARHMDesc.Text=T("game_yarhm")
    BtnYARHMRun.Text=T("game_run"); BtnYARHMCancel.Text=T("game_cancel")
    YARHMWindow.Visible=true
end)

-- Config
BtnCfg.MouseButton1Click:Connect(function()
    ConfigTitleLbl.Text=T("config_title")
    BtnLangOpt.Text=T("lang_btn"); BtnColorOpt.Text=T("color_btn")
    if not isNight then BtnDayNight.Text=T("daynight_btn") end
    if not fpsOn   then BtnFPS.Text=T("fps_btn") end
    BtnPing.Text=T("ping_btn")
    Config.Visible=not Config.Visible
end)

-- Lista de scripts
local editingName=nil
local function refreshList()
    for _,c in pairs(Scroll:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    local scripts=getAllScripts()
    EmptyLbl.Visible=(#scripts==0)
    for _,s in pairs(scripts) do
        Card,CS=makeFrame(Scroll,
            UDim2.new(1,0,0,60), nil, Color3.fromRGB(22,22,30), 4)
        CS.Transparency=0.4
        Strip=Instance.new("Frame")
        Strip.Size=UDim2.new(0,4,0.6,0); Strip.Position=UDim2.new(0,8,0.2,0)
        Strip.BackgroundColor3=Color3.fromRGB(110,60,255)
        Strip.BorderSizePixel=0; Strip.ZIndex=5; Strip.Parent=Card
        CardName=makeLbl(Card,"📄 "..s.name,
            UDim2.new(1,-165,0,22), UDim2.new(0,22,0,8), 5,
            Enum.TextXAlignment.Left, nil, 13)
        CardPrev=makeLbl(Card, string.sub(s.code,1,40)..(#s.code>40 and "..." or ""),
            UDim2.new(1,-165,0,16), UDim2.new(0,22,0,33), 5,
            Enum.TextXAlignment.Left, Color3.fromRGB(140,140,165), 10)
        CardPrev.Font=Enum.Font.Code
        BRC=makeBtn(Card,T("card_run"),  UDim2.new(0,36,0,36),UDim2.new(1,-118,0.5,-18),5)
        BEC=makeBtn(Card,T("card_edit"), UDim2.new(0,36,0,36),UDim2.new(1,-76,0.5,-18), 5)
        BDC=makeBtn(Card,T("card_delete"),UDim2.new(0,36,0,36),UDim2.new(1,-34,0.5,-18),5)
        local sName,sCode=s.name,s.code
        BRC.MouseButton1Click:Connect(function()
            local ok,err=pcall(function()
                local fn=loadstring(sCode); if fn then fn() end
            end)
            notify(ok and T("notif_executed")..sName or T("notif_error"),
                ok and 0 or 220, ok and 160 or 50, ok and 255 or 60)
            if not ok then print("Erro:",err) end
        end)
        BEC.MouseButton1Click:Connect(function()
            editingName=sName; NameBox.Text=sName; CodeBox.Text=sCode
            EdTitleLbl.Text=T("editor_edit")..sName
            EdNameLbl.Text=T("editor_name_label")
            EdCodeLbl.Text=T("editor_code_label")
            Editor.Visible=true
        end)
        BDC.MouseButton1Click:Connect(function()
            deleteScript(sName)
            notify(T("notif_deleted")..sName,220,50,60)
            refreshList()
        end)
    end
end

BtnNew.MouseButton1Click:Connect(function()
    editingName=nil; NameBox.Text=""; CodeBox.Text=""
    EdTitleLbl.Text=T("editor_new")
    EdNameLbl.Text=T("editor_name_label"); EdCodeLbl.Text=T("editor_code_label")
    NameBox.PlaceholderText=T("editor_name_ph"); CodeBox.PlaceholderText=T("editor_code_ph")
    BtnSave.Text=T("btn_save"); BtnCancel.Text=T("btn_cancel"); BtnRun.Text=T("btn_run")
    Editor.Visible=true
end)
BtnSave.MouseButton1Click:Connect(function()
    local name,code=NameBox.Text,CodeBox.Text
    if name=="" then notify(T("notif_warn_name"),255,190,0) return end
    if code=="" then notify(T("notif_warn_code"),255,190,0) return end
    if editingName and editingName~=name then deleteScript(editingName) end
    saveScript(name,code)
    notify(T("notif_saved")..name,0,210,100)
    Editor.Visible=false; refreshList()
end)
BtnCancel.MouseButton1Click:Connect(function() Editor.Visible=false end)
BtnRun.MouseButton1Click:Connect(function()
    local code=CodeBox.Text
    if code=="" then notify(T("notif_warn_code"),255,190,0) return end
    local ok,err=pcall(function()
        local fn=loadstring(code); if fn then fn() end
    end)
    notify(ok and "▶ OK!" or T("notif_error"),
        ok and 0 or 220, ok and 160 or 50, ok and 255 or 60)
    if not ok then print("Erro:",err) end
end)

-- Titlebar
local minimized=false; local originalSize=Main.Size; local expanded=false
BtnClose.MouseButton1Click:Connect(function() Main.Visible=false end)
BtnMinimize.MouseButton1Click:Connect(function()
    minimized=not minimized; Content.Visible=not minimized
    Main.Size=minimized and UDim2.new(0,560,0,45) or originalSize
end)
BtnExpand.MouseButton1Click:Connect(function()
    expanded=not expanded
    if expanded then
        Main.Size=UDim2.new(0,750,0,400); Main.Position=UDim2.new(0.5,-375,0.5,-200)
    else
        Main.Size=originalSize; Main.Position=UDim2.new(0.5,-280,0.5,-140)
    end
end)

-- Drag
local dragging,dragInput,mousePos,framePos=false,nil,nil,nil
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or
       input.UserInputType==Enum.UserInputType.Touch then
        dragging=true; mousePos=input.Position; framePos=Main.Position
        input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then dragging=false end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseMovement or
       input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input==dragInput and dragging then
        local delta=input.Position-mousePos
        Main.Position=UDim2.new(
            framePos.X.Scale, framePos.X.Offset+delta.X,
            framePos.Y.Scale, framePos.Y.Offset+delta.Y)
    end
end)

-- RGB loop
local hue=0
RunService.RenderStepped:Connect(function(dt)
    hue=(hue+dt*0.25)%1
    local col=getBorderColor(hue)
    local titleCol=(borderMode=="off") and Color3.fromRGB(180,180,180) or col
    MainStroke.Color=col; TitleStroke.Color=col
    EdStroke.Color=col; EdTStroke.Color=col
    TitleLbl.TextColor3=titleCol
    for _,s in pairs(rgbStrokes) do pcall(function() s.Color=col end) end
end)

-- Iniciar
-- ======= SPLASH SCREEN =======
IS_FIRST_TIME = not isfile("DeltaHub/PNGANIM.PNG")
IMG_URL = "https://cdn.discordapp.com/attachments/1476345750924427421/1476345827739046010/nem_logo.png?ex=69a0c9b2&is=699f7832&hm=4a550275c19260d1ac022322ca4304b80bf98bbe58711c51e0a4828ad153fb05&"

local function runSplash(onDone)
    local Splash = Instance.new("ScreenGui")
    Splash.Name = "DeltaHubSplash"
    Splash.ResetOnSpawn = false
    Splash.DisplayOrder = 99999
    Splash.Parent = player.PlayerGui

    local BG = Instance.new("Frame")
    BG.Size = UDim2.new(1,0,1,0)
    BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BG.BorderSizePixel = 0; BG.ZIndex = 1; BG.Parent = Splash

    local imgAsset = ""
    local pngOk = false

    -- Tenta carregar PNG já salvo
    if isfile("DeltaHub/PNGANIM.PNG") then
        local ok, asset = pcall(getcustomasset, "DeltaHub/PNGANIM.PNG")
        if ok and asset then imgAsset = asset; pngOk = true end
    end

    -- ======= FUNÇÃO ANIMAÇÃO NINJA =======
    local function runAnimation()
        local AnimFrame = Instance.new("Frame")
        AnimFrame.Size = UDim2.new(1,0,1,0)
        AnimFrame.BackgroundTransparency = 1
        AnimFrame.ZIndex = 2; AnimFrame.Parent = BG

        local RGBStrip = Instance.new("Frame")
        RGBStrip.Size = UDim2.new(1,0,0,3); RGBStrip.Position = UDim2.new(0,0,0,0)
        RGBStrip.BackgroundColor3 = Color3.fromRGB(110,60,255)
        RGBStrip.BorderSizePixel = 0; RGBStrip.ZIndex = 3; RGBStrip.Parent = AnimFrame

        local RGBStrip2 = Instance.new("Frame")
        RGBStrip2.Size = UDim2.new(1,0,0,3); RGBStrip2.Position = UDim2.new(0,0,1,-3)
        RGBStrip2.BackgroundColor3 = Color3.fromRGB(110,60,255)
        RGBStrip2.BorderSizePixel = 0; RGBStrip2.ZIndex = 3; RGBStrip2.Parent = AnimFrame

        local NinjaImg = Instance.new("ImageLabel")
        NinjaImg.Size = UDim2.new(0,200,0,200)
        NinjaImg.Position = UDim2.new(0.5,-100,-0.6,-100)
        NinjaImg.BackgroundTransparency = 1
        NinjaImg.Image = pngOk and imgAsset or ""
        NinjaImg.ZIndex = 4; NinjaImg.Parent = AnimFrame

        if not pngOk then
            local E = Instance.new("TextLabel")
            E.Size = UDim2.new(1,0,1,0); E.BackgroundTransparency = 1
            E.Text = "🥷"; E.TextScaled = true; E.ZIndex = 5; E.Parent = NinjaImg
        end

        local rotation = 0
        local spinConn = RunService.RenderStepped:Connect(function(dt)
            rotation = rotation + dt * 360
            NinjaImg.Rotation = rotation
        end)

        TweenService:Create(NinjaImg, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5,-100,0.5,-160)
        }):Play()

        task.delay(1.2, function()
            spinConn:Disconnect()
            TweenService:Create(NinjaImg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Rotation=0}):Play()

            local Glow = Instance.new("ImageLabel")
            Glow.Size = UDim2.new(0,260,0,260); Glow.Position = UDim2.new(0.5,-130,0.5,-200)
            Glow.BackgroundTransparency = 1; Glow.Image = "rbxassetid://5028857472"
            Glow.ImageColor3 = Color3.fromRGB(110,60,255); Glow.ImageTransparency = 0.3
            Glow.ZIndex = 3; Glow.Parent = AnimFrame
            TweenService:Create(Glow, TweenInfo.new(0.6), {
                ImageTransparency=1, Size=UDim2.new(0,340,0,340),
                Position=UDim2.new(0.5,-170,0.5,-240)
            }):Play()

            task.delay(0.5, function()
                local Line = Instance.new("Frame")
                Line.Size = UDim2.new(0,0,0,2); Line.Position = UDim2.new(0.5,0,0.5,75)
                Line.BackgroundColor3 = Color3.fromRGB(110,60,255)
                Line.BorderSizePixel = 0; Line.ZIndex = 4; Line.Parent = AnimFrame
                TweenService:Create(Line, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                    Size=UDim2.new(0,280,0,2), Position=UDim2.new(0.5,-140,0.5,75)
                }):Play()

                task.delay(0.5, function()
                    local TitleSplash = Instance.new("TextLabel")
                    TitleSplash.Size = UDim2.new(0,300,0,45)
                    TitleSplash.Position = UDim2.new(0.5,-150,0.5,80)
                    TitleSplash.BackgroundTransparency = 1; TitleSplash.Text = "Delta Hub"
                    TitleSplash.TextColor3 = Color3.fromRGB(255,255,255)
                    TitleSplash.Font = Enum.Font.GothamBold; TitleSplash.TextSize = 34
                    TitleSplash.TextTransparency = 1; TitleSplash.ZIndex = 5
                    TitleSplash.Parent = AnimFrame
                    TweenService:Create(TitleSplash, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
                        TextTransparency=0
                    }):Play()

                    local BetaLbl = Instance.new("TextLabel")
                    BetaLbl.Size = UDim2.new(0,300,0,24)
                    BetaLbl.Position = UDim2.new(0.5,-150,0.5,122)
                    BetaLbl.BackgroundTransparency = 1; BetaLbl.Text = "beta"
                    BetaLbl.TextColor3 = Color3.fromRGB(110,60,255)
                    BetaLbl.Font = Enum.Font.Gotham; BetaLbl.TextSize = 16
                    BetaLbl.TextTransparency = 1; BetaLbl.ZIndex = 5
                    BetaLbl.Parent = AnimFrame
                    TweenService:Create(BetaLbl, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {
                        TextTransparency=0
                    }):Play()

                    local rgbHue = 0
                    local rgbConn = RunService.RenderStepped:Connect(function(dt)
                        rgbHue = (rgbHue + dt*0.5)%1
                        local c = Color3.fromHSV(rgbHue,1,1)
                        RGBStrip.BackgroundColor3 = c; RGBStrip2.BackgroundColor3 = c
                        Line.BackgroundColor3 = c; BetaLbl.TextColor3 = c
                    end)

                    task.delay(2.5, function()
                        rgbConn:Disconnect()
                        TweenService:Create(BG, TweenInfo.new(0.8), {BackgroundTransparency=1}):Play()
                        TweenService:Create(TitleSplash, TweenInfo.new(0.8), {TextTransparency=1}):Play()
                        TweenService:Create(BetaLbl, TweenInfo.new(0.8), {TextTransparency=1}):Play()
                        TweenService:Create(NinjaImg, TweenInfo.new(0.8), {ImageTransparency=1}):Play()
                        task.delay(0.9, function()
                            Splash:Destroy()
                            if onDone then onDone() end
                        end)
                    end)
                end)
            end)
        end)
    end

    if IS_FIRST_TIME then
        -- ======= PRIMEIRA VEZ: setup + download =======
        LoadFrame = Instance.new("Frame")
        LoadFrame.Size = UDim2.new(1,0,1,0); LoadFrame.BackgroundTransparency = 1
        LoadFrame.ZIndex = 2; LoadFrame.Parent = BG

        TopLbl = Instance.new("TextLabel")
        TopLbl.Size = UDim2.new(1,0,0,40); TopLbl.Position = UDim2.new(0,0,0.5,-80)
        TopLbl.BackgroundTransparency = 1; TopLbl.Text = "📁 Delta Hub"
        TopLbl.TextColor3 = Color3.fromRGB(255,255,255)
        TopLbl.Font = Enum.Font.GothamBold; TopLbl.TextSize = 22
        TopLbl.ZIndex = 3; TopLbl.Parent = LoadFrame

        BarBG = Instance.new("Frame")
        BarBG.Size = UDim2.new(0,320,0,6); BarBG.Position = UDim2.new(0.5,-160,0.5,20)
        BarBG.BackgroundColor3 = Color3.fromRGB(30,30,40)
        BarBG.BorderSizePixel = 0; BarBG.ZIndex = 3; BarBG.Parent = LoadFrame

        Bar = Instance.new("Frame")
        Bar.Size = UDim2.new(0,0,1,0); Bar.BackgroundColor3 = Color3.fromRGB(110,60,255)
        Bar.BorderSizePixel = 0; Bar.ZIndex = 4; Bar.Parent = BarBG

        LoadTxt = Instance.new("TextLabel")
        LoadTxt.Size = UDim2.new(1,0,0,26); LoadTxt.Position = UDim2.new(0,0,0.5,32)
        LoadTxt.BackgroundTransparency = 1; LoadTxt.Text = "Iniciando..."
        LoadTxt.TextColor3 = Color3.fromRGB(180,180,200)
        LoadTxt.Font = Enum.Font.Gotham; LoadTxt.TextSize = 13
        LoadTxt.ZIndex = 3; LoadTxt.Parent = LoadFrame

        local function setStep(pct, msg, delay)
            task.delay(delay, function()
                LoadTxt.Text = msg
                TweenService:Create(Bar, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(pct,0,1,0)
                }):Play()
            end)
        end

        setStep(0.10, "Criando pasta DeltaHub/...",    0.0)
        setStep(0.30, "Criando pasta scripts/...",     0.8)
        setStep(0.50, "Salvando configurações...",     1.4)
        setStep(0.65, "Baixando imagem do servidor...",2.0)
        setStep(0.85, "Carregando PNG...",             3.0)
        setStep(1.00, "Concluído! ✓",                 3.8)

        -- Download em paralelo
        task.delay(2.0, function()
            local ok, result = pcall(function()
                local data = game:HttpGet(IMG_URL)
                writefile("DeltaHub/PNGANIM.PNG", data)
                return getcustomasset("DeltaHub/PNGANIM.PNG")
            end)
            if ok and result then
                imgAsset = result; pngOk = true
            end
        end)

        task.delay(4.2, function()
            TweenService:Create(LoadFrame, TweenInfo.new(0.5), {BackgroundTransparency=1}):Play()
            task.delay(0.6, function()
                LoadFrame.Visible = false
                runAnimation()
            end)
        end)
    else
        -- ======= JÁ CONFIGURADO: animação direta =======
        runAnimation()
    end
end
-- Esconde o hub enquanto o splash roda
Main.Visible = false
runSplash(function()
    Main.Visible = true
    refreshList()
    notify(T("notif_loaded"),110,60,255)
end)
print("📁 Delta Hub v3.0 | Lang:"..currentLang.." | Border:"..borderMode)
