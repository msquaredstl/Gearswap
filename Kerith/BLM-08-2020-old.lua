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
    state.CastingMode:options('Normal', 'Resistant','DeathMB')
    state.IdleMode:options('Normal', 'PDT','HighMP')
    

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	--	HighTierNuke = S{'Stone IV', 'Stone V', 'Stone VI','Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water IV', 'Water V', 'Water VI', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet'}
   
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^end gs c toggle MagicBurst')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')

    select_default_macro_book()
	
	gear.DarkRing={name="Archon Ring"}
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
    -- Start defining the sets
    --------------------------------------
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",ammo="Impatiens",
        head={name="Merlinic Hood", priority=2},neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Prolix Ring",hands="Helios Gloves",
        back="Swith Cape",waist="Witful Belt",legs={name="psycloth lappas", priority=1}, feet="Regal Pumps +1"}

	sets.precast.FC.DeathMB = set_combine(sets.precast.FC, {ammo="Psilomene", ear1={name="Barkarole Earring", priority=4},
		body="Zendik Robe", hands={name="Otomi gloves", priority=7}, ring1="Sangoma ring",ring2={name="Mephitas's ring +1", priority=9}, back={name="Taranus's Cape", priority=6}, feet={name="MAB_Feet", priority=8}})
		
	sets.precast.FC.Aspir = sets.precast.FC.Death	

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal", feet="Tutyr Sabots"})

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.Trust = sets.precast.FC

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Merlinic Hood",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Rajas Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Adoulin Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		-- Increase Max MP
     sets.precast.WS['Myrkr'] = {ammo="Kalboron Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Barkarole Earring",ear2="Loquacioous Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Sangoma Ring",ring2="Mephitas's ring +1",
        back="Bane Cape",waist="Fucho-no-obi",legs="Psycloth Lappas",feet="Medium's Sabots"}
   
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",neck="Orunmila's Torque",
        body="Shango Robe",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",ammo="Kalboron Stone",
        head="Nahtirah Hat",neck="Incanter's Torque",ear2="Loquacious Earring",
        body="Wretched Coat",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = { head="Befouled Crown", neck="Incanter's Torque",body="Vanya Robe",feet="Regal Pumps +1" }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Imbodla Necklace",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Vanya Robe",hands="Helios Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",legs="Psycloth Lappas",feet="Medium's Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Goading Belt",legs="Psycloth Lappas",feet="Wicce Sabots +1"}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Pixie Hairpin +1", neck="Incanter's Torque", hands="Helios Gloves", ring1="Archon Ring", back="Bane cape", waist="Fucho-no-obi", legs="Amalric Slops",feet=MAB_feet})
    
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast['Aspir III'] = sets.midcast.Drain

	sets.midcast.Stun = {main="Lathi",sub="mephitis grip",ammo="Impatiens",
		head="Nahtirah Hat",neck="orunmilia torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="helios jacket",hands="Yaoyotl Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="regal pumps +1"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Zuuxowu Grip",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Bane Cape",waist="Refoccilation Stone",legs="Amalric Slops",feet=MAB_feet}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap", neck="Imbodla Necklace",ear2="Gwati Earring",back="Refraction Cape",waist="Refoccilation Stone",legs="Psycloth Lappas"})

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Alber Strap",ring2="Shiva Ring +1",back="Toro Cape"})
    
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {ring2="Adoulin Ring"})

	sets.midcast.Death = {Ammo="Ghastly Tathlum +1", head={name="Pixie Hairpin +1", priority=3}, neck="Mizukage-no-kubikazari", ear1="Barkarole Earring", ear2="Static Earring",body={name="Merlinic Jubbah", priority=2}, hands="Amalric Gages", ring2={name="Mephitas's Ring +1", priority=4}, ring1="Archon Ring",back="Seshaw Cape", waist="Hachirin-no-Obi", legs={name="Amalric Slops", priority=1}, feet={name=MAB_Feet, priority=5}}
	 
	sets.midcast.Comet = set_combine(sets.midcast.Death,{
						 Ammo="Pemphredo Tathlum", ring1="Mujin Band", legs="Merlinic Shalwar"})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Boonwell Staff",neck="Jeweled Collar", ear1="Moonshade Earring", ear2="Relaxing Earring",
        ring1="Star Ring",waist="Hierarch Belt",legs="Assiduity Pants +1"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi", sub="Zuuxowu Grip",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Bane Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Amalric Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Fucho-no-obi",legs="Hagondes Pants",feet="Battlecast Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Amalric Gages",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Battlecast Gaiters"}
    
    -- Town gear.
    sets.idle.Town = {main="Lathi",sub="Zuuxowu Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Wretched Coat",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Bane Cape",waist="Refoccilation Stone",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
        
	sets.idle.HighMP = set_combine(sets.precast.FC.DeathMB,{sub="Niobid Strap",ammo="Psilomene", head="Merlinic Hood"})
    -- Defense sets

    sets.defense.PDT = { head="Nahtirah Hat",neck="Twilight Torque",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Hierarch Belt",legs="Amalric Slops", feet="Battlecast Gaiters"}
    
	sets.defense.CP = {  back="Mecistopins Mantle" }

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Helios Jacket",hands="Helios Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Psycloth Lappas",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Wicce Sabots +1"}

    sets.magic_burst = {neck="Mizu. Kubikazari", ring2="Locus ring", ear2="Static Earring", back="Seshaw Cape", ring1="mujin band", feet=MB_feet}
	sets.Seidr = {body="Spaekona's Coat +1"}
	sets.Obi = {back="Twilight Cape", waist="Hachirin-no-Obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Hasty Pinion +1",
        head="Befouled Crown",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Hagondes Cuffs +1",ring1="Adoulin Ring",ring2="Rajas Ring",
        back="Umbra Cape",waist="Cetl Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
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

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
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
    set_macro_page(3, 20)
end