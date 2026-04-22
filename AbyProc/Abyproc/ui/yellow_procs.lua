local imgui = require('imgui');
local colors = require('config.colors');
local procs = require('core.procs');

local yellow_procs = {};

-- Define day-to-element mapping
local day_to_element = {
    [0] = "Fire",      -- Firesday
    [1] = "Earth",     -- Earthsday
    [2] = "Water",     -- Watersday
    [3] = "Wind",      -- Windsday
    [4] = "Ice",       -- Iceday
    [5] = "Lightning", -- Lightningday
    [6] = "Light",     -- Lightsday
    [7] = "Dark"       -- Darksday
};

-- Define spells for each element
local element_spells = {
    ["Fire"] = {
        "Fire III",
        "Fire IV",
        "Firaga III",
        "Flare",
        "Katon: Ni",
        "Ice Threnody",
        "Heat Breath"
    },
    ["Earth"] = {
        "Stone III",
        "Stone IV",
        "Stonega III",
        "Quake",
        "Doton: Ni",
        "Lightning Threnody",
        "Magnetic Cloud"
    },
    ["Water"] = {
        "Water III",
        "Water IV",
        "Waterga III",
        "Flood",
        "Suiton: Ni",
        "Fire Threnody",
        "Maelstrom"
    },
    ["Wind"] = {
        "Aero III",
        "Aero IV",
        "Aeroga III",
        "Tornado",
        "Huton: Ni",
        "Earth Threnody",
        "Mysterious Light"
    },
    ["Ice"] = {
        "Blizzard III",
        "Blizzard IV",
        "Blizzaga III",
        "Freeze",
        "Hyoton: Ni",
        "Wind Threnody",
        "Ice Break"
    },
    ["Lightning"] = {
        "Thunder III",
        "Thunder IV",
        "Thundaga III",
        "Burst",
        "Raiton: Ni",
        "Water Threnody",
        "Mind Blast"
    },
    ["Light"] = {
        "Banish II",
        "Banish III",
        "Banishga II",
        "Holy",
        "Flash",
        "Dark Threnody",
        "Radiant Breath"
    },
    ["Dark"] = {
        "Drain",
        "Aspir",
        "Dispel",
        "Bio II",
        "Kurayami: Ni",
        "Light Threnody",
        "Eyes On Me"
    }
};


function yellow_procs.render(vana_time)
    imgui.PushStyleColor(ImGuiCol_Header, { 0.7, 0.7, 0.3, 1.0 });
    imgui.PushStyleColor(ImGuiCol_HeaderHovered, { 0.8, 0.8, 0.4, 1.0 });
    imgui.PushStyleColor(ImGuiCol_HeaderActive, { 0.9, 0.9, 0.5, 1.0 });
    
    if imgui.CollapsingHeader('Yellow Procs (Day-Based Spells)', ImGuiTreeNodeFlags_DefaultOpen) then
        do
            local current_day = vana_time.day
            local prev_day = (current_day - 1 + 8) % 8
            local next_day = (current_day + 1) % 8
            
            -- Get current vulnerability
            local vulnerability = procs.get_vulnerability();
            
            -- Display vulnerability if detected
            if vulnerability then
                imgui.TextColored({ 1.0, 1.0, 0.0, 1.0 }, string.format(
                    "Monster vulnerable to %s elemental magic!", vulnerability:upper()));
                imgui.Separator();
            end
            
            -- Set up three columns
            imgui.Columns(3, 'spell_columns', false);
            
            -- Current Day Spells
            imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, "Current Day:");
            imgui.Spacing();
            local curr_element = day_to_element[current_day]
            if curr_element and element_spells[curr_element] then
                for _, spell in ipairs(element_spells[curr_element]) do
                    -- If we have a vulnerability, check if this spell matches
                    if vulnerability and not procs.matches_vulnerability(spell) then
                        imgui.TextColored({ 0.5, 0.5, 0.5, 0.5 }, spell) -- Grey out
                    else
                        imgui.TextColored(colors.element_colors[curr_element], spell)
                    end
                end
            end
            
            imgui.NextColumn();
            
            -- Previous Day
            imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, "Previous Day:");
            imgui.Spacing();
            local prev_element = day_to_element[prev_day]
            if prev_element and element_spells[prev_element] then
                for _, spell in ipairs(element_spells[prev_element]) do
                    -- If we have a vulnerability, check if this spell matches
                    if vulnerability and not procs.matches_vulnerability(spell) then
                        imgui.TextColored({ 0.5, 0.5, 0.5, 0.5 }, spell) -- Grey out
                    else
                        imgui.TextColored(colors.element_colors[prev_element], spell)
                    end
                end
            end
            
            imgui.NextColumn();
            
            -- Next Day
            imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, "Next Day:");
            imgui.Spacing();
            local next_element = day_to_element[next_day]
            if next_element and element_spells[next_element] then
                for _, spell in ipairs(element_spells[next_element]) do
                    -- If we have a vulnerability, check if this spell matches
                    if vulnerability and not procs.matches_vulnerability(spell) then
                        imgui.TextColored({ 0.5, 0.5, 0.5, 0.5 }, spell) -- Grey out
                    else
                        imgui.TextColored(colors.element_colors[next_element], spell)
                    end
                end
            end
            
            imgui.Columns(1);
        end
    end
    
    imgui.PopStyleColor(3);
end

return yellow_procs;
