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
    state.IdleMode:options('Normal','CP', 'PDT','HighMP','RR')
	state.VorsealMode = M('Normal', 'Vorseal')
	state.ManawallMode = M('Swaps', 'No_Swaps')
	state.Enfeebling = M('None', 'Effect')
	--Vorseal mode is handled simply when zoning into an escha zone--
    state.Moving  = M(false, "moving")
    
	element_table = L{'Earth','Wind','Ice','Fire','Water','Lightning'}

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	--	HighTierNuke = S{'Stone IV', 'Stone V', 'Stone VI','Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water IV', 'Water V', 'Water VI', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet'}
   
   degrade_array = {
		['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
		['Firega'] = {'Firaga','Firaga II','Firaga III','Firaja'},
		['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
		['Icega'] = {'Blizzaga','Blizzaga II','Blizzaga III','Blizzaja'},
		['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
		['Windga'] = {'Aeroga','Aeroga II','Aeroga III','Aeroja'},
		['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
		['Earthga'] = {'Stonega','Stonega II','Stonega III','Stoneja'},
		['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
		['Lightningga'] = {'Thundaga','Thundaga II','Thundaga III','Thundaja'},
		['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V','Water VI'},
		['Waterga'] = {'Waterga','Waterga II','Waterga III','Waterja'},
		['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
		['Sleepgas'] = {'Sleepga','Sleepga II'}
	}
   
    -- Additional local binds
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f11 gs c cycle CastingMode')
	send_command('bind ^f11 gs c cycle Enfeebling')
	send_command('bind f12 gs c cycle ManawallMode')
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^end gs c toggle MagicBurst')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')

    select_default_macro_book()
	

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind ^`f11')
	send_command('unbind f12')
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
    AF.Head		=	""
    AF.Body		=	"Spaekona's Coat +2"
    AF.Hands	=	"Spaekona's Gloves +1"
    AF.Legs		=	""
    AF.Feet		=	""

    --Vitiation
    RELIC.Head		=	"Archmage's Petasos +1"
    RELIC.Body		=	"Archmage's Coat +3"
    RELIC.Hands 	=	"Archmage's Gloves +1"
    RELIC.Legs		=	"Archmage's Tonban +2"
    RELIC.Feet		=	"Archmage's Sabots +1"

    --Lethargy
    EMPY.Head		=	"Wicce Petasos +1"
    EMPY.Body		=	"Wicce Coat +1"
    EMPY.Hands		=	"Wicce Gloves +1"
    EMPY.Legs		=	"Wicce Tonban +1"
    EMPY.Feet		=	"Wicce Sabots +1"

	Salvage = {}
	Salvage.Head	=	"Jhakri Coronal +1"
	Salvage.Body	=	"Jhakri Robe +2"
	Salvage.Hands	=	"Jhakri Cuffs +1"
	Salvage.Legs 	=	"Jhakri Slops +1"
	Salvage.Feet	=	"Jhakri Pigaches +1"

	Limbus = {}
	Limbus.Head		=	"Mallquis Chapeau"
	Limbus.Body		=	"Mallquis Saio"
	Limbus.Hands	=	"Mallquis Cuffs"
	Limbus.Legs 	=	"Mallquis Trews"
	Limbus.Feet		=	"Mallquis Clogs"
	
    -- Capes:
    -- Sucellos's And such, add your own.
    BLMCape = {}
    BLMCape.FreeNuke	=	{ name="Taranus's Cape" }


	Weapons = {}

		Weapons.FreeNuke = {name="Lathi"}
		Weapons.MACC = {}
		Weapons.MB = {}

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
	
	DarkRing={name="Archon Ring"}

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=BLMCape.FreeNuke,feet=EMPY.Feet}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
		main="Grioavolr",
		sub="Niobid Strap",
		ammo="Sapience Orb",
        head={name="Merlinic Hood", priority=2},
		neck="Orunmila's Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Shango Robe",
		hands="Helios Gloves",
		ring1="Prolix Ring",
		ring2="Lebeche Ring",
        back="Perimede Cape",
		waist="Witful Belt",
		legs={name="psycloth lappas", priority=1}, 
		feet="Regal Pumps +1"
		}

	sets.precast.FC.DeathMB = set_combine(sets.precast.FC, {
		ammo="Psilomene", 
		ear1={Earrings.FreeNuke, priority=4},
		body="Merlinic Jubbah", 
		hands={name="Otomi gloves", priority=7}, 
		ring1="Sangoma ring",
		ring2={name="Mephitas's ring +1", priority=9}, 
		back={name=BLMCape.MACC, priority=6},
		legs="Psycloth Lappas", 
		feet={name="MAB_Feet", priority=8}})
		
	sets.precast.FC.Aspir = sets.precast.FC.Death	

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {feet="Tutyr Sabots"})

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head="Vanya Hood",
		ear1="Mendicant's earring",
		back="Pahtli Cape",
		feet="Vanya Clogs"})

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
        head="Merlinic Hood",neck="Sanctity Necklace",ear1=Earrings.FreeNuke,ear2=Earrings.FreeNuke2,
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Adoulin Ring +1",
        back="Toro Cape",waist="Thunder Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		-- Increase Max MP
     sets.precast.WS['Myrkr'] = {ammo="Kalboron Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1=Earrings.FreeNuke,ear2=Earrings.TP,
        body="Amalric Doublet",hands="Helios Gloves",ring1="Sangoma Ring",ring2="Mephitas's ring +1",
        back="Taranus's Cape",waist="Fucho-no-obi",legs="Psycloth Lappas",feet="Medium's Sabots"}
   
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",neck="Orunmila's Torque",
        body="Shango Robe",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas"}

    sets.midcast.Cure = {
		main="Tamaxchi",
		sub="Sors Shield",
		ammo="Kalboron Stone",
        head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Mendicant's earring",
		ear2="Loquacious Earring",
        body="Annointed Kalasiris",
		hands="Telchine Gloves",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
        back="Oretania's Cape",
		waist=gear.ElementalObi,
		legs="Psycloth Lappas",
		feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = { 
		head="Befouled Crown", 
		neck="Incanter's Torque",
		body="Vanya Robe",
		feet="Regal Pumps +1" }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear1="Earthcry Earring", waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {feet="Inspirited Boots"})

    sets.midcast['Enfeebling Magic'] = {main=Weapons.FreeNuke,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Incanter's Torque",ear1=Earrings.FreeNuke,ear2="Gwati Earring",
        body="Vanya Robe",hands="Helios Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=BLMCape.FreeNuke,legs="Psycloth Lappas",feet="Medium's Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main=Weapons.FreeNuke,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1=Earrings.FreeNuke,ear2="Gwati Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back=BLMCape.FreeNuke,waist="Goading Belt",legs="Psycloth Lappas",feet=EMPY.Feet}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1", 
		neck="Incanter's Torque", 
		hands="Helios Gloves", 
		ring1="Archon Ring", 
		ring2="Excelsis Ring",
		back=BLMCape.FreeNuke, 
		waist="Fucho-no-obi", 
		legs="Amalric Slops",
		feet=Mab_feet
	})
    
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast['Aspir III'] = sets.midcast.Drain

	sets.midcast.Stun = {
		main=Weapons.FreeNuke,
		sub="mephitis grip",
		ammo="Impatiens",
		head="Nahtirah Hat",
		neck="orunmilia torque",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
		body="Merlinic Jubbah",
		hands="Yaoyotl Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=BLMCape.FreeNuke,
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="regal pumps +1"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main=Weapons.FreeNuke,
		sub="Zuuxowu Grip",
		ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
		neck=Necklace.FreeNuke,
		ear1="Barkarole Earring",
		ear2="Friomisi Earring",
        body="Merlinic Jubbah",
		hands="Amalric Gages",
		ring1="Shiva Ring +1",
		ring2="Fenrir Ring +1",
        back=BLMCape.FreeNuke,
		waist="Refoccilation Stone",
		legs=RELIC.Legs,
		feet=Mab_feet}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		sub="Niobid Strap", 
		neck=Necklace.MACC,
		ear2="Gwati Earring",
		legs="Psycloth Lappas"
	})

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
	sub="Alber Strap",ring2="Shiva Ring +1"})
    
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {ring2="Adoulin Ring +1"})

	sets.midcast.Death = {
		Ammo="Ghastly Tathlum +1", 
		head={name="Pixie Hairpin +1", priority=3}, 
		neck=Necklace.MB, 
		ear1="Barkarole Earring", 
		ear2="Static Earring",
		body={name="Merlinic Jubbah", priority=2}, 
		hands="Amalric Gages", 
		ring2={name="Mephitas's Ring +1", priority=4}, 
		ring1="Archon Ring",
		back=BLMCape.FreeNuke, 
		waist="Hachirin-no-Obi", 
		legs=RELIC.Legs, 
		feet={name=MAB_Feet, priority=5}}
	 
	sets.midcast.Comet = set_combine(sets.midcast.Death,{
						 Ammo="Pemphredo Tathlum", ring1="Mujin Band", legs="Merlinic Shalwar"})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Boonwell Staff",neck="Jeweled Collar", ear1="Barkarole Earring", ear2="Relaxing Earring",
        ring1="Star Ring",waist="Hierarch Belt",legs="Assiduity Pants +1"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi", sub="Zuuxowu Grip",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=Salvage.Body,hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Taranus's Cape",
		waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Amalric Gages",ring1="Defending Ring",ring2=DarkRing,
        back="Umbra Cape",waist="Fucho-no-obi",legs="Hagondes Pants",feet="Battlecast Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Amalric Gages",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Battlecast Gaiters"}
    
    -- Town gear.
    sets.idle.Town = set_combine(sets.idle,{})
        
	sets.idle.HighMP = set_combine(sets.precast.FC.DeathMB,{sub="Niobid Strap",ammo="Psilomene", head="Merlinic Hood"})
	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
	sets.idle.RR = set_combine(sets.idle,{body="Annointed Kalasiris"})
	
    -- Defense sets

    sets.defense.PDT = { head="Hagondes Hat +1",neck="Loricate Torque +1",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2=DarkRing,
        back="Umbra Cape",waist="Hierarch Belt",legs="Amalric Slops", feet="Battlecast Gaiters"}
    
    sets.defense.MDT = {ammo="Demonry Stone",
        head="Hagondes hat +1",neck="Loricate Torque +1",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Psycloth Lappas",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet=EMPY.Feet}

    sets.magic_burst = {
		neck=Necklace.MB, 
		ring2="Locus ring", 
		ear2="Static Earring", 
		ring2="mujin band", 
		legs=RELIC.Legs,
		feet=Mb_feet
	}
	
	sets.Seidr = {body=AF.Body}
	sets.Obi = {back="Twilight Cape", waist="Hachirin-no-Obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Hasty Pinion +1",
        head="Befouled Crown",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Hagondes Cuffs +1",ring1="Adoulin Ring +1",ring2="Rajas Ring",
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

function job_post_precast(spell, action, spellMap, eventArgs)
	if player.mp > 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC)
	elseif player.mp > 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC)
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
    if buffactive['Mana Wall'] then
        enable('feet','back')
        equip(sets.buff['Mana Wall'])
        disable('feet','back')
    end
    --if not spell.interrupted then
    --    if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
    --        send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
    --        send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Break" or spell.english == "Breakga" then -- Break Countdown --
    --        send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Paralyze" then -- Paralyze Countdown --
    --         send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Slow" then -- Slow Countdown --
    --        send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')        
    --    end
    --end
	--if buffactive['poison'] then
	--send_command('input /item "antidote" <me>')
	--end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--if buff == "poison" and gain then
	--send_command('input /item "antidote" <me>')
	--end
	if buff == "Vorseal" then
	send_command('gs c cycle VorsealMode')
	elseif buff == "Vorseal" and not gain then
	send_command('gs c cycle VorsealMode')
	end
	if buff == "Visitant" then
	send_command('gs l blm3.lua')
	end
    -- Unlock feet when Mana Wall buff is lost.
	if buff == "Mana Wall" then
	send_command('wait 0.5;gs c update')
	end
    if buff == "Mana Wall" and not gain then
        enable('feet','back')
        handle_equipping_gear(player.status)
    end
    if buff == "Commitment" and not gain then
        equip({ring2="Capacity Ring"})
        if player.equipment.right_ring == "Capacity Ring" then
            disable("ring2")
        else
            enable("ring2")
        end
    end
	if buff == "Vorseal" and gain then
	send_command('input //setbgm 75')
	elseif buff == "Vorseal" and not gain then
	send_command('input //setbgm 251')
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