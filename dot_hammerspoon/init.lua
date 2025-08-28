require("hs.ipc")
require("hs.screen")
require("hs.timer")
require("hs.window")
require("hs.window.filter")


function notifyTaskCompleted()
    local msg = "Task completed!"

    hs.notify.new({informativeText=msg}):send()
    hs.alert.show(msg)
end

-- nagScreen continuously flash screen until a terminal window is active
-- source: https://nikhilism.com/post/2021/useful-hammerspoon-tips
function invertScreen()
    hs.screen.setInvertedPolarity(true)
end

function normalScreen()
    hs.screen.setInvertedPolarity(false)
end

function nagScreen()
    -- start nagging
    local toggled = false
    local timer = hs.timer.doEvery(1, function()
        if toggled then
            normalScreen()
        else
            invertScreen()
        end
        toggled = not toggled
    end)

    local wf = hs.window.filter
    termWindow = wf.new("iTerm2")
    termWindow:subscribe(wf.windowFocused, function()
        termWindow:unsubscribeAll()
        timer:stop()

        -- restore to normal state regardless of previous state
        normalScreen()
    end)
end

