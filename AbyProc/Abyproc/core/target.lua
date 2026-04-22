-- core/target.lua
local target = {
    current = "No Target",
    index = 0,
    last_check = 0,
    staggered = false,
    stagger_time = 0
};

function target.initialize()
    target.update();
end

function target.set(name)
    target.current = name;
    print(string.format("[%s] Target manually set to: %s", addon.name, name));
end

function target.update()
    local success = pcall(function()
        local target_index = AshitaCore:GetMemoryManager():GetTarget():GetTargetIndex(0);
        if target_index > 0 then
            local entity = GetEntity(target_index);
            if entity and entity.Name then
                target.current = entity.Name;
                target.index = target_index;
            else
                target.current = "No Target";
                target.index = 0;
            end
        else
            target.current = "No Target";
            target.index = 0;
        end
    end);
    
    if not success then
        print("[abyproc] Error updating target");
    end
end

function target.reset_procs()
    -- Get the procs module and reset all tracking
    local procs = require('core.procs');
    if procs and procs.reset then
        procs.reset();
    end
    
    -- Reset stagger state
    target.staggered = false;
    target.stagger_time = 0;
    
    print("[abyproc] Reset all proc tracking and vulnerability detection");
end

-- Check if target has changed and reset vulnerability if needed
function target.check_target_change()
    local current_target_index = AshitaCore:GetMemoryManager():GetTarget():GetTargetIndex(0);
    if current_target_index > 0 and current_target_index ~= target.index then
        local entity = GetEntity(current_target_index);
        if entity and entity.Name then
            -- Target has changed, reset vulnerability
            local procs = require('core.procs');
            if procs and procs.current_vulnerability then
                procs.current_vulnerability = nil;
                print(string.format("[abyproc] Target changed to %s, resetting vulnerability", entity.Name));
            end
        end
    end
end

return target;
