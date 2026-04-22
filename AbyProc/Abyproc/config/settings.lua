-- config/settings.lua
local settings = {
    timezone = 0,  -- Default timezone offset
    show_ui = true,
    show_red = true,
    show_blue = true,
    show_yellow = true,
    timezone_options = {  -- Timezone options
        [-12] = "GMT-12",
        [-11] = "GMT-11",
        [-10] = "GMT-10 (Hawaii)",
        [-9] = "GMT-9 (Alaska)",
        [-8] = "GMT-8 (Pacific)",
        [-7] = "GMT-7 (Mountain)",
        [-6] = "GMT-6 (Central)",
        [-5] = "GMT-5 (Eastern)",
        [-4] = "GMT-4 (Atlantic)",
        [-3] = "GMT-3",
        [-2] = "GMT-2",
        [-1] = "GMT-1",
        [0] = "GMT+0 (London)",
        [1] = "GMT+1 (Paris)",
        [2] = "GMT+2",
        [3] = "GMT+3",
        [4] = "GMT+4",
        [5] = "GMT+5",
        [6] = "GMT+6",
        [7] = "GMT+7",
        [8] = "GMT+8",
        [9] = "GMT+9 (Tokyo)",
        [10] = "GMT+10",
        [11] = "GMT+11",
        [12] = "GMT+12"
    }
};

-- Load settings from file
function settings.load()
    local settingsFile = 'settings/abyproc.json';
    
    -- Check if file exists
    if ashita.fs.exists(settingsFile) then
        local f = io.open(settingsFile, 'r');
        if f then
            local content = f:read('*all');
            f:close();
            
            local loaded = loadstring("return " .. content)();
            if loaded then
                settings.timezone = loaded.timezone or 0;
                settings.show_ui = loaded.show_ui or true;
                settings.show_red = loaded.show_red or true;
                settings.show_blue = loaded.show_blue or true;
                settings.show_yellow = loaded.show_yellow or true;
            end
        end
    end
end

-- Save settings to file
function settings.save()
    -- Create settings folder if it doesn't exist
    if not ashita.fs.exists('settings') then
        ashita.fs.create_directory('settings');
    end
    
    -- Save the settings
    local f = io.open('settings/abyproc.json', 'w');
    if f then
        f:write(string.format([[{
            timezone = %d,
            show_ui = %s,
            show_red = %s,
            show_blue = %s,
            show_yellow = %s
        }]], 
        settings.timezone,
        tostring(settings.show_ui),
        tostring(settings.show_red),
        tostring(settings.show_blue),
        tostring(settings.show_yellow)));
        f:close();
    end
end

return settings;
