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
    state.OffenseMode:options('None', 'Normal') --F9
    state.CastingMode:options('Normal', 'Resistant') --Ctrl + F11
    state.IdleMode:options('Normal','CP', 'PDT', 'MDT', 'RR') --Ctrl + F12
 
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
	
	gear.MB_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','Mag. Acc.+3',}}
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

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --
    AF.Head		=	"Geomancy Galero +1"
    AF.Body		=	"Geomancy Tunic +2"
    AF.Hands	=	"Geomancy Mitaines +3"
    AF.Legs		=	"Geomancy Pants +2"
    AF.Feet		=	"Geomancy Sandals +3"

    --Vitiation
    RELIC.Head		=	"Bagua Galero +1"
    RELIC.Body		=	"Bagua Tunic +3"
    RELIC.Hands 	=	"Bagua Mitaines +3"
    RELIC.Legs		=	"Bagua Pants +3"
    RELIC.Feet		=	"Bagua Sandals +3"
	RELIC.Neck		=	"Bagua Charm +1"

    --Lethargy
    EMPY.Head		=	"Azimuth Hood +1"
    EMPY.Body		=	"Azimuth Coat +1"
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	"Azimuth Gaiters +1"

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
	Limbus.Feet		=	"Mallquis Clogs +2"
	
    -- Capes:
    -- Sucellos's And such, add your own.
    GEOCape = {}
		GEOCape.Indi	=	{ name="Nantosuelta's Cape" }
		GEOCape.Geo		=	{ name="Lifestream Cape" }
	
	Weapons = {}

		Weapons.GEO = {name="Idris"}
		Weapons.Indi = {name="Solstice"}
		Weapons.MACC = {name="Grioavolr"}

	Subweapons = {}
		
		Subweapons.FreeNuke = {name="Alber Strap"}
		Subweapons.MACC = {name="Niobid Strap"}
		Subweapons.MB = {}

	Necklace = {}
	
		Necklace.FreeNuke = {name="Saevus Pendant +1"}
		Necklace.MACC = {name="Sanctity Necklace"}
		Necklace.MB = {name="Mizukage-no-kubikazari"}
		
	Earrings = {}
		Earrings.FreeNuke = {name="Barkarole Earring"}
		Earrings.FreeNuke2 = {name="Friomisi Earring"}
		Earrings.TP = {name="Moonshade Earring"}

	Mb_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst mdg.+10%','Mag. Acc.+3',}}
	Mab_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',} }

	
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body=RELIC.Body}
    sets.precast.JA['Life Cycle'] = {body=AF.Body,back=GEOCape.Indi }
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {
		main=Weapons.MACC,
		sub="Niobid Strap",
		range=none, 
		ammo="Impatiens",
        head="Nahtirah Hat",
		neck="Orunmila's Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Shango Robe",
		ring1="Prolix Ring",
        back=GEOCape.Geo,
		waist="Witful Belt",
		legs=AF.Legs,
		feet="Regal Pumps +1"}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Sors Shield",back="Pahtli Cape"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands=RELIC.Hands})
 
	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=none})
	
	sets.precast['Indi-*'] = set_combine(sets.precast.FC.Geomancy, {main=Weapons.Indi})
   
	sets.precast.Trust = sets.precast.FC
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nahtirah Hat",
		neck="Fotia Gorget",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Jhakri Robe +2",
		hands="Helios Gloves",
		ring1="Rajas Ring",
		ring2="Adoulin Ring +1",
        back=GEOCape.Indi,
		waist="Fotia Belt",
		legs="Amalric Slops",
		feet=MAB_feet}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
		ammo="Pemphredo Tathlum",
        head="Hagondes Hat +1",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Barkarole Earring",
        body="Amalric Doublet",
		hands="Helios Gloves",
		ring1="Rufescent Ring",
        back=GEOCape.Indi,
		legs="Amalric Slops",
		feet=MAB_feet}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head="Merlinic Hood",
		ear2="Loquacious Earring",
		neck="Orunmila's Torque",
        body="Shango Robe",
		ring1="Prolix Ring",
        back=GEOCape.Geo,
		waist="Witful Belt",
		legs="Amalric Slops",
		feet="Regal Pumps +1"}
 
    sets.midcast['Enhancing Magic'] = { 
		head="Befouled Crown", 
		body="Telchine Chasuble",
		neck="Incanter's Torque",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Embla Sash",
		feet="Regal Pumps +1" }

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.RefreshSelf = {waist="Gishdubar Sash", feet="Inspirited Boots"}

    sets.midcast['Enfeebling Magic'] = {
		main=Weapons.MACC,
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
        head="Befouled Crown",
		neck="Incanter's Torque",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        body="Vanya Robe",
		hands="Helios Gloves",
		ring2="Sangoma Ring",
        cape=GEOCape.Geo,
		waist="Eschan Stone",
		legs="Psycloth Lappas",
		feet=RELIC.Feet}
    
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main=Weapons.GEO,
		sub="Culminus",
		ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
		neck="Saevus Pendant +1",
		ear1="Barkarole Earring",
		ear2="Friomisi Earring",
        body="Merlinic Jubbah",
		hands="Amalric Gages",
		ring1="Shiva Ring +1",
		ring2="Fenrir Ring +1",
        back=GEOCape.Indi,
		waist="Refoccilation Stone",
		legs="Amalric Slops",feet=MAB_feet}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		ear2="Gwati Earring",
		ring2="Adoulin Ring +1",
		waist="Refoccilation Stone",
		legs="Psycloth Lappas"})

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		ring2="Shiva Ring +1",
		back=GEOCape.Indi})
	
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
		ring2="Adoulin Ring +1"})
         
    sets.midcast['Dark Magic'] = {
		main=Weapons.MACC,
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
		neck="Erra Pendant",
		ear1="Gwati Earring",
		ear2="Barkarole Earring",
        body="Shango Robe",
		hands="Helios Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        cape=GEOCape.Indi,
		waist="Eschan Stone",
		legs="Amalric Slops",
		feet=MAB_feet}
     
    sets.midcast['Dark Magic']['Stun'] = set_combine(sets.midcast['Dark Magic'],{
        head="Nahtirah Hat",
		ring2="Sangoma Ring",
		waist="Witful Belt",
		legs="Psycloth Lappas"})
	--sets.midcast.Drain =  set_combine(sets.midcast.['Dark Magic'], { head="Bagua Galero +1"})
	--sets.midcast.Aspir =  set_combine(sets.midcast.['Dark Magic'], { head="Bagua Galero +1"})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1", 
		neck="Incanter's Torque", 
		hands="Helios Gloves", 
		ring1="Archon Ring", 
		ring2="Excelsis Ring",
		waist="Fucho-no-obi", 
		legs="Amalric Slops",
		feet=Mab_feet
	})
    
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast['Aspir III'] = sets.midcast.Drain
	 
    sets.midcast.Geomancy = {
		main=Weapons.GEO,
		sub="Culminus",		
		range="Dunna", 
		ammo=none,
		head=EMPY.Head,
		neck=RELIC.Neck,
		legs=RELIC.Legs,
		hands=AF.Hands,
		body=RELIC.Body, 
		back=GEOCape.Geo, 
		waist="Sekhmet Corset", 
		feet="Medium's Sabots"}
		
	sets.midcast['Indi-*'] = set_combine(sets.midcast.Geomancy, {
		main=Weapons.Indi,
		neck="Incanter's Torque",
		back=GEOCape.Indi,
		legs=RELIC.Legs, 
		feet=EMPY.Feet})
 
    sets.midcast.Cure = {
		main="Tamaxchi",
		sub="Sors Shield",
        head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Mendicant's earring",
		ear2="Loquacious Earring",
        body="Annointed Kalasiris",
		hands="Telchine Gloves",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
        back="Oretania's Cape +1",
		waist=gear.ElementalObi,
		legs="Psycloth Lappas",
		feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure
     sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast.Protectra = {ring1="Defending Ring"}
 
    sets.midcast.Shellra = {ring1="Defending Ring"}

    sets.midcast.Stun = {
		main=Weapons.MACC,
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",
		neck="Incanter's Torque",
		ear1="Barkarole Earring",
		ear2="Gwati Earring",
        body="Shango Robe",
		hands="Helios Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=GEOCape.Indi,
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Regal Pumps +1"}

 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {
		main="Boonwell Staff",
		sub="Niobid Strap",
		neck="Jeweled Collar", 
		ear2="Relaxing Earring",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1"}
 
 
    -- Idle sets
 
    sets.idle = {main="Bolelabunga",sub="Culminus",range="Dunna",
        head="Befouled Crown",neck=RELIC.Neck,ear1="Thureous Earring",ear2="Loquacious Earring",
        body=Salvage.Body,hands=RELIC.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet=AF.Feet}
 
    sets.idle.PDT = {main="Bolelabunga",sub="Genmei Shield",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands=RELIC.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Amalric Slops",feet=AF.Feet}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main=Weapons.GEO,sub="Culminus",range="Dunna",
        head=EMPY.Head,neck=RELIC.Neck,ear1="Handler's Earring",ear2="Loquacious Earring",
        body="Amalric Doublet",hands=RELIC.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=GEOCape.Geo,waist="Isa Belt",legs="Assiduity Pants +1",feet=RELIC.Feet}
 
    sets.idle.PDT.Pet = {main=Weapons.GEO,sub="Genmei Shield",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Handler's Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands=AF.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=GEOCape.Geo,waist="Isa Belt",legs="Assiduity Pants +1",feet=RELIC.Feet}
  
    sets.idle.Town = {main=Weapons.GEO,sub="Culminus",range="Dunna",
        head="Befouled Crown",neck=RELIC.Neck,ear1="Thureous Earring",ear2="Loquacious Earring",
        body=EMPY.Body,hands=RELIC.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=GEOCape.Geo,waist="Eschan Stone",legs="Assiduity Pants +1",feet=AF.Feet}
 
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",range="Dunna",
        neck="Sanctity Necklace",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands=RELIC.Hands,ring1="Defending Ring",ring2="Adoulin Ring +1",
        back=GEOCape.Geo,waist="Gishdubar Sash",legs="Assiduity Pants +1",feet=AF.Feet}
sets.idle.Weak.Pet = set_combine(sets.idle.Weak,{main=Weapons.GEO,sub="Genmei Shield"})

	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
	sets.idle.CP.Pet = set_combine(sets.idle.Pet,{back="Mecistopins Mantle"})
 	sets.idle.RR = set_combine(sets.idle.PDT,{body="Annointed Kalasiris"})

    -- Defense sets
 
    sets.Kiting = {feet=AF.Feet}
	 
    sets.defense.PDT = {main="Bolelabunga",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands=AF.Hands,ring1="Defending Ring",
        back=GEOCape.Geo,legs="Amalric Slops",feet=EMPY.Feet}
 
    sets.defense.MDT = {main="Bolelabunga",range="Dunna",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands=AF.Hands,ring1="Defending Ring",
        back=GEOCape.Geo,legs="Amalric Slops",feet=EMPY.Feet}
  
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    sets.magic_burst = {neck="Mizu. Kubikazari", ring2="Locus ring", ear2="Static Earring", back=GEOCape.Indi, ring1="mujin band",feet=MB_feet}
	sets.Seidr = {body="Seidr Cotehardie"}
	sets.Obi = {waist="Hachirin-no-Obi"}

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
        body="Amalric Doublet",hands=RELIC.Hands,ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back=GEOCape.Geo,waist="Cetl Belt",legs="Amalric Slops",feet="Battlecast Gaiters"}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
end
 
 
LowNukes = S{'Stone'}
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