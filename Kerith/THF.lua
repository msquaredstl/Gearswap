-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Crit')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    -- Pillager
    AF.Head		=	"Pillager's Bonnet +1"
    AF.Body		=	"Pillager's Vest +1"
    AF.Hands	=	"Pillager's Armlets +1"
    AF.Legs		=	"Pillager's Culottes +1"
    AF.Feet		=	"Pillager's Poulaines +1"

    --Plunderer
    RELIC.Head		=	"Plunderer's Bonnet +1"
    RELIC.Body		=	"Plunderer's Vest +1"
    RELIC.Hands 	=	"Plunderer's Armlets +1"
    RELIC.Legs		=	"Plunderer's Culottes +1"
    RELIC.Feet		=	"Plunderer's Poulaines +1"

    --Skulker
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	"Skulker's Poulaines +1"

	Salvage = {}
	Salvage.Head	=	"Meghanada Visor +1"
	Salvage.Body	=	"Meghanada Cuirie +2"
	Salvage.Hands	=	"Meghanada Gloves +2"
	Salvage.Legs 	=	"Meghanada Chausses +2"
	Salvage.Feet	=	"Meghanada Jambeaux +1"

	Limbus = {}
	Limbus.Head		=	"Mummu Bonnet +2"
	Limbus.Body		=	"Mummu Jacket +2"
	Limbus.Hands	=	"Mummu Wrists +1"
	Limbus.Legs 	=	"Mummu Kecks +2"
	Limbus.Feet		=	"Mummu Gamashes +1"

    -- Capes:
    -- Sucellos's And such, add your own.
    THFCape = {}
    THFCape.TA	=  "Canny Cape"
	THFCape.Acc =  { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    THFCape.Wsd =  { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Evasion+15',}}

    sets.TreasureHunter = {hands=RELIC.Hands, waist="Chaac Belt", feet=EMPY.Feet}
    sets.ExtraRegen = {}
    sets.Kiting = {feet=RELIC.Feet}

    sets.buff['Sneak Attack'] = {ammo="Yetshila +1",
        head=AF.Head,neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands=AF.Hands,ring1="Rajas Ring",ring2="Adoulin Ring +1",
        back=THFCape.Wsd,waist="Patentia Sash",legs=AF.Legs,feet=RELIC.Feet}

    sets.buff['Trick Attack'] = {ammo="Yetshila +1",
        head=AF.Head,neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands=AF.Hands,ring1="Stormsoul Ring",ring2="Adoulin Ring +1",
        back=THFCape.Wsd,waist="Patentia Sash",legs=AF.Legs,feet=RELIC.Feet}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head=EMPY.Head}
    sets.precast.JA['Accomplice'] = {head=EMPY.Head}
    sets.precast.JA['Flee'] = {feet=AF.Feet}
    sets.precast.JA['Hide'] = {body=AF.Body}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {
		ammo="Barathrum",
		head=RELIC.Head,
		hands=AF.Hands,
		legs=AF.Legs,
		feet=AF.Feet}
	sets.precast.JA['Mug'] = sets.precast.JA['Steal']
    sets.precast.JA['Despoil'] = {ammo="Barathrum",legs=EMPY.Legs,feet=EMPY.Feet}
    sets.precast.JA['Perfect Dodge'] = {hands=RELIC.Hands}
    sets.precast.JA['Feint'] = {legs=RELIC.Legs}
	sets.precast.JA['Ambush'] = {body=RELIC.Body}
	sets.precast.JA["Assassin's Charge"] = {feet=RELIC.Feet}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Yamarang",
        head=Limbus.Head,
        body="Passion Jacket",
		hands=Limbus.Hands,
		ring1="Sirona's Ring",
		legs=Limbus.Legs,
		feet=RELIC.Feet
	}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",
        neck="Orunmila's Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
		body="Taeon Tabard",
        hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Lebeche Ring"}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads", body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Hasty Pinion +1",
        head="Adhemar Bonnet",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
        body="Herculean Vest",
		hands=Salvage.Hands,
		ring1="Rajas Ring",
		ring2="Adoulin Ring +1",
        back=THFCape.Wsd,
		waist="Prosilio Belt +1",
		legs=Salvage.Legs,
		feet="Herculean Boots"}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		ring1="Stormsoul Ring",
		legs="Nahtirah Trousers"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila +1"})
    sets.precast.WS['Exenterator'].TA = sets.precast.WS['Exenterator'].SA
    sets.precast.WS['Exenterator'].SATA = sets.precast.WS['Exenterator'].SA

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back=THFCape.Acc})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Yetshila +1"})
    sets.precast.WS['Dancing Edge'].TA = sets.precast.WS['Dancing Edge'].SA
    sets.precast.WS['Dancing Edge'].SATA = sets.precast.WS['Dancing Edge'].SA

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
        head="Uk'uxkaj Cap",
		neck="Rancor Collar",
		ear2="Odr Earring",
		hands=Limbus.Hands,
		ring2="Mummu Ring"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].TA = sets.precast.WS['Evisceration'].SA
    sets.precast.WS['Evisceration'].SATA = sets.precast.WS['Evisceration'].SA

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ear2="Ishvara Earring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila +1",
		ear2="Ishvara Earring",
        body=AF.Body,
		legs=AF.Legs})
    sets.precast.WS["Rudra's Storm"].TA = sets.precast.WS["Rudra's Storm"].SA
    sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		head=AF.Head,
		ear1="Brutal Earring",
		ear2="Zennaroi Earring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Yetshila +1",
        body=AF.Body,
		legs=AF.Legs})
    sets.precast.WS['Shark Bite'].TA = sets.precast.WS['Shark Bite'].SA
    sets.precast.WS['Shark Bite'].SATA = sets.precast.WS['Shark Bite'].SA

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {
		head=AF.Head,
		ear1="Brutal Earring",
		ear2="Zennaroi Earring"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {
		ammo="Honed Tathlum", 
		back=THFCape.Acc})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], {
		ammo="Yetshila +1",
        body=AF.Body,
		legs=AF.Legs})
    sets.precast.WS['Mandalic Stab'].TA = sets.precast.WS['Mandalic Stab'].SA
    sets.precast.WS['Mandalic Stab'].SATA = sets.precast.WS['Mandalic Stab'].SA

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Pemphredo Tathlum",
        head=RELIC.Head,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ring1="Dingir Ring",
		ring2="Shiva Ring +1",
        back=THFCape.Wsd,
		waist="Eschan Stone",
		legs=RELIC.Legs}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        ear2="Loquacious Earring",
        body=AF.Body,hands=AF.Hands,
        back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    -- Specific spells
    sets.midcast.Utsusemi = {
        neck="Ej Necklace",ear2="Loquacious Earring",
        body=AF.Body,hands=AF.Hands,ring1="Beeline Ring",
        back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    -- Ranged gear
    sets.midcast.RA = {
        neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dingir Ring",ring2="Hajduk Ring",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.midcast.RA.Acc = {
        head=AF.Head,neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        body="Iuitl Vest",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Adoulin Ring +1",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Thurandaut Tights +1",feet=RELIC.Feet}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Hasty Pinion +1",
        head="Adhemar Bonnet",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands="Pillager's Armlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs=AF.Legs,feet=AF.Feet}

    sets.idle.Town = {main="Tauret", sub="Shijo",ammo="Hasty Pinion +1",
        head="Adhemar Bonnet",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands="Pill. Armlets +1",ring1="Rajas Ring",ring2="Adoulin Ring +1",
        back="Shadow Mantle",waist="Patentia Sash",legs=AF.Legs,feet=AF.Feet}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head=Limbus.Head,neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs=AF.Legs,feet="Skadi's Jambeaux +1"}


    -- Defense sets

    sets.defense.Evasion = {ammo="Yamarang",
        head=AF.Head,neck="Ej Necklace",
        body=Limbus.Body,hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Beeline Ring",
        back="Canny Cape",waist="Flume Belt",legs=Limbus.Legs,feet="Iuitl Gaiters +1"}

    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Lithelimb Cap",neck="Loricate Torque +1",
        body=Limbus.Body,hands="Malignance Gloves",ring1="Defending Ring",
        back="Iximulew Cape",waist="Flume Belt",legs=Limbus.Legs,feet="Qaaxo Leggings"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Lithelimb Cap",neck="Loricate Torque +1",
        body=AF.Body,hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs=Limbus.Legs,feet="Qaaxo Leggings"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
        head	=	"Adhemar Bonnet",
		neck	=	"Anu Torque",
		ear1	=	"Sherida Earring",
		ear2	=	"Dedition Earring",
        body	=	"Adhemar Jacket +1",
		hands	=	"Adhemar Wristbands",
		--ring1	=	"Rajas Ring",
		ring1	=	"Chirich Ring +1",
		ring2	=	"Hetairoi Ring",
        back	=	THFCape.Acc,
		waist	=	"Windbuffet Belt +1",
		legs	=	Salvage.Legs,
		feet	=	"Herculean Boots"
	}
		
    sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Yamarang",
        head=Limbus.Head,
		neck="Erudition necklace",
		ear2="Telos Earring",
        body=Salvage.Body,
		hands=Salvage.Hands,
		--ring2="Adoulin Ring +1",
		ring2="Chirich Ring",
		legs=Limbus.Legs,
		feet=Limbus.Feet
	})
		
	sets.engaged.Crit = set_combine(sets.engaged, {
		ammo="Yetshila +1",
		head=Limbus.Head,
		ear2="Odr Earring",
		body=Limbus.Body,
		hands=Limbus.Hands,
		ring1="Mummu Ring",
		ring2="Hetairoi Ring",
		legs=Limbus.Legs,
		feet=Limbus.Feet
	})


    sets.engaged.Evasion = {ammo="Hasty Pinion +1",
        head="Felistris Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Adoulin Ring +1",
        back="Canny Cape",waist="Patentia Sash",legs=Limbus.Legs,feet="Qaaxo Leggings"}
		
    sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body=AF.Body,hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Adoulin Ring +1",
        back="Canny Cape",waist="Hurch'lan Sash",legs=Limbus.Legs,feet="Qaaxo Leggings"}

    sets.engaged.PDT = {ammo="Staunch Tathlum +1",
        head="Felistris Mask",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Emet Harness +1",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Adoulin Ring +1",
        back="Iximulew Cape",waist="Patentia Sash",legs=Limbus.Legs,feet="Qaaxo Leggings"}
    
	sets.engaged.Acc.PDT = {ammo="Staunch Tathlum +1",
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Emet Harness +1",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Adoulin Ring +1",
        back="Canny Cape",waist="Hurch'lan Sash",legs=Limbus.Legs,feet="Qaaxo Leggings"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
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

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(3, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 6)
    else
        set_macro_page(2, 6)
    end
end


