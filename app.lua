--[[
FEUILLEDEV - File Explorer
Github : https://github.com/feuilledev/paxo-explorer

Under MIT License:
Copyright 2024 FeuilleDev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]
ATMP = "../"
function LoadFiles(path)
    if path:sub(-4) == ".png" then
        print("PNG")
        win_img = gui:window()
        gui:setWindow(win_img)
    end
end
function ShowFiles(path)
    local list = gui:vlist(win, 35, 90, 250, 280)
    list:clear()
    local files = storage:listDir(path)
    for i, file in ipairs(files) do
        local case = gui:box(list, 0, (i-1)*36, 250, 36)
        local nameLabel = gui:label(case, 21, 0, 230, 18)
        nameLabel:setText(file)
        nameLabel:setFontSize(16)
        case:onClick(function()
            if storage:isDir(path .. "/" .. file) then
                print("DIRECTORY")
                print(path .. "/" .. file)
                ShowFiles(path .. "/" .. file)
                ATMP = path
            else
                print("FILE")
                LoadFiles(path .. "/" .. file)
            end
        end)
    end
end

function back()
    gui:setWindow(win)
    ShowFiles(ATMP)
end
function run(arg)
    print("[EXPLORER] : Loaded !")
    win=gui:window()
    local title=gui:label(win, 0, 0, 1400, 2000)

    local back_button = gui:box(win, 250, 410, 40, 40)
    --back_button:setMainColor(COLOR_DARK)
    back_button:setRadius(20)
    
    local back_icon = gui:image(back_button, "assets/app_assets/back.png", 14, 14, 12, 12)
    back_button:onClick(back)
    


    title:setFontSize(25)
    title:setText("[FeuilleDev - File Explorer]")
    ShowFiles(ATMP)

    

    gui:setWindow(win)
end
