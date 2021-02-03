-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
	state.Obi = M(false, 'Obi')
	state.Seidr = M(false, 'Seidr')
	state.MagicBurst = M(false, 'Magic Burst')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal') --F9
    state.CastingMode:options('Normal', 'Resistant') --Ctrl + F11
    state.IdleMode:options('Normal', 'CP', 'PDT', 'MDT', 'RR') --Ctrl + F12


    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    send_command('bind ^` input /ma Stun <t>')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')
	send_command('bind ^end gs c toggle MagicBurst')
    select_default_macro_book()


end

function user_unload()
    send_command('unbind ^`')
	send_command('unbind ^delete gs c toggle Obi')
	send_command('unbind ^home gs c toggle Seidr')
	send_command('unbind ^end gs c toggle MagicBurst')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --
    AF.Head		=	""
    AF.Body		=	""
    AF.Hands	=	""
    AF.Legs		=	""
    AF.Feet		=	""

    --Vitiation
    RELIC.Head		=	""
    RELIC.Body		=	""
    RELIC.Hands 	=	""
    RELIC.Legs		=	""
    RELIC.Feet		=	""

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	""

	Salvage = {}
	Salvage.Head	=	"Jhakri Coronal +1"
	Salvage.Body	=	"Jhakri Robe +2"
	Salvage.Hands	=	"Jhakri Cuffs +2"
	Salvage.Legs 	=	"Jhakri Slops +2"
	Salvage.Feet	=	"Jhakri Pigaches +2"

	Limbus = {}
	Limbus.Head		=	"Mallquis Chapeau +1"
	Limbus.Body		=	"Mallquis Saio +1"
	Limbus.Hands	=	"Mallquis Cuffs +1"
	Limbus.Legs 	=	"Mallquis Trews +1"
	Limbus.Feet		=	"Mallquis Clogs +1"

	AMBU ={}
	AMBU.Grip		=	"Kaja Grip"
	
    -- Capes:
    -- Sucellos's And such, add your own.
    SCHCape = {}
    SCHCape.FreeNuke	=	{ name="" }

	MB_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','Mag. Acc.+3',}}
	MAB_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',}}


    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +1"}


    -- Fast cast sets for spells

    sets.precast.FC = {main="Marin Staff +1",sub="Niobid Strap",ammo="Impatiens",
        head="Merlinic Hood",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Prolix Ring",hands="Leyline Gloves",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas", feet="Pedagogy Loafers +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {feet="Tutyr Sabots"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

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
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Adoulin Ring +1",
        back="Toro Cape",waist="Thunder Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		-- Increase Max MP
     sets.precast.WS['Myrkr'] = {
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Barkarole Earring",ear2="Loquacioous Earring",
        body="Helios Jacker",hands="Helios Gloves",ring1="Sangoma Ring",ring2="Mephitas's ring +1",
        back="Bane Cape",waist="Fucho-no-obi",legs="Psycloth Lappas",feet="Medium's Sabots"}
   
    -- Midcast Sets

    sets.midcast.FastRecast = {ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Pedagogy Loafers +1"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
        head="Kaykaus Mitra",neck="Incanter's Torque",ear2="Loquacious Earring",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Kaykaus Tights",feet="Medium's Sabots"}

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure,{waist="Hachirin-no-Obi"})

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast.Regen = {main="Bolelabunga",head="Arbatel Bonnet +1"}

    sets.midcast.Cursna = {
		neck="Malison Medallion", 
		hands="Hieros Mittens",
		ring1="Ephedra Ring",
		ring2="Sirona's Ring",
		waist="Gishdubar Sash",
		feet="Gendewitha Galoshes"}

    sets.midcast['Enhancing Magic'] = {ammo="Savant's Treatise",head="Arbitel Bonnet +1",neck="Incanter's Torque",body="Manasa Chasuble",legs="Regal Pumps +1"}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers +1"})

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast['Enfeebling Magic'] = {main="Grioavolr",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Vanya Robe",hands="Helios Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Chironic Hose",feet="Medium's sabots"}

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Shiva Ring +1",ring2="Shiva Ring +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Globidonta Ring"})
	
	sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Culminus",ammo="Hydrocera",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Shango Robe",hands="Amalric Cages",ring1="Adoulin Ring +1",ring2="Sangoma Ring",
		back="Bookworm's Cape",waist="Witful Belt",legs="Pedagogy Pants +1",feet="Medium's Sabots"}

    sets.midcast.Drain = {main="Grioavolr",sub="Mephitis Grip",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Shango Robe",hands="Gendewitha Gages",ring1="Excelsis Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Fucho-no-obi",legs="Pedagogy Pants +1",feet="Academic's Loafers"}

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Imbodla Necklace",ear1="Gwati earring",ear2="Enchanter earring +1",
        body="Shango Robe",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Pedagogy Loafers +1"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {ammo="Pemphredo Tathlum"})


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Grioavolr",sub="Zuuxowu Grip",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Saevus Pendant +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Bookworm's Cape",waist="Refoccilation Stone",legs="Amalric Slops",feet=MAB_feet}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
	sub="Niobid Strap", 
	neck="Sanctity Necklace",
	ear2="Gwati Earring",
	back="Refraction Cape",
	waist="Refoccilation Stone",
	legs="Psycloth Lappas"})

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		main="Grioavolr",
		sub="Alber Strap",
		ring2="Shiva Ring +1",
		back="Toro Cape"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {sub="Niobid Strap",ring2="Adoulin Ring +1"})

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {neck="Sanctity Necklace",back="Bookworm's Cape"})
	sets.midcast.Noctohelix = set_combine(sets.midcast.Helix, {head="Pixie Hairpin +1"})
	sets.midcast.Luminohelix = set_combine(sets.midcast.Helix, {ring1="Weatherspoon Ring"})
	
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak"})

	sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'], {head="Pixie Hairpin +1"})


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {main="Boonwell Staff",neck="Jeweled Collar", ear1="Moonshade Earring", ear2="Relaxing Earring",
        ring1="Star Ring",waist="Hierarch Belt",legs="Assiduity Pants +1"}

    -- Normal refresh idle set
    sets.idle = {main="Grioavolr", sub="Niobid Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Kaykaus Bliaut",hands="Amalric Gages",ring1="Adoulin Ring +1",ring2="Fenrir Ring +1",
        back="Bookworm's Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Bolelabunga",sub="Genmei Shield",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Amalric Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Moonbeam Cape",waist="Fucho-no-obi",legs=Limbus.Legs,feet="Battlecast Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = set_combine(sets.idle.PDT, {feet="Herald's Gaiters"})
 
	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
 	sets.idle.RR = set_combine(sets.idle.PDT,{body="Annointed Kalasiris"})
 
    -- Town gear.
    sets.idle.Town = {main="Grioavolr",sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head="Academic's Mortarboard +1",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Pedagogy Gown +1",hands="Arbatel Bracers +1",ring1="Adoulin Ring +1",ring2="Fenrir Ring +1",
        back="Bane Cape",waist="Refoccilation Stone",legs="Arbatel Pants +1",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum +1", head="Nahtirah Hat",neck="Loricate Torque +1",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Moonbeam Cape",waist="Hierarch Belt",legs="Amalric Slops", feet="Battlecast Gaiters"}
    
	sets.defense.CP = {  back="Mecistopins Mantle" }

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Nahtirah Hat",neck="Loricate Torque +1",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2="Archon Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Psycloth Lappas",feet=Limbus.Feet}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion


    -- Normal melee group
    sets.engaged = {ammo="Hasty Pinion +1",
        head="Befouled Crown",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Hagondes Cuffs +1",ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back="Moonbeam Cape",waist="Windbuffet Belt +1",legs="Chironic Hose",feet="Battlecast Gaiters"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
	sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
	sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
	sets.buff['Penury'] = {legs="Arbatel Pants +1"}
	sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
	sets.buff['Celerity'] = {feet="Pedagogy Loafers +1"}
	sets.buff['Alacrity'] = {feet="Pedagogy Loafers +1"}
	sets.buff['Stormsurge'] = {feet="Pedagogy Loafers +1"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    sets.buff.FullSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring",body="Pedagogy Gown +1",waist="Embla Sash"}
    sets.buff.PDTSublimation = sets.buff.FullSublimation

    sets.magic_burst = {neck="Mizu. Kubikazari", ring2="Locus ring", ear2="Static Earring", back="Seshaw Cape", ring1="mujin band", feet=MB_feet}
	sets.Seidr = {body="Seidr Cotehardie"}
	sets.Obi = {waist="Hachirin-no-Obi"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
	
	if spell.skill == 'Elemental Magic' and state.Obi.value then
	equip(sets.Obi)
	end

	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
			equip(sets.magic_burst)
	end

	if spell.skill == 'Elemental Magic' and state.Seidr.value then
		equip(sets.Seidr)
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

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
		end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end

