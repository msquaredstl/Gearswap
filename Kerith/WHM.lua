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
    state.IdleMode:options('Normal', 'CP', 'PDT', 'RR', 'Move') --Ctrl + F12

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
    AF.Head		=	"Theophany Cap +1"
    AF.Body		=	"Theophany Bliaut +2"
    AF.Hands	=	"Theophany Mitts +3"
    AF.Legs		=	"Theophany Pantaloons +2"
    AF.Feet		=	"Theophany Duckbills +1"

    --Vitiation
    RELIC.Head		=	"Piety Cap +3"
    RELIC.Body		=	"Piety Bliaut +3"
    RELIC.Hands 	=	"Piety Mitts +3"
    RELIC.Legs		=	"Piety Pantaloons +3"
    RELIC.Feet		=	"Piety Duckbills +3"
	RELIC.Neck 		=	"Cleric's Torque"

    --Lethargy
    EMPY.Head		=	"Ebers Cap +1"
    EMPY.Body		=	"Ebers Bliaut +1"
    EMPY.Hands		=	"Ebers Mitts +1"
    EMPY.Legs		=	"Ebers Pantaloons +1"
    EMPY.Feet		=	"Ebers Duckbills +1"

    Salvage = {}
	Salvage.Head	=	"Inyanga Tiara +2"
	Salvage.Body	=	"Inyanga Jubbah +2"
	Salvage.Hands	=	"Inyanga Dastanas +2"
	Salvage.Legs 	=	"Inyanga Shalwar +2"
	Salvage.Feet	=	"Inyanga Crackows +2"
	Salvage.Ring	=	"Inyanga Ring"

	Limbus = {}
	Limbus.Head		=	"Ayanmo Zucchetto +2"
	Limbus.Body		=	"Ayanmo Corazza +2"
	Limbus.Hands	=	"Ayanmo Manopolas +2"
	Limbus.Legs 	=	"Ayanmo Cosciales +2"
	Limbus.Feet		=	"Ayanmo Gambieras +2"
	
	-- Capes:
    -- Sucellos's And such, add your own.
    WHMCape = {}
    WHMCape.MND	=	{ name="Alaunus's Cape" }
	WHMCape.ENH = 	{ name="Mending Cape" }


    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",ammo="Impatiens",
        head="Vanya Hood",neck=RELIC.Neck,ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=Limbus.Body,hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Perimede Cape",waist="Witful Belt",legs=Limbus.Legs,feet="Regal Pumps +1"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs=EMPY.Legs})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Impatiens", 
		ear1="Mendicant's Earring",
		ear2="Nourishing Earring +1",
		legs=EMPY.Legs})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body=RELIC.Body}
	--sets.precast.JA['Martyr'] = {hands=RELIC.Hands}
	sets.precast.JA['Devotion'] = {head=RELIC.Head}
	
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
    gear.default.weaponskill_waist = "Fotia Belt"
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

    sets.midcast.Cure = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
        head=EMPY.Head,
		neck=RELIC.Neck,
		ear1="Glorious Earring",
		ear2="Nourishing Earring +1",
        body=EMPY.Body,
		hands=AF.Hands,
		ring1="Menelaus's Ring",
		ring2="Lebeche Ring",
        back=WHMCape.MND,
		waist="Hachirin-no-Obi",
		legs=EMPY.Legs,
		feet=RELIC.Feet}
		
    sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
		})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        body=AF.Body})

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Kaykaus Mitra",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Kaykaus Bliaut",hands=AF.Hands,ring1="Prolix Ring",ring2="Sirona's Ring",
        back=WHMCape.MND,waist="Hachirin-no-Obi",legs=EMPY.Legs,feet=RELIC.Feet}

    sets.midcast.Cursna = {
		main="Gada",
		sub="Ammurapi Shield",
        head="Vanya Hood",
		neck="Malison Medallion",
        body=EMPY.Body,
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Menelaus's Ring",
        back=WHMCape.MND,
		waist="Gishdubar Sash",
		legs=AF.Legs,
		feet="Vanya Clogs"}

    sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast.StatusRemoval = { head=EMPY.Head,legs=EMPY.Legs}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts/
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
        head="Befouled Crown",neck="Incanter's Torque",
        body="Telchine Chasuble",hands="Dynasty Mitts",
        back="Mending Cape",waist="Embla Sash",legs=RELIC.Legs,feet=AF.Feet}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {feet="Inspirited Boots"})
	sets.midcast.RefreshSelf = {waist="Gishdubar Sash"}

    sets.midcast.Auspice = {hands="Dynasty Mitts",feet=EMPY.Feet}

    sets.midcast.BarElement = {
        head=EMPY.Head,neck="Incanter's Torque", body=EMPY.Body,hands=EMPY.Hands,
        back="Mending Cape",waist="Embla Sash",legs=RELIC.Legs,feet=EMPY.Feet}

    sets.midcast.Regen = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		head=Salvage.Head,
        body=RELIC.Body,
		hands=EMPY.Hands,
        legs=AF.Legs}

    sets.midcast.Protectra = {ring1="Sheltered Ring",feet=RELIC.Feet}

    sets.midcast.Shellra = {ring1="Sheltered Ring",legs=RELIC.Legs}


    sets.midcast['Divine Magic'] = {main="Gada",sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Vanya Robe",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Hachirin-no-Obi",legs=AF.Legs,feet="Gendewitha Galoshes"}

    sets.midcast['Dark Magic'] = {main="Gada", sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Nourishing Earring +1",
        body="Shango Robe",hands="Yaoyotl Gloves",ring1="Fenrir Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Aswang Sash",legs="Chironic Hose",feet=RELIC.Feet}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Gada", sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Imbodla Necklace",ear1="Gwati Earring",ear2="Vor Earring",
        body="Ischemia Chasuble",hands="Kaykaus Cuffs +1",ring1="Leviathan Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Rumination Sash",legs="Chironic Hose",feet=RELIC.Feet}

    sets.midcast.IntEnfeebles = {main="Gada", sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Imbodla Necklace",ear1="Gwati Earring",ear2="Vor Earring",
        body="Ischemia Chasuble",hands="Kaykaus Cuffs +1",ring1="Shiva Ring +1",ring2="Sangoma Ring",
        back=WHMCape.MND,waist="Rumination Sash",legs="Chironic Hose",feet=RELIC.Feet}
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
        body=RELIC.Body,hands=Salvage.Hands,ring1=Salvage.Ring,ring2="Adoulin Ring +1",
        back=WHMCape.MND,waist="Fucho-no-obi",legs="Assiduity Pants +1",feet=Salvage.Feet}

    sets.idle.PDT = {main="Bolelabunga", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=WHMCape.MND,waist="Witful Belt",legs="Querkening Brais",feet="Battlecast Gaiters"}

    sets.idle.Town = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Loquacious Earring",
        body=RELIC.Body,hands="Gendewitha Gages +1",ring1=Salvage.Ring,ring2="Adoulin Ring +1",
        back=WHMCape.MND,waist="Witful Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands=Limbus.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=WHMCape.MND,waist="Witful Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}
    
 	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
	sets.idle.RR = {body="Annointed Kalasiris"}
	sets.idle.Move = {feet="Herald's Gaiters"}

   -- Defense sets

    sets.defense.PDT = {sub="Genmei Shield",
        head="Kaykaus Mitra",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Annointed Kalasiris",hands="Gendewitha Gages +1",ring1="Defending Ring",
        back=WHMCape.MND,legs="Querkening Brais",feet="Battlecast Gaiters"}

    sets.defense.MDT = {sub="Genmei Shield",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Kaykaus Bliaut",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Archon Ring",
        back=WHMCape.MND,legs="Chironic Hose",feet="Battlecast Gaiters"}

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
    sets.buff['Divine Caress'] = {hands=EMPY.Hands,back="Mending Cape"}
	
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
