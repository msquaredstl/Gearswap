-------------------------------------------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
-------------------------------------------------------------------------------------------------------------------
function define_global_sets()
	sets.reive = {neck="Arciela's Grace +1"}
	sets.CapacityMantle = {back=gear.CPCape}

	-- Global States
	state.CapacityMode = M(false, 'Capacity Point Mantle')
	
	gear.CPCape = {name="Mecisto. Mantle", augments={'Cap. Point+47%','DEF+2',}}
end

function global_on_load()
	send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')

end

function global_on_unload()
	send_command('unbind !=')
	send_command('unbind ^=')
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    if buffactive['Reive Mark'] and player.inventory["Adoulin's Refuge +1"] or player.wardrobe["Adoulin's Refuge +1"] then
       equip(sets.reive)
    end
 
end

function precast(spell,action)
    if player.status == 'Dead' then cancel_spell() end
end

-- Global intercept on midcast.
function user_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.reive)
    end
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
	if state.CapacityMode.value then
        idleSet = set_combine(idleSet, sets.CapacityMantle)
    end
 	if  player.hpp <= 50 then
        idleSet = set_combine(idleSet,sets.defense.PDT)
    end
    return idleSet
end

function user_customize_melee_set(meleeSet)
    if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, sets.reive)
    end
	if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if buffactive['Elvorseal'] then
        meleeSet = set_combine(meleeSet, sets.DI)
    end
	if  player.hpp <= 50 then
        meleeSet = set_combine(meleeSet,sets.defense.PDT)
    end
    return meleeSet
end
-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying library files.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end

