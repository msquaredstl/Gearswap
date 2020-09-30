-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
state.Obi = M(false, 'Obi')
state.Seidr = M(false, 'Seidr')
state.MagicBurst = M(false, 'Magic Burst')
end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'RR')
 
    gear.default.weaponskill_waist = "Windbuffet Belt"

 	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
	'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
	'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',}

	HighTierNuke = S{'Stone III', 'Stone IV', 'Stone V', 'Stone VI', 'Stonega II', 'Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water III', 'Water IV', 'Water V', 'Water VI', 'Waterga II', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero III', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga II', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire III', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga II', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga II', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga II', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet', 'Stonera', 'Stonera II', 'Watera', 'Watera II', 'Aerora', 'Aerora II', 'Fira', 'Fira II', 'Blizzara', 'Blizzara II', 'Thundara', 'Thundara II'}

    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^end gs c toggle MagicBurst')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')

    select_default_macro_book()
	
	gear.MB_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst mdg.+10%','Mag. Acc.+3',}}
	gear.MAB_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',}}

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^end gs c toggle MagicBurst')
	send_command('unbind ^delete gs c toggle Obi')
	send_command('unbind ^home gs c toggle Seidr')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",range=none, ammo="Impatients",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",ring1="Prolix Ring",hands="Repartie Gloves",
        back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants",feet="Regal Pumps +1"}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1"})
 
	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=none})
   
	sets.precast.Trust = sets.precast.FC
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe +2",hands="Helios Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Amalric Slops",feet="Umbani Boots"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
        head="Hagondes Hat +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Amalric Doublet",hands="Helios Gloves",ring1="Acumen Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Snow Belt",legs="Amalric Slops",feet="Umbani Boots"}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head="Zelus Tiara",ear2="Loquacious Earring",neck="Orunmila's Torque",
        body="Shango Robe",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Amalric Slops",feet="Regal Pumps +1"}
 
    sets.midcast['Enhancing Magic'] = { head="Befouled Crown", neck="Incanter's Torque",feet="Regal Pumps +1" }

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {feet="Inspirited Boots"})

    sets.midcast['Enfeebling Magic'] = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Vanya Robe",hands="Helios Gloves",ring2="Sangoma Ring",
        cape="Lifestream Cape",waist="Demonry Sash",legs="Psycloth Lappas",feet="Bagua Sandals"}
    
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Solstice",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Saevus Pendant +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Toro Cape",waist="Refoccilation Stone",legs="Amalric Slops",feet=MAB_feet}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		ear2="Gwati Earring",
		back="Refraction Cape",
		waist="Refoccilation Stone",
		legs="Psycloth Lappas"})

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
	ring2="Shiva Ring +1",
	back="Toro Cape"})
	
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
	ring2="Adoulin Ring +1"})

	
   -- sets.midcast['Elemental Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Pemphredo Tathlum", head="Hagondes Hat +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring", body="Bagua Tunic +1",hands="Helios Gloves",ring2="Sangoma Ring", cape="Toro Cape",waist="Sekhmet Corset",legs="Amalric Slops",feet="Umbani Boots"}
     
   -- sets.midcast['Elemental Magic']['Low'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Pemphredo Tathlum", head="Hagondes Hat +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring", body="Bagua Tunic",hands="Helios Gloves",ring2="Sangoma Ring", cape="Toro Cape",waist="Sekhmet Corset",legs="Amalric Slops",feet="Umbani Boots"}
         
    sets.midcast['Dark Magic'] = {main="Venabulum",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Shango Robe",hands="Helios Gloves",
        cape="Toro Cape",waist="Demonry Sash",legs="Amalric Slops",feet="Umbani Boots"}
     
    sets.midcast['Dark Magic']['Stun'] = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Umbani Boots"}
	--sets.midcast.Drain =  set_combine(sets.midcast.['Dark Magic'], { head="Bagua Galero +1"})
	--sets.midcast.Aspir =  set_combine(sets.midcast.['Dark Magic'], { head="Bagua Galero +1"})
	 
    sets.midcast.Geomancy = {main="Solstice", range="Dunna", ammo=none,head="Azimuth Hood +1",neck="Incanter's Torque",legs="Bagua Pants +1",hands="Geomancy Mitaines +1",body="Bagua Tunic +1", back="Lifestream Cape", waist="Sekhmet Corset", feet="Medium's Sabots"}
	
    sets.midcast.Geomancy.Geo = {main="Solstice", range="Dunna",ammo=none,head="Azimuth Hood +1",neck="Incanter's Torque",legs="Theurgist's Slacks",hands="Geomancy Mitaines +1",body="Bagua Tunic +1", back="Lifestream Cape", waist="Sekhmet Corset", feet="Medium's Sabots"}
	sets.midcast['Indi-*'] = set_combine(sets.midcast.Geomancy, { legs="Bagua Pants +1", feet="Azimuth Gaiters +1"})
 
    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield", neck="Incanter's Torque",
        body="Annointed Kalasiris",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Oretania's Cape",legs="Assiduity Pants +1",feet="Regal Pumps +1"}
     
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast.Stun = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pupmps +1"}

 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",neck="Sanctity Necklace",
        body="Amalric Doublet",hands="Bagua Mitaines +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Assiduity Pants",feet="Chelona Boots"}
 
 
    -- Idle sets
 
    sets.idle = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Azimuth Coat +1",hands="Bagua Mitaines +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}
 
    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Amalric Slops",feet="Geomancy Sandals +1"}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Bolelabunga",range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Amalric Doublet",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Bagua Sandals"}
 
    sets.idle.PDT.Pet = {main="Bolelabunga",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitains",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Bagua Sandals"}
 
    -- .Indi sets are for when an Indi-spell is active.
 
    sets.idle.Town = {main="Solstice",sub="Culminus",range="Dunna",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Azimuth Coat +1",hands="Bagua Mitaines +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}
 
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Nefer Khat +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}

 	sets.idle.RR = set_combine(sets.idle.PDT,{body="Annointed Kalasiris"})

    -- Defense sets
 
    sets.Kiting = {feet="Geomancy Sandals +1"}
	 
    sets.defense.PDT = {main="Bolelabunga",range="Dunna",
        head="Hagondes Hat +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitaines +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Lifestream Cape",waist="Slipor Sash",legs="Amalric Slops",feet="Azimuth Gaiters +1"}
 
    sets.defense.MDT = {main="Bolelabunga",range="Dunna",
        head="Hagondes Hat +1",neck="Nuna Gorget",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitaines +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Lifestream Cape",waist="Slipor Sash",legs="Amalric Slops",feet="Azimuth Gaiters +1"}
  
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    sets.magic_burst = {neck="Mizu. Kubikazari", ring2="Locus ring", ear2="Static Earring", back="Seshaw Cape", ring1="mujin band",feet=MB_feet}
	sets.Seidr = {body="Seidr Cotehardie"}
	sets.Obi = {back="Twilight Cape", waist="Hachirin-no-Obi"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Bagua Mitaines +1",ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back="Lifestream Cape",waist="Cetl Belt",legs="Amalric Slops",feet="Battlecast Gaiters"}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
end
 
 
LowNukes                                    = S{'Stone'}
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
 
 -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.Obi.value then equip(sets.Obi)
	end

    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then equip(sets.magic_burst)
    end

	if spell.skill == 'Elemental Magic' and state.Seidr.value then equip(sets.Seidr)
	end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range','ammo')
        else
            enable('main','sub','range','ammo')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
 -- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Vocation Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Eschad Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Vocation Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Eschad Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            elseif spell.english:startswith('Geo') then
                return 'Geo'
            end
        elseif spell.skill == 'Elemantal Magic' then
            if LowNukes:contains(spell.name) then
                return 'Low'
            else
                return
            end
        elseif spell.skill == 'Dark Magic' then
            if spell.english:startswith('Stu') then
                return 'Stun'
            else
                return
            end
            return
        end
    end
end
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(2, 18)
end