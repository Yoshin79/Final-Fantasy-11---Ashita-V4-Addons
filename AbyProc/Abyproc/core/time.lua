local settings = require('config.settings');

local time = {
    TIME_ZONE_ADJUSTMENT = 7200, -- +2 hours (in seconds)
    DAY_OFFSET = -2,            -- -2 days offset
    
    day_names = {
        [0] = "Firesday",
        [1] = "Earthsday", 
        [2] = "Watersday",
        [3] = "Windsday",
        [4] = "Iceday",
        [5] = "Lightningday",
        [6] = "Lightsday",
        [7] = "Darksday"
    }
};

function time.calculate_vana_time()
    local success, result = pcall(function()
        local ffxi_epoch = 900435600;
        local earth_time = os.time() + (settings.timezone * 3600);
        local adjusted_time = earth_time + time.TIME_ZONE_ADJUSTMENT;
        local elapsed_seconds = adjusted_time - ffxi_epoch;
        local vana_seconds = elapsed_seconds * 25;
        
        local vana_minutes_total = math.floor(vana_seconds / 60);
        local vana_hours_total = math.floor(vana_minutes_total / 60);
        local vana_days_total = math.floor(vana_hours_total / 24);
        
        local vana_day = (vana_days_total + time.DAY_OFFSET) % 8;
        if vana_day < 0 then vana_day = vana_day + 8; end
        local vana_hour = vana_hours_total % 24;
        local vana_minute = vana_minutes_total % 60;
        
        return {
            day = vana_day,
            day_name = time.day_names[vana_day],
            hour = vana_hour,
            minute = vana_minute,
            total_minutes = (vana_hour * 60) + vana_minute,
            formatted_time = string.format("%d:%02d", vana_hour, vana_minute)
        };
    end);
    
    if not success then
        return {
            day = 0,
            day_name = "Unknown",
            hour = 0,
            minute = 0,
            total_minutes = 0,
            formatted_time = "??:??"
        };
    end
    
    return result;
end

function time.get_time_block(total_minutes)
    if not total_minutes or type(total_minutes) ~= "number" then
        return "Unknown";
    end
    
    if total_minutes >= 0 and total_minutes < 240 then
        return "0:00 to 4:00";
    elseif total_minutes >= 240 and total_minutes < 480 then
        return "4:00 to 8:00";
    elseif total_minutes >= 480 and total_minutes < 720 then
        return "8:00 to 12:00";
    elseif total_minutes >= 720 and total_minutes < 960 then
        return "12:00 to 16:00";
    elseif total_minutes >= 960 and total_minutes < 1200 then
        return "16:00 to 20:00";
    else
        return "20:00 to 0:00";
    end
end

return time;
