local imgui = require('imgui');
local colors = require('config.colors');
local procs = require('core.procs');

local red_procs = {};

-- Map weapon skills to their elements
local weaponskill_elements = {
    -- Fire element
    ["Red Lotus Blade"] = "fire",
    
    -- Earth element
    ["Earth Crusher"] = "earth",
    
    -- Water element
    ["Spinning Slash"] = "water",
    
    -- Wind element
    ["Cyclone"] = "wind",
    ["Tachi: Jinpu"] = "wind",
    
    -- Ice element
    ["Freezebite"] = "ice",
    
    -- Lightning element
    ["Raiden Thrust"] = "lightning",
    
    -- Light element
    ["Seraph Blade"] = "light",
    ["Seraph Strike"] = "light",
    ["Tachi: Koki"] = "light",
    ["Sunburst"] = "light",
    
    -- Dark element
    ["Energy Drain"] = "dark",
    ["Shadow of Death"] = "dark",
    ["Blade: Ei"] = "dark"
};

function red_procs.render()
    imgui.PushStyleColor(ImGuiCol_Header, { 0.7, 0.2, 0.2, 1.0 });          -- RED header
    imgui.PushStyleColor(ImGuiCol_HeaderHovered, { 0.8, 0.3, 0.3, 1.0 });   -- Lighter red
    imgui.PushStyleColor(ImGuiCol_HeaderActive, { 0.9, 0.4, 0.4, 1.0 });    -- Lightest red
    
    if imgui.CollapsingHeader('Red Procs (Weapon Skills)', ImGuiTreeNodeFlags_DefaultOpen) then
        -- Get current vulnerability
        local vulnerability = procs.get_vulnerability();
        
        -- Display vulnerability if detected
        if vulnerability then
            imgui.TextColored({ 1.0, 1.0, 0.0, 1.0 }, string.format(
                "Monster vulnerable to %s element!", vulnerability:upper()));
            imgui.Separator();
        end
        
        do
            imgui.Columns(2, 'red_procs_columns', false);
            
            -- Function to render a weapon skill with proper coloring
            local function render_weaponskill(name, element_color)
                local is_greyed_out = false;
                
                -- Check if we should grey out this skill based on vulnerability
                if vulnerability then
                    local ws_element = weaponskill_elements[name];
                    if not ws_element or ws_element ~= vulnerability then
                        is_greyed_out = true;
                    end
                end
                
                if is_greyed_out then
                    imgui.TextColored({ 0.5, 0.5, 0.5, 0.5 }, name); -- Grey out
                else
                    imgui.TextColored(element_color, name);
                end
            end
            
            -- LEFT COLUMN
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Great Katana:");
            imgui.Indent(10);
            render_weaponskill("Tachi: Jinpu", colors.element_colors["Wind"]);
            render_weaponskill("Tachi: Koki", colors.element_colors["Light"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Sword:");
            imgui.Indent(10);
            render_weaponskill("Red Lotus Blade", colors.element_colors["Fire"]);
            render_weaponskill("Seraph Blade", colors.element_colors["Light"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Dagger:");
            imgui.Indent(10);
            render_weaponskill("Cyclone", colors.element_colors["Wind"]);
            render_weaponskill("Energy Drain", colors.element_colors["Dark"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Staff:");
            imgui.Indent(10);
            render_weaponskill("Sunburst", colors.element_colors["Light"]);
            render_weaponskill("Earth Crusher", colors.element_colors["Earth"]);
            imgui.Unindent(10);
            
            imgui.NextColumn();
            
            -- RIGHT COLUMN
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Polearm:");
            imgui.Indent(10);
            render_weaponskill("Raiden Thrust", colors.element_colors["Lightning"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Club:");
            imgui.Indent(10);
            render_weaponskill("Seraph Strike", colors.element_colors["Light"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Katana:");
            imgui.Indent(10);
            render_weaponskill("Blade: Ei", colors.element_colors["Dark"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Scythe:");
            imgui.Indent(10);
            render_weaponskill("Shadow of Death", colors.element_colors["Dark"]);
            imgui.Unindent(10);
            
            imgui.TextColored({ 0.6, 0.6, 0.9, 1.0 }, "Great Sword:");
            imgui.Indent(10);
            render_weaponskill("Freezebite", colors.element_colors["Ice"]);
            imgui.Unindent(10);
            
            imgui.Columns(1);
        end
    end
    
    imgui.PopStyleColor(3);
end

return red_procs;
