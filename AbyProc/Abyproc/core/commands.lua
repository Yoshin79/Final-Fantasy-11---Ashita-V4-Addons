-- core/commands.lua
local commands = {};

-- This will be set by the main addon file
commands.ui = nil;
commands.target = nil;

function commands.handle_command(e)
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
        if commands.ui and commands.ui.toggle_window then
            commands.ui.toggle_window();
        end
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
    elseif args[2] == 'target' and args[3] and commands.target then
        commands.target.set(args[3]);
    elseif args[2] == 'update' and commands.target then
        commands.target.update();
    elseif args[2] == 'reset' and commands.target then
        commands.target.reset_procs();
    end
    
    return true;
end

return commands;
