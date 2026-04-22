local procs = {
    used_procs = {},
    staggered = false,
    stagger_time = 0,
    current_vulnerability = nil  -- New field to track vulnerability
};

function procs.mark_used(proc_name)
    procs.used_procs[proc_name] = true;
    print(string.format("[%s] Marked proc as used: %s", addon.name, proc_name));
end

function procs.reset()
    procs.used_procs = {};
    procs.staggered = false;
    procs.current_vulnerability = nil; -- Reset vulnerability too
end

function procs.is_used(proc_name)
    return procs.used_procs[proc_name] == true;
end

-- Element to spell mapping
procs.element_spells = {
    fire = {"Fire III", "Fire IV", "Firaga III", "Flare", "Katon: Ni", "Ice Threnody", "Heat Breath"},
    earth = {"Stone III", "Stone IV", "Stonega III", "Quake", "Doton: Ni", "Lightning Threnody", "Magnetic Cloud"},
    water = {"Water III", "Water IV", "Waterga III", "Flood", "Suiton: Ni", "Fire Threnody", "Maelstrom"},
    wind = {"Aero III", "Aero IV", "Aeroga III", "Tornado", "Huton: Ni", "Earth Threnody", "Mysterious Light"},
    ice = {"Blizzard III", "Blizzard IV", "Blizzaga III", "Freeze", "Hyoton: Ni", "Wind Threnody", "Ice Break"},
    lightning = {"Thunder III", "Thunder IV", "Thundaga III", "Burst", "Raiton: Ni", "Water Threnody", "Mind Blast"},
    light = {"Banish II", "Banish III", "Banishga II", "Holy", "Flash", "Dark Threnody", "Radiant Breath"},
    dark = {"Drain", "Aspir", "Dispel", "Bio II", "Kurayami: Ni", "Light Threnody", "Eyes On Me"}
};

function procs.check_chat_message(e)
    if not e.message then return false; end
    
    local ws_pattern = "You use ([%w%s:]+)%.";
    local ws_match = e.message:match(ws_pattern);
    if ws_match then
        procs.mark_used(ws_match);
    end
    
    -- Check for vulnerability message
    local vuln_pattern = "The fiend appears vulnerable to (%w+) elemental magic!";
    local vuln_match = e.message:match(vuln_pattern);
    if vuln_match then
        procs.current_vulnerability = string.lower(vuln_match);
        print(string.format("[%s] Detected %s elemental vulnerability!", addon.name, vuln_match));
    end
    
    -- Check for monster defeat
    if e.message:find("defeats the") or e.message:find("The fiend is defeated") then
        procs.current_vulnerability = nil;
        print(string.format("[%s] Monster defeated, resetting vulnerability tracking", addon.name));
    end
    
    if e.message:find("staggers") or e.message:find("~Staggered~") then
        procs.staggered = true;
        procs.stagger_time = os.time();
        procs.current_vulnerability = nil; -- Reset vulnerability on stagger
        print(string.format("[%s] STAGGER DETECTED!", addon.name));
    end
    
    return false;
end

-- Function to check if a spell matches current vulnerability
function procs.matches_vulnerability(spell_name)
    if not procs.current_vulnerability then
        return true; -- No vulnerability detected, show all
    end
    
    -- Check if the spell is in the list for the current vulnerability
    for _, spell in ipairs(procs.element_spells[procs.current_vulnerability] or {}) do
        if spell_name == spell then
            return true;
        end
    end
    
    return false;
end

-- Function to get current vulnerability for UI display
function procs.get_vulnerability()
    return procs.current_vulnerability;
end

return procs;
