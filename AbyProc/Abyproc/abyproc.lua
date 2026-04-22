-- abyproc.lua
addon = {};
addon.name = 'AbyProc';
addon.author = 'Oneword';
addon.version = '4.6.5';
addon.desc = 'Enhanced Abyssea Proc Tracking';
addon.link = 'https://github.com/Yoshin79';

-- Load ImGui if available 
local imgui = nil;
pcall(function() imgui = require('imgui'); end);

-- Load all components
local settings = require('config.settings');
local colors = require('config.colors');
local time = require('core.time');
local target = require('core.target');
local procs = require('core.procs');
local ui = require('ui.main');

-- Initialize the addon
ashita.events.register('load', 'load_cb', function()
    -- Print welcome message
    print('====================================================');
    print(string.format('    %s v%s by %s', addon.name, addon.version, addon.author));
    print('====================================================');
    print('             Latest Version 4.6.5');
    print('====================================================');
    
    settings.load();
    target.initialize();
end);

-- Command handler function
local function handle_command(e)
    if not e or not e.command then return false; end
    
    local cmd = e.command;
    if not cmd or cmd:sub(1, 8) ~= '/abyproc' then return false; end
    
    e.blocked = true;
    
    local args = {};
    for arg in cmd:gmatch("%S+") do
        args[#args + 1] = arg;
    end
    
    -- If no arguments or just the command itself, toggle the UI
    if #args <= 1 then
        ui.toggle_window();
        return true;
    end
    
    -- Handle other commands
    if args[2] == 'help' then
        print('[abyproc] Available commands:');
        print('  /abyproc - Toggle the UI window');
        print('  /abyproc help - Show this help message');
        print('  /abyproc target <name> - Manually set target');
        print('  /abyproc update - Update current target');
        print('  /abyproc reset - Reset proc tracking');
    elseif args[2] == 'target' and args[3] then
        target.set(args[3]);
    elseif args[2] == 'update' then
        target.update();
    elseif args[2] == 'reset' then
        target.reset_procs();
    end
    
    return true;
end

-- Register event handlers
ashita.events.register('command', 'command_cb', handle_command);
ashita.events.register('text_in', 'text_in_cb', procs.check_chat_message);
ashita.events.register('d3d_present', 'present_cb', ui.render);
ashita.events.register('unload', 'unload_cb', function()
    settings.save();
    print('[abyproc] Addon unloaded');
end);

return addon;
