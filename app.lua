
ROOT_FOLDER = "../" -- debug only
ATMP = "/"
function ShowFiles(path)
    local list = gui:vlist(win, 35, 90, 250, 280)
    local files = storage:listDir(path)
    for i, file in ipairs(files) do
        print(file)
        local case = gui:box(list, 0, (i-1)*36, 250, 36)
        local nameLabel = gui:label(case, 21, 0, 230, 18)
        nameLabel:setText(file)
        nameLabel:setFontSize(16)
        case:onClick(function()
            print("[EXPLORER]: " .. file)
            -- Check if a directory (if end with /)
            
            ShowFiles(path .. "/" .. file)
            ATMP = path
          
        end)
    end
end
function back()
    ShowFiles(ATMP)
end
function run(arg)
    print("[EXPLORER] : Loaded !")


    win=gui:window()
    local title=gui:label(win, 0, 0, 144, 28)

    local back_button = gui:box(win, 250, 410, 40, 40)
    back_button:setMainColor(COLOR_DARK)
    back_button:setRadius(20)
    
    local back_icon = gui:image(back_button, "assets/app_assets/back.png", 14, 14, 12, 12)
    back_button:onClick(back)
    


    title:setFontSize(14)
    title:setText("[FeuilleDev - File Explorer]")
    ShowFiles(ROOT_FOLDER)

    

    gui:setWindow(win)
end
