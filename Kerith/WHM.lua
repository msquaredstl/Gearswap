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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

    if player.sub_job == 'SCH' then
		state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
		update_active_strategems()
    end	

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal') --F9
    state.CastingMode:options('Normal', 'Resistant', 'Combat') --Ctrl + F11
    state.IdleMode:options('Normal', 'CP', 'PDT', 'MDT', 'RR') --Ctrl + F12

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --
    AF.Head		=	""
    AF.Body		=	"Theophany Briault +1"
    AF.Hands	=	""
    AF.Legs		=	"Theophany Pantaloons +1"
    AF.Feet		=	"Theophany Duckbills +1"

    --Vitiation
    RELIC.Head		=	"Piety Cap +1"
    RELIC.Body		=	"Piety Briault +1"
    RELIC.Hands 	=	"Piety Mitts +3"
    RELIC.Legs		=	"Piety Pantaloons +1"
    RELIC.Feet		=	"Piety Duckbills +1"
	RELIC.Neck 		=	"Cleric's Torque"

    --Lethargy
    EMPY.Head		=	"Ebers Cap +1"
    EMPY.Body		=	"Ebers Bliaud +1"
    EMPY.Hands		=	"Ebers Mitts"
    EMPY.Legs		=	"Ebers Pantaloons +1"
    EMPY.Feet		=	"Ebers Duckbills"

    Salvage = {}
	Salvage.Head	=	""
	Salvage.Body	=	""
	Salvage.Hands	=	""
	Salvage.Legs 	=	""
	Salvage.Feet	=	""

	Limbus = {}
	Limbus.Head		=	"Ayanmo Zucchetto +1"
	Limbus.Body		=	"Ayanmo Corazza +2"
	Limbus.Hands	=	"Ayanmo Manopolas +2"
	Limbus.Legs 	=	"Ayanmo Cosciales +1"
	Limbus.Feet		=	"Ayanmo Gambieras +1"
	
	-- Capes:
    -- Sucellos's And such, add your own.
    WHMCape = {}
    WHMCape.MND	=	{ name="Alaunus's Cape" }
	WHMCape.ENH = 	{ name="Mending Cape" }


    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Swith Cape",waist="Witful Belt",legs="Kaykaus Tights",feet="Regal Pumps +1"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Impatiens", 
		ear2="Nourishing Earring +1"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}
	
	sets.precast.JA['Sublimation'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",
        body="Shango Robe",hands="Yaoyotl Gloves",
        legs="Querkening Brais",feet="Gendewitha Galoshes +1"}
    
	sets.precast.Trust = sets.precast.FC   
	
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Shango Robe",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Epaminondas's Ring",
        back=WHMCape.MND,waist=gear.ElementalBelt,legs="Querkening Brais",feet="Regal Pumps +1"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Nahtirah Hat",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Shango Robe",hands="Yaoyotl Gloves",ring1="Rufescent Ring",
        back=WHMCape.MND,waist="Thunder Belt",legs="Querkening Brais",feet="Regal Pumps +1"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Shango Robe",hands="Telchine Gloves",ring1="Prolix Ring",
        back="Swith Cape",legs="Kaykaus Tights",feet="Regal Pumps +1"}
    
    -- Cure sets
    gear.default.obi_waist = "Ninurta's Sash"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Queller Rod",sub="Sors Shield",ammo="Incantor Stone",
        head="Kaykaus Mitra",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Ebers Bliaud +1",hands="Telchine Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Cure = {main="Queller Rod",sub="Sors Shield",ammo="Incantor Stone",
        head="Kaykaus Mitra",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Curaga = {main="Queller Rod",sub="Sors Shield",ammo="Incantor Stone",
        head="Ebers Cap +1",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Kaykaus Mitra",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Cursna = {
		main="Ababinili +1",
		sub="Achaq Grip",
        head="Ebers Cap +1",
		neck="Malison Medallion",
        body="Ebers Bliaud +1",
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Menelaus's Ring",
        back=WHMCape.MND,
		waist="Gishdubar Sash",
		legs="Theophany Pantaloons +1",
		feet="Gendewitha Galoshes"}

    sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast.StatusRemoval = { head="Ebers Cap +1",legs="Ebers Pantaloons +1"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts/
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Culminus",
        head="Befouled Crown",neck="Incanter's Torque",
        body="Telchine Chasuble",hands="Dynasty Mitts",
        back="Mending Cape",waist="Embla Sash",legs="Piety Pantaloons +1",feet="Theophany Duckbills +1"}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {feet="Inspirited Boots"})
	sets.midcast.RefreshSelf = {waist="Gishdubar Sash"}

    sets.midcast.Auspice = {hands="Dynasty Mitts",feet="Ebers Duckbills"}

    sets.midcast.BarElement = {main="Ababinili +1",sub="Achaq Grip",
        head="Ebers Cap +1",neck="Incanter's Torque", body="Ebers Bliaud +1",hands="Orison Mitts +2",
        back="Mending Cape",waist="Embla Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills"}

    sets.midcast.Regen = {main="Bolelabunga",sub="Genmei Shield",
        body="Piety Briault +1",hands="Orison Mitts +2",
        legs="Theophany Pantaloons +1"}

    sets.midcast.Protectra = {ring1="Sheltered Ring",feet="Piety Duckbills +1"}

    sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons +1"}


    sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Sors Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Vanya Robe",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        back=WHMCape.MND,waist=gear.ElementalObi,legs="Theophany Pantaloons +1",feet="Gendewitha Galoshes"}

    sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Sors Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Shango Robe",hands="Yaoyotl Gloves",ring1="Fenrir Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Aswang Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Grioavolr", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Imbodla Necklace",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Ischemia Chasuble",hands="Yaoyotl Gloves",ring1="Leviathan Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Aswang Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    sets.midcast.IntEnfeebles = {main="Grioavolr", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Imbodla Necklace",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Ischemia Chasuble",hands="Yaoyotl Gloves",ring1="Shiva Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Yamabuki-no-obi",legs="Bokwus Slops",feet="Piety Duckbills +1"}
	sets.midcast['Erase'] = {neck=RELIC.Neck}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Boonwell Staff",
		sub="Niobid Strap",
		neck="Jeweled Collar", 
		ear1="Glorious Earring", 
		ear2="Relaxing Earring", 
		waist="Hierarch Belt",
		legs="Assiduity Pants +1"}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck=RELIC.Neck,ear1="Glorious Earring",ear2="Loquacious Earring",
        body="Annointed Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back=WHMCape.MND,waist="Witful Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Bolelabunga", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Meridian Ring",
        back=WHMCape.MND,waist="Witful Belt",legs="Querkening Brais",feet="Battlecast Gaiters"}

    sets.idle.Town = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Loquacious Earring",
        body="Annointed Kalasiris",hands="Gendewitha Gages +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back=WHMCape.MND,waist="Witful Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
        back=WHMCape.MND,waist="Witful Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}
    
 	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
	sets.idle.RR = set_combine(sets.idle.PDT,{body="Annointed Kalasiris"})

   -- Defense sets

    sets.defense.PDT = {sub="Genmei Shield",
        head="Kaykaus Mitra",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands="Gendewitha Gages +1",ring1="Defending Ring",
        back=WHMCape.MND,legs="Querkening Brais",feet="Battlecast Gaiters"}

    sets.defense.MDT = {sub="Genmei Shield",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Kaykaus Bliaut",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Archon Ring",
        back="Pahtli Cape",legs="Bokwus Slops",feet="Battlecast Gaiters"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		ammo="Hasty Pinion +1",
        head=Limbus.Head,
		neck="Lissome Necklace",
		ear1="Brutal Earring",
		ear2="Telos Earring",
        body=Limbus.Body,
		hands=Limbus.Hands,
		ring1="Hetaroi Ring",
		ring2="Chirich Ring +1",
        back=WHMCape.MND,
		waist="Windbuffet Belt +1",
		legs=Limbus.Legs,
		feet=Limbus.Feet}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +2",back="Mending Cape"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = WHMCape.MND
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
	
	if spell.skill == 'Enhancing Magic' then
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
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
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
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
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
		idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end

	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
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
    -- Default macro set/book
    set_macro_page(4, 3)
end

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end
