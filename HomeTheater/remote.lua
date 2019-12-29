-- https://github.com/unifiedremote/Docs/blob/master/libs/http.md
local http = libs.http;
local keyboard = libs.keyboard;
local script = libs.script;

local url = "http://192.168.50.75:7467/";
local tv_remote = "Samsung_BN59-01179A";

function sendIrCommand (command)
    local req = {
        method = "get",
        mine = "text/plain",
        content = "ir command",
        headers = {},
        url = url
    };
    req.headers["remote-name"] = tv_remote;
    req.headers["ir-command"] = command;
    http.request(req, function (err, resp) 
        print(err);
        print(resp);
    end);
end

function openApp(app_name)
    script.apple("tell application \"" .. app_name .. "\" to activate");
end

function openUrl(browser, url)
    script.apple("do shell script \"open -a '" .. browser .. "' '" .. url .. "'\"");
end

--@help Raise TV volume
actions.volume_up = function ()
    local command = "KEY_VOLUMEUP";
    sendIrCommand(command);
end

--@help Lower TV volume
actions.volume_down = function ()
    local command = "KEY_VOLUMEDOWN";
    sendIrCommand(command);
end

--@help Mute TV volume
actions.volume_mute = function ()
    local command = "KEY_MUTE";
    sendIrCommand(command);
end

--@help POWER TV
actions.tv_power = function ()
    local command = "KEY_POWER";
    sendIrCommand(command);
end

--@help Toggle playback state
actions.play_pause = function()
    keyboard.press("space");
end

--@help Fast backward
actions.fast_backward = function()
    keyboard.press("left");
end

--@help Fast forward
actions.fast_forward = function()
    keyboard.press("right");
end

--@help Press ESC
actions.key_esc = function()
    keyboard.press("esc");
end

--@help Press CMD
actions.key_cmd = function()
    keyboard.press("cmd");
end

--@help Quit current app
actions.quit_app = function()
    keyboard.stroke("cmd", "q");
    keyboard.up("cmd", "q");
end

--@help Press Option
actions.key_opt = function()
    keyboard.press("option");
end

--@help Press Ctrl
actions.key_ctrl = function()
    keyboard.press("ctrl");
end

--@help Quit current app
actions.refresh= function()
    keyboard.stroke("cmd", "r");
    keyboard.up("cmd", "r");
end

--@help Page up
actions.page_up = function()
    keyboard.press("pageup");
end

--@help Page down
actions.page_down = function()
    keyboard.press("pagedown");
end

--@help Open Safari
actions.open_safari = function()
    openUrl("Safari", "http://www.ifun.tv");
end

--@help Open Safari
actions.open_chrome = function()
    openUrl("/Applications/Google Chrome.app", "http://v.qq.com");
end

--@help Sleep
actions.sleep = function()
    script.apple(
        "tell application \"System Events\"",
            "if ((get name of every process) does not contain \"ScreenSaverEngine\") then",
                "start current screen saver",
            "end if",
        "end tell"
    );
end

--@help Unlock screen
actions.unlock = function()
    script.shell("/usr/bin/osascript /Users/Snflow/.credentials/unlock_screen.scpt");
end
