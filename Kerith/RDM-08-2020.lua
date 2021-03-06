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
    state.Buff.Saboteur = buffactive.saboteur or false
	state.Obi = M(false, 'Obi')
	state.Seidr = M(false, 'Seidr')
	state.MagicBurst = M(false, 'Magic Burst')
	
	include('Mote-TreasureHunter')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Dual Wield')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'Staff')


	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
	'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
	'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',}

	HighTierNuke = S{'Stone III', 'Stone IV', 'Stone V', 'Stone VI', 'Stonega II', 'Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water III', 'Water IV', 'Water V', 'Water VI', 'Waterga II', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero III', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga II', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire III', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga II', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga II', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga II', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet'}
	
    gear.default.obi_waist = "Sekhmet Corset"

    -- Additional local binds	
	send_command('bind ^end gs c toggle MagicBurst')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')
   
    select_default_macro_book(5,5)
	
	gear.MB_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst mdg.+10%','Mag. Acc.+3',}}
	gear.MAB_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',}}

	gear.DarkRing={name="Archon Ring"}

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^end gs c toggle MagicBurst')
	send_command('unbind ^delete gs c toggle Obi')
	send_command('unbind ^home gs c toggle Seidr')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
 
    sets.TreasureHunter = {waist="Chaac Belt"}

 --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +1",hands="Helios Gloves",
        back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",ammo="Impatiens",
        head="Atrophy Chapeau +1",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Leyline Gloves",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    
	sets.precast.Trust = sets.precast.FC
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +1",hands="Helios Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Soil Gorget",ear1="Brutal Earring",ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
        head="Hagondes Hat +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Strendu Ring",ring2="Adoulin Ring +1",
        back="Toro Cape",legs="Amalric Slops",feet="Umbanii Boots"}

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +1",ear2="Loquacious Earring",
        body="Vitiation Tabard +1",hands="Leyline Gloves",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",
        head="Gendewitha Caubeen +1",neck="Incanter's Torque",ear1="Roundel Earring",ear2="Loquacious Earring",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Swith Cape",waist="Witful Belt",legs="Atrophy Tights +1",feet="Hagondes Sabots"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {
        head="Atrophy Chapeau +1",neck="Incanter's Torque",
        body="Vitiation Tabard +1",hands="Atrophy Gloves +1",ring1="Prolix Ring",
        back="Sucellos's Cape",waist="Olympus Sash",legs="Atrophy Tights +1",feet="Lethargy Houseaux +1"}

    sets.midcast.Refresh = {legs="Lethargy Fuseau +1"}

    sets.midcast.Stoneskin = {waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Kalboron Stone",
        head="Vitiation Chapeau +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
        body="Vanya Robe",hands="Helios Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Sucellos's Cape",waist="Demonry Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +1"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +1"})

    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Boots +1"})
    
    -- Elemental Magic sets
    
    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Venabulum",sub="Zuuxowu Grip",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Toro Cape",waist="Refoccilation Stone",legs="Amalric Slops",feet=MAB_feet}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap", neck="Imbodla Necklace",ear2="Gwati Earring",back="Refraction Cape",waist="Refoccilation Stone",legs="Psycloth Lappas"})

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {main="Lehbrailg +2",sub="Alber Strap",ring2="Shiva Ring +1",back="Toro Cape"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {sub="Niobid Strap",ring2="Adoulin Ring +1"})

        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {main="Twebuliij",sub="Mephitis Grip",ammo="Kalboron Stone",
        head="Atrophy Chapeau +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
        body="Shango Robe",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Goading Belt",legs="Psycloth Lappas",feet="Bokwus Boots"}

    sets.midcast.Stun = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Kalboron Stone",
        head="Atrophy Chapeau +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
        body="Vitiation Tabard +1",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {hands="Atrophy Gloves +1",back="Ghostfyre Cape",feet="Lethargy Houseaux +1"}
        
    sets.buff.ComposureOther = {head="Lethargy Chappel +1",
        body="Lethargy Sayon +1",hands="Lethargy gantherots +1",
        legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

    sets.buff.Saboteur = {hands="Lethargy gantherots +1"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Boonwell Staff",neck="Jeweled Collar", ear1="Moonshade Earring", ear2="Relaxing Earring",
        ring1="Star Ring",waist="Hierarch Belt",legs="Assiduity Pants +1"}

    -- Idle sets
    sets.idle = {main="Bolelabunga",sub="Beatific Shield +1",ammo="Homiliary",
        head="Vitiation Chapeau +1",neck="Wiglen Gorget",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Helios Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses",feet="Atrophy Boots +1"}

    sets.idle.Town = {main="Excalibur",sub="Thuellaic ecu +1",ammo="Homiliary",
        head="Vitiation Chapeau +1",neck="Asperity necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back="Ghostfyre Cape",waist="Cetl Belt",legs="Carmine Cuisses",feet="Atrophy Boots +1"}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Homiliary",
        head="Vitiation Chapeau +1",neck="Wiglen Gorget",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses",feet="Hagondes Sabots"}

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Lithelimb Cap",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Flume Belt",legs="Amalric Slops",feet="Battlecast Gaiters"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Gendewitha Caubeen +1",hands="Helios Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Battlecast Gaiters"}

	sets.idle.Staff = {main="Venabulum",sub="Mephtis Grip",ammo="Impatiens",
		head="Vitiation Chapeau +1",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Carmine Cuisses",feet="Atrophy Boots +1"}
    
	sets.idle['Dual Wield'] = {}
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +1",neck="Twilight Torque",
        body="Hagondes Coat +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Flume Belt",feet="Battlecast Gaiters"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",
        body="Hagondes Coat +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",feet="Battlecast Gaiters"}

    sets.Kiting = {legs="Carmine Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi",ammo="Impatiens"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.magic_burst = {neck="Mizu. Kubikazari", ring2="Locus ring", ear2="Static Earring", back="Seshaw Cape", ring1="mujin band", feet=MB_feet}
	sets.Seidr = {body="Seidr Cotehardie"}
	sets.Obi = {back="Twilight Cape", waist="Hachirin-no-Obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = { ammo="Hasty Pinion +1",
        head="Vitiation Chapeau +1",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Zennaroi Earring",
        body="Taeon Tabard",hands="Leyline Gloves",ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses",feet="Atrophy Boots +1"}
	
	sets.engaged['Dual Wield'] = set_combine(sets.engaged, { ear2="Suppanomimi", waist="Windbuffet Belt +1", feet="Taeon Boots" })
	
    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Atrophy Boots"}
		

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.Obi.value then equip(sets.Obi)
	end

    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then equip(sets.magic_burst)
    end

	if spell.skill == 'Elemental Magic' and state.Seidr.value then equip(sets.Seidr)
	end
	
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5,5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    elseif player.sub_job == 'THF' then
        set_macro_page(5,5)
    else
        set_macro_page(5, 5)
    end
end

