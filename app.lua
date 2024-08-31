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
        win_img = gui:window()
        local e=gui:label(win_img, 90, 0, 120, 120)
        e:setFontSize(10)
        e:setText(path)

        imgParametre = gui:image(win_img, path, 100, 100, 25, 25)
        --TODO : Back Button
 
        gui:setWindow(win_img)
    elseif path:sub(-4) == ".txt" then
        win_txt = gui:window()
        local e=gui:label(win_txt, 90, 0, 320, 320)
        e:setFontSize(15)
        e:setText(path)

        local text_ = gui:label(win_txt, 0, 40, 320, 320)
        text_:setFontSize(15)
        local file_temp = storage:file(path, READ)
        file_temp:open()
        file_temp_text_ = file_temp:readAll()
        file_temp:close()
        text_:setText(file_temp_text_)

        _back_button = gui:box(win_txt, 250, 410, 40, 40)
       -- _back_button:setMainColor(COLOR_DARK)
        _back_button:setRadius(20)
        _back_icon = gui:image(_back_button, "assets/app_assets/back.png", 14, 14, 12, 12)
        _back_button:onClick(function() 
            time:setTimeout(function () gui:del(win_txt) gui:setWindow(win) end, 0) end)

        gui:setWindow(win_txt)
    end
end
function ShowFiles(path)
    if(list~=nil) then
      list:clear()
    else
      list = gui:vlist(win, 35, 90, 250, 280)
    end
    local files = storage:listDir(path)
    for i, file in ipairs(files) do
        print("Creating case")
        local case = gui:box(list, 0, (i-1)*36, 250, 36)
        local nameLabel = gui:label(case, 21, 0, 230, 18)
        nameLabel:setText(file)
        nameLabel:setFontSize(16)
        case:onClick(function()
            time:setTimeout(
              function ()
                  if storage:isDir(path .. "/" .. file) then
                  print("DIRECTORY")
                  print(path .. "/" .. file)
                  ShowFiles(path .. "/" .. file)
                  ATMP = path
              else
                  print("FILE")
                  print(path .. "/" .. file)
                  print(file)
                  LoadFiles(path .. "/" .. file)
              end
            end, 0)
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
    local title=gui:label(win, 0, 0, 300, 300)

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