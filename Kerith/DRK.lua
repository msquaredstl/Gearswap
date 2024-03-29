--[[     
=== Features ===
If you want auto Reive detection for Ygnas Resolve+1, and Gavialis Helm for some of your WS, then you will need my User-Globals.lua
Otherwise, you might be able to get away without it.  (not tested)

If you don't use organizer, then remove the include('organizer-lib') in get_sets() and remove sets.Organizer

This lua has a few MODES you can toggle with hotkeys or macros, and there's a few situational RULES that activate without hotkeys

::MODES::

SouleaterMode 
Status: OFF by default. 
Hotkey: Toggle this with @F9 (window key + F9). 
Macro: /console gs c togggle SouleaterMode

Notes: This mode makes it possible to use Souleater in situations where you would normally avoid using it. When SouleaterMode 
is ON, Souleater will be canceled automatically after the first Weaponskill used. CAVEAT -. If Bloodweapon 
is active, or if Drain's HP Boost buff is active, then Souleater will remain active until the next WS used after 
either buff wears off. 

CapacityMode
Status: OFF by default. 
Hotkey: with ALT + = 
Macro: /console cs c toggle CapacityMode

Notes: It will full-time whichever piece of gear you specify in sets.CapacityMantle 

Extra Info: You can change the default (true|false) status of any MODE by changing their values in job_setup()

::RULES::

Gavialis helm
Status: enabled
Setting: set use_gavialis = true below in job_setup. 

Notes: wslist defines weaponskills uused with Gavialis helm. This is a recent change Jan/2020, as it 
used to be the opposite, where you defined ws's that you didn't want to use it.

Ygna's Resolve +1 
Status: enabled in Reive
Setting: n/a

Notes: Will automatically be used when you're in a reive. If you have my User-Globals.lua this will work
with all your jobs that use mote's includes. Not just this one! 

Moonshade earring
Status: Not used for WS's at 3000 TP. 
Setting: n/a

You can hit F12 to display custom MODE status as well as the default stuff. 

Single handed weapons are handled in the sets.engaged.SW set. (sword + shield, etc.)

::NOTES::

My sets have a specific order, or they will not function correctly. 
sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]

CombatForm = Haste, DW, SW
CombatWeapon = GreatSword, Scythe, Apocalypse, Ragnarok, Caladbolg, Liberator, Anguta
OffenseMode = Mid, Acc
HybridMode = PDT
CustomMeleeGroups = AM3, AM, Haste
CustomClass = OhShit 

CombatForm Haste is used when Last Resort + Hasso AND either Haste, March, Indi-Haste Geo-Haste is on you.

CombatForm DW will activate with /dnc or /nin AND a weapon listed in drk_sub_weapons equipped offhand. 
SW is active with an empty sub-slot, or a shield listed in the shields = S{} list.  

CombatWeapon GreatSword will activate when you equip a GS listed in gsList in job_setup(). 
CombatWeapon Scythe will activate when you equip a Scythe listed in scytheList in job_setup(). 
Weapons that do not fall into these groups, or have sets by weapon name, will use default sets.engaged

most gear sets derrive themselves from sets.engaged, so try to keep it updated. It's much smarter to derrive sets than to 
completely re-invent each gear set for every weapon. Let your gear inherit. Less code written means less errors. 

CustomMeleeGroups AM3 will activate when Aftermath lvl 3 is up, and CustomMeleeGroups AM will activate when relic Aftermath is up.
There are no empy AM sets for now.

--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- Set the default to false if you'd rather SE always stay acitve
    state.SouleaterMode = M(true, 'Soul Eater Mode')
    -- state.LastResortMode = M(false, 'Last Resort Mode')
    -- Use Gavialis helm?
    use_gavialis = true

    -- Weaponskills you want Gavialis helm used with (only considered if use_gavialis = true)
    wsList = S{'Entropy', 'Resolution'}
    -- Greatswords you use. 
    gsList = S{'Malfeasance', 'Macbain', 'Kaquljaan', 'Mekosuchus Blade', 'Ragnarok', 'Raetic Algol', 'Raetic Algol +1', 'Caladbolg', 'Montante +1', 'Albion' }
    scytheList = S{'Liberator', 'Apocalypse', 'Anguta', 'Raetic Scythe', 'Deathbane', 'Twilight Scythe' }
    remaWeapons = S{'Apocalypse', 'Anguta', 'Liberator', 'Caladbolg', 'Ragnarok', 'Redemption'}

    shields = S{'Rinda Shield'}
    -- Mote has capitalization errors in the default Absorb mappings, so we use our own
    absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}
    -- Offhand weapons used to activate DW mode
    swordList = S{"Sangarius", "Sangarius +1", "Usonmunku", "Perun +1", "Tanmogayi"}

    get_combat_form()
    get_combat_weapon()
    update_melee_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'Sphere')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')

    war_sj = player.sub_job == 'WAR' or false

    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind !- gs equip sets.crafting')
    --send_command('bind ^` gs c toggle LastResortMode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
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
    -- Pillager
    AF.Head		=	"Ignominy Burgeonet +1"
    AF.Body		=	"Ignominy Cuirass +1"
    AF.Hands	=	"Ignominy Gauntlets +1"
    AF.Legs		=	"Ignominy Flanchard +1"
    AF.Feet		=	"Ignominy Sollerets +1"

    --Plunderer          
    RELIC.Head		=	"Fallen's Burgeonet +1"
    RELIC.Body		=	"Fallen's Cuirass +1"
    RELIC.Hands 	=	"Fallen's Finger Gauntlets +1"
    RELIC.Legs		=	"Fallen's Flanchard +3"
    RELIC.Feet		=	"Fallen's Sollerets +3"

    --Skulker
    EMPY.Head		=	"Heathen's Burgeonet +1"
    EMPY.Body		=	"Heathen's Cuirass +1"
    EMPY.Hands		=	"Heathen's Gauntlets +1"
    EMPY.Legs		=	"Heathen's Flanchard +2"
    EMPY.Feet		=	"Heathen's Sollerets +1"

	Salvage = {}
	Salvage.Head	=	"Sulevia's Mask +2"
	Salvage.Body	=	"Sulevia's Platemail +2"
	Salvage.Hands	=	"Sulevia's Gauntlets +2"
	Salvage.Legs 	=	"Sulevia's Cuisses +2"
	Salvage.Feet	=	"Sulevia's Leggings +2"
	Salvage.Ring	=	"Sulevia's Ring"

	Limbus = {}
	Limbus.Head		=	"Flamma Zucchetto +2"
	Limbus.Body		=	"Flamma Korazin +2"
	Limbus.Hands	=	"Flamma Manopolas +2"
	Limbus.Legs 	=	"Flamma Dirs +2"
	Limbus.Feet		=	"Flamma Gambieras +2"
	Limbus.Ring		=	"Flamma Ring"

    -- Capes:
    -- Sucellos's And such, add your own.

    -- Augmented gear
    Niht = {}
    Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+9','Dark magic skill +6'}}

    Ankou = {}
    --Ankou.FC  = { name="Ankou's Mantle", augments={'"Fast Cast"+10',}}
    --Ankou.STP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
    Ankou.DA  = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    --Ankou.WSD = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    --Ankou.VIT = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}

    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25','DEX+1','Weapon skill damage +7%','Accuracy+10 Attack+10',}}
    
    Odyssean.Feet = {}
    Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}
    

    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt"
     }
 
    sets.Organizer = {
        ear2="Reraise Earring",
        grip="Pearlsack",
        waist="Linkpearl",
        back=Niht.DarkMagic,
    }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {hands=RELIC.Hands}
    sets.precast.JA['Nether Void']  = {legs=EMPY.Legs}
    sets.precast.JA['Dark Seal']    = {head=RELIC.Head}
    sets.precast.JA['Souleater']    = {head=AF.Head}
    sets.precast.JA['Weapn Bash']   = {hands=AF.Hands}
    sets.precast.JA['Blood Weapon'] = {body=RELIC.Body}
    sets.precast.JA['Last Resort']  = {back=Ankou.WSD}
    sets.precast.JA['Jump'] = sets.Jump
    sets.precast.JA['High Jump'] = sets.Jump

    sets.Jump = { feet="Ostro Greaves" }

    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.WSBack          = { back="Trepidity Mantle" }
    
    -- Earring considerations, given Lugra's day/night stats 
    sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
    sets.IshvaraLugra     = { ear1="Ishvara Earring", ear2="Lugra Earring +1" }
    sets.Lugra           = { ear1="Lugra Earring +1" }
    sets.Brutal          = { ear1="Brutal Earring" }
    sets.Ishvara          = { ear1="Ishvara Earring" }

    -- Waltz set (chr and vit) 
    -- sets.precast.Waltz = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head=RELIC.Head,
        body=RELIC.Body,
        ear1="Malignance Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Kishar Ring",
        ring2="Weatherspoon Ring", -- 10 macc
        legs="Eschite Cuisses",
        back=Ankou.FC,
        feet=Odyssean.Feet.FC
    }
    sets.precast.FC['Drain'] = set_combine(sets.precast.FC, {
        feet="Ratri Sollerets +1" -- macc 33
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
        head="Cizin Helm +1",
        neck="Stoicheion Medal" 
    })
    sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
        head="Cizin Helm +1",
    })
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        -- body="Jumalik Mail",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head=RELIC.Head,
        back="Grounded Mantle +1",
        waist="Sailfi Belt +1",
        legs="Carmine Cuisses",
        ring2="Weatherspoon Ring", -- 10 macc
        feet=Odyssean.Feet.FC
    }
    -- sets.midcast.Trust =  {
    --     head=RELIC.Head,
    --     hands="Odyssean Gauntlets",
    --     body=RELIC.Body,
    --     legs="Carmine Cuisses",
    --     feet=Odyssean.Feet.FC
    -- }
    sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
        body="Apururu Unity shirt",
    })

    -- Specific spells
    sets.midcast.Utsusemi = {
        ammo="Impatiens",
        --head="Otomi Helm",
        neck="Incanter's Torque",
        body="Founder's Breastplate",
        hands="Leyline Gloves",
        back="Grounded Mantle +1",
        feet=Odyssean.Feet.FC
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum", 
        head=AF.Head, -- 19
        neck="Erra Pendant", -- 10 dark + 17 macc
        ear1="Malignance Earring",
        ear2="Dark Earring", -- 3
        body=RELIC.Body,
        hands=Limbus.Hands,
        waist="Casso Sash", -- 5
        ring1="Evanescence Ring", -- 10
        ring2="Archon Ring", 
        back=Niht.DarkMagic, -- 10
        legs=RELIC.Legs,  -- 18 + 39macc
        feet="Ratri Sollerets +1" -- macc 33
    }
    sets.midcast.Endark = set_combine(sets.midcast['Dark Magic'], {
        head=AF.Head,
        hands=RELIC.Hands
    })

    sets.midcast['Dark Magic'].Acc = set_combine(sets.midcast['Dark Magic'], {
        head="Ratri Sallet +1", -- 45 macc
        hands="Leyline Gloves",
        waist="Eschan Stone"
    })

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
        ammo="Pemphredo Tathlum", 
        head="Befouled Crown",
        neck="Erra Pendant", -- 10 + 17 macc
        body=AF.Body,
        hands=Limbus.Hands,
        ring1="Kishar Ring",
        ring2="Regal Ring", -- 10 macc
        waist="Eschan Stone",
        legs=RELIC.Legs,  -- 18 + 39macc
        back="Aput Mantle",
        feet=Limbus.Feet
    })

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Ratri Sallet +1", -- 45 macc
        neck="Eddy Necklace", -- 11 matk
        ear1="Malignance Earring",
        ear2="Friomisi Earring", -- 10 matk
        body=RELIC.Body,
        hands="Carmine Finger Gauntlets +1",
        ring1="Resonance Ring", -- int 8
        ring2="Regal Ring", -- matk 4
        waist="Eschan Stone", -- macc/matk 7
        legs="Eschite Cuisses", -- matk 25 
        back="Aput Mantle", -- mdmg 10
        feet="Founder's Greaves" -- matk 29
    }

    -- Mix of HP boost, -Spell interruption%, and Dark Skill
    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        ammo="Staunch Tathlum",
        neck="Sanctity Necklace",
        head="Ratri Sallet +1",
        ear1="Etiolation Earring",
        ear2="Infused Earring",
        body="Heathen's Cuirass +1",
        --body="Ratri Breastplate +1",
        hands="Ratri Gadlings +1",
        back="Trepidity Mantle",
        ring2="Regal Ring", -- matk 4
        waist="Eschan Stone",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"
    })
    sets.midcast['Dread Spikes'].Acc = set_combine(sets.midcast['Dark Magic'], {
        head="Ratri Sallet +1",
        body="Heathen's Cuirass +1",
        --hands=RELIC.Hands
    })

    -- Drain spells 
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head=RELIC.Head,
        ear1="Malignance Earring",
        ear2="Hirudinea Earring",
        ring2="Excelsis Ring",
        feet="Ratri Sollerets +1"
    })
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Drain.Acc = set_combine(sets.midcast.Drain, {
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })
    sets.midcast.Aspir.Acc = sets.midcast.Drain.Acc

    sets.midcast.Drain.OhShit = set_combine(sets.midcast.Drain, {
        legs="Carmine Cuisses",
        feet="Ratri Sollerets +1"
    })

    -- Absorbs
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        head=AF.Head, -- 17
        -- neck="Sanctity Necklace",
        -- back="Niht Mantle",
        -- hands=Limbus.Hands,
        back="Chuparrosa Mantle",
        hands="Pavor Gauntlets",
        ring1="Evanescence Ring", -- 10
        ring2="Kishar Ring",
    })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
        hands="Heathen's Gauntlets +1",
        ring1="Evanescence Ring", -- 10
        ring2="Kishar Ring",
    })

    sets.midcast['Absorb-TP'].Acc = set_combine(sets.midcast.Absorb.Acc, {
        hands="Heathen's Gauntlets +1",
        ring1="Evanescence Ring", -- 10
        ring2="Kishar Ring",
    })
    sets.midcast.Absorb.Acc = set_combine(sets.midcast['Dark Magic'].Acc, {
        head="Ratri Sallet +1",
        back="Chuparrosa Mantle",
        hands=Limbus.Hands,
        ring1="Evanescence Ring", -- 10
        ring2="Kishar Ring",
    })

    sets.midcast['Blue Magic'] = set_combine(sets.midcast['Dark Magic'], {
        ear2="Gwati Earring", -- 3
        waist="Eschan Stone", -- 5
        ring1="Sangoma Ring", -- 10
        ring2="Weatherspoon Ring", -- 10 macc
        back="Aput Mantle",
        legs=RELIC.Legs,  -- 18 + 39macc
        feet="Ratri Sollerets +1" -- macc 33
    })
    -- Ranged for xbow
    sets.precast.RA = {
        --head="Otomi Helm",
        --feet="Ejekamal Boots",
        hands="Carmine Finger Gauntlets +1"
    }
    sets.midcast.RA = {
        ear2="Tripudio Earring",
        ring1="Cacoethic Ring +1",
        waist="Chaac Belt",
    }

    -- WEAPONSKILL SETS
    -- General sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head=Limbus.Head,
        neck="Abyssal Bead Necklace +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        body=AF.Body,
        hands="Odyssean Gauntlets",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=Ankou.WSD,
        waist="Windbuffet Belt +1",
        legs=RELIC.Legs,
        feet=Salvage.Feet
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        legs=RELIC.Legs,
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        body=RELIC.Body,
        waist="Olseni Belt",
    })

    -- RESOLUTION
    -- 86-100% STR
    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        neck="Breeze Gorget",
        --body="Valorous Mail",
        hands=Salvage.Hands,
        waist="Soil Belt",
        legs=RELIC.Legs,
        feet=Salvage.Feet
    })
    sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
        head=Limbus.Head,
    })
    sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, {
        ammo="Seething Bomblet +1",
        legs=RELIC.Legs,
        feet=Salvage.Feet
    }) 

    -- TORCLEAVER 
    -- VIT 80%
    sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
        head="Odyssean Helm",
        body=AF.Body,
        neck="Abyssal Bead Necklace +2",
        waist="Light Belt",
        back=Ankou.VIT,
        legs=RELIC.Legs,
    })
    sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Torcleaver, {
        head=RELIC.Head,
        neck="Abyssal Bead Necklace +2",
    })
    sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, {
        body=RELIC.Body,
        legs=Odyssean.Legs.WS
    })

    -- INSURGENCY
    -- 20% STR / 20% INT 
    -- Base set only used at 3000TP to put AM3 up
    sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        neck="Abyssal Bead Necklace +2",
        --body="Ratri Breastplate +1",
        body=AF.Body,
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        ring2="Regal Ring",
        waist="Sailfi Belt +1",
        feet="Ratri Sollerets +1"
    })
    sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
        head="Ratri Sallet +1",
        waist="Light Belt",
    })
    sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
        ammo="Seething Bomblet +1",
        body=AF.Body,
    })

    sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {
        head="Ratri Sallet +1",
        ear2="Ishvara Earring",
        neck="Abyssal Bead Necklace +2",
        body=AF.Body,
        --body="Ratri Breastplate +1",
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        --waist="Soil Belt",
        waist="Sailfi Belt +1",
        feet="Ratri Sollerets +1"
    })
    sets.precast.WS.Catastrophe.Mid = set_combine(sets.precast.WS.Catastrophe, {})
    sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Catastrophe.Mid, {
        --body="Ratri Breastplate +1",
        waist="Olseni Belt",
    })

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS.Catastrophe, {
        head="Valorous Mask",
        feet=Salvage.Feet
    })

    -- CROSS REAPER
    -- 60% STR / 60% MND
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        body=AF.Body,
        --body="Ratri Breastplate +1",
        hands="Ratri Gadlings +1",
        waist="Metalsinger Belt",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"
    })
    sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS['Cross Reaper'], {

    })
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
        ammo="Seething Bomblet +1",
        body=RELIC.Body,
    })
    -- ENTROPY
    -- 86-100% INT 
    sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        neck="Abyssal Bead Necklace +2",
        body=AF.Body,
        ear1="Malignance Earring",
        waist="Soil Belt",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        legs=AF.Legs, -- 5% haste
        feet=Limbus.Feet
    })
    sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, {
        head="Hjarrandi Helm",
    })
    sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, {
        body=RELIC.Body,
        ammo="Seething Bomblet +1",
    })

    -- Quietus
    -- 60% STR / MND 
    sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
        head="Ratri Sallet +1",
        neck="Abyssal Bead Necklace +2",
        body=AF.Body,
        -- body="Ratri Breastplate +1",
        hands="Ratri Gadlings +1",
        waist="Caudata Belt",
        feet="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"
    })
    sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
    })
    sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, {
        body=RELIC.Body,
        ammo="Seething Bomblet +1",
        legs=Odyssean.Legs.WS
    })

    -- SPIRAL HELL
    -- 50% STR / 50% INT 
    sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
        neck="Abyssal Bead Necklace +2",
        body=AF.Body,
        legs=RELIC.Legs,  
        waist="Metalsinger belt",
    })
    sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid, { })
    sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc, { })

    -- SHADOW OF DEATH
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
        head="Pixie Hairpin +1",
        neck="Abyssal Bead Necklace +2",
        body=RELIC.Body,
        ear1="Friomisi Earring",
        hands="Carmine Finger Gauntlets +1",
        ring2="Archon Ring",
        back=Ankou.WSD,
        legs=RELIC.Legs,  
        feet="Ratri Cuisses +1",
        waist="Eschan Stone", -- macc/matk 7
        feet="Ratri Sollerets +1"
    })

    sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid, {
    })
    sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc, {
    })

    -- DARK HARVEST 
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Dark Harvest'] = sets.precast.WS['Shadow of Death']
    sets.precast.WS['Dark Harvest'].Mid = set_combine(sets.precast.WS['Shadow of Death'], {})
    sets.precast.WS['Dark Harvest'].Acc = set_combine(sets.precast.WS['Shadow of Death'], {})

    -- Sword WS's
    -- SANGUINE BLADE
    -- 50% MND / 50% STR Darkness Elemental
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        head="Pixie Hairpin +1",
        neck="Abyssal Bead Necklace +2",
        ear1="Friomisi Earring",
        body=RELIC.Body,
        hands="Founder's Gauntlets",
        ring1="Archon Ring",
        back=Ankou.WSD,
        feet="Heathen's Sollerets +1"
    })
    sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
    sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

    -- REQUISCAT
    -- 73% MND - breath damage
    sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
        head=Limbus.Head,
        neck="Abyssal Bead Necklace +2",
        body=AF.Body,
        hands="Odyssean Gauntlets",
        waist="Soil Belt",
    })
    sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
    sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=AF.Head,
        neck="Sanctity Necklace",
        ear1="Cessance Earring",
        ear2="Genmei Earring",
        body=AF.Body,
        hands=RELIC.Hands,
        ring1="Defending Ring",
        ring2="Adoulin Ring +1",
        back=Ankou.DA,
        waist="Flume belt",
        legs="Carmine Cuisses",
        feet=AF.Feet
    }
    sets.idle.Town = set_combine(sets.idle, {
        head=EMPY.Head,
        body=EMPY.Body,
        hands=RELIC.Hands,
        back=Ankou.DA,
        legs="Carmine Cuisses",
        feet=EMPY.Feet
    })

    sets.idle.Field = set_combine(sets.idle, { 
        head="Ratri Sallet +1"
    })
    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="",
        neck="Sanctity Necklace",
        body="Lugra Cloak +1",
        ear2="Infused Earring",
        ring1="Paguroidea Ring",
    })
    sets.idle.Refresh = set_combine(sets.idle.Regen, {
        head="Befouled Crown",
        body="Jumalik mail",
        neck="Coatl Gorget +1"
    })

    sets.idle.Weak = set_combine(sets.defense.PDT, {
        head="Hjarrandi Helm",
        neck="Sanctity Necklace",
        body="Tartarus Platemail",
        hands="Volte Moufles",
        ring1="Paguroidea Ring",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Flume Belt",
        legs=Salvage.Legs,
        feet="Volte Sollerets"
    })
    sets.idle.Sphere = set_combine(sets.idle, { body="Makora Meikogai"  })

    -- Defense sets
    sets.defense.PDT = {
        ammo="Hasty Pinion +1", -- 2% haste
        head="Hjarrandi Helm", -- no haste
        neck="Agitator's Collar",
        body=Salvage.Body, -- 1% haste
        hands="Volte Moufles",
        --ear1="Etiolation Earring",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        -- back="Grounded Mantle +1", -- 2% haste
        waist="Sailfi Belt +1", -- 9% haste
        -- legs=AF.Legs, -- 5% haste
        feet="Volte Sollerets" -- 3% haste
    }
    sets.defense.Reraise = sets.idle.Weak

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        head="Hjarrandi Helm", -- no haste
        neck="Twilight Torque",
        body="Tartarus Platemail",
        ear1="Etiolation Earring",
        back="Impassive Mantle",
    })

    sets.Kiting = {
        legs="Carmine Cuisses",
    }

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- sets.HighHaste = {
    --     ammo="Ginsen",
    --     head="Argosy Celata",
    -- }

    -- Defensive sets to combine with various weapon-specific sets below
    -- These allow hybrid acc/pdt sets for difficult content
    -- do not specify a cape so that DA/STP capes are used appropriately
    sets.Defensive = {
        --sub="Gracile grip",
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm", -- 10% dt
        neck="Agitator's Collar", -- 4% pdt
        body="Tartarus Platemail", -- 10% dt
        hands="Volte Moufles",
        ring1="Niqmaddu Ring", 
        ring2="Defending Ring", -- 10% dt
        waist="Sailfi Belt +1",
        feet="Volte Sollerets"  -- 4% pdt | 6% mdt
    }
    sets.Defensive_Mid = {
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm", -- no haste
        neck="Agitator's Collar", -- 4% pdt
        body="Tartarus Platemail",
        hands="Volte Moufles",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    }
    -- Higher DT, less haste
    sets.DefensiveHigh = set_combine(sets.Defensive, {
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm", -- no haste
        body=Limbus.Body,
        hands="Volte Moufles",
        ring1="Patricius Ring",
        ring2=Salvage.Ring,
        waist="Sailfi Belt +1",
        legs=Salvage.Legs, -- 7% dt
        feet="Volte Sollerets",
    })
    sets.Defensive_Acc = set_combine(sets.Defensive_Mid, sets.DefensiveHigh)

    -- Base set (global catch-all set)
    sets.engaged = {
        -- sub="Bloodrain Strap",
        ammo="Ginsen",
        head=Limbus.Head,
        neck="Lissome Necklace",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        body=Limbus.Body,
        hands=Limbus.Hands,
        ring1="Chirich Ring +1",
        ring2="Chirich Ring",
        back=Ankou.DA,
        waist="Cetl Belt",
        legs=Limbus.Legs,
        feet=Limbus.Feet
    }
    sets.engaged.Mid = set_combine(sets.engaged, {
		neck="Combatant's Torque",
        ear2="Telos Earring",
        ring2="Regal Ring",
        body="Valorous Mail"
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        -- ammo="Hasty Pinion +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        body=Limbus.Body,
        waist="Ioskeha Belt",
        back="Agema Cape",
    })

    -- These only apply when delay is capped.
    sets.engaged.Haste = set_combine(sets.engaged, {
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Mid = set_combine(sets.engaged.Mid, {
        waist="Sailfi Belt +1",
        --waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Acc = set_combine(sets.engaged.Acc, {})

    -- Hybrid
    sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

    -- Hybrid with capped delay
    sets.engaged.Haste.PDT = set_combine(sets.engaged.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Mid.PDT = set_combine(sets.engaged.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Acc.PDT = set_combine(sets.engaged.Acc.PDT, sets.DefensiveHigh)

    -- Liberator
    sets.engaged.Liberator = sets.engaged
    sets.engaged.Liberator.Mid = sets.engaged.Mid
    sets.engaged.Liberator.Acc = set_combine(sets.engaged.Acc, {
        body=Limbus.Body,
    })

    -- Liberator AM3
    sets.engaged.Liberator.AM3 = set_combine(sets.engaged.Liberator, {
        ammo="Ginsen",
        head=Limbus.Head,
        body="Valorous Mail",
        neck="Abyssal Bead Necklace +2",
        hands=Limbus.Hands,
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Niqmaddu Ring",
        ring2="Hetairoi Ring",
        back=Ankou.STP,
        waist="Sailfi Belt +1",
        legs=Odyssean.Legs.TP,
        feet="Valorous Greaves"
    })
    sets.engaged.Liberator.Mid.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        neck="Abyssal Bead Necklace +2",
        ear1="Cessance Earring",
        legs=Odyssean.Legs.TP,
    })
    sets.engaged.Liberator.Acc.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, {
        ammo="Seething Bomblet +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        body=Limbus.Body,
        ring2="Regal Ring",
        waist="Ioskeha Belt",
        legs=AF.Legs,
        feet=Limbus.Feet
    })
    sets.engaged.Haste.Liberator = set_combine(sets.engaged.Liberator, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Liberator.Mid = set_combine(sets.engaged.Liberator.Mid, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Liberator.Acc = sets.engaged.Liberator.Acc
    
    sets.engaged.Haste.Liberator.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Liberator.Mid.AM3 = sets.engaged.Liberator.Mid.AM3
    sets.engaged.Haste.Liberator.Acc.AM3 = sets.engaged.Liberator.Acc.AM3
    
    -- Hybrid
    sets.engaged.Liberator.PDT = set_combine(sets.engaged.Liberator, {
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm",
        body="Tartarus Platemail",
        neck="Abyssal Bead Necklace +2",
        hands="Volte Moufles",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    })
    sets.engaged.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.PDT, {
        ear1="Cessance Earring",
    })
    sets.engaged.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc, sets.DefensiveHigh)
    -- Hybrid with AM3 up
    sets.engaged.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.AM3, sets.Defensive)
    sets.engaged.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, sets.Defensive_Mid)
    sets.engaged.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.AM3, sets.DefensiveHigh)
    -- Hybrid with capped delay
    sets.engaged.Haste.Liberator.PDT = set_combine(sets.engaged.Liberator.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    sets.engaged.Haste.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.PDT.AM3, sets.Defensive)
    sets.engaged.Haste.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.PDT.AM3, sets.Defensive_Mid)
    sets.engaged.Haste.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.PDT.AM3, sets.DefensiveHigh)

    -- Apocalypse
    sets.engaged.Apocalypse = set_combine(sets.engaged, {
        --ear1="Cessance Earring",
        --ear2="Brutal Earring",
        --body="Valorous Mail",
        --hands=Salvage.Hands,
        --ring2="Petrov Ring",
        --back=Ankou.DA
    })
    sets.engaged.Apocalypse.Mid = set_combine(sets.engaged.Mid, {
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring2=Limbus.Ring,
        hands=Salvage.Hands,
        back=Ankou.DA
    })
    sets.engaged.Apocalypse.Acc = set_combine(sets.engaged.Acc, {
        ammo="Seething Bomblet +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        body=Limbus.Body,
        ring2="Regal Ring",
        hands=Salvage.Hands,
        back=Ankou.DA
    })
    
    -- sets.engaged.Apocalypse.AM = set_combine(sets.engaged.Apocalypse, {})
    -- sets.engaged.Apocalypse.Mid.AM = set_combine(sets.engaged.Apocalypse.AM, {})
    -- sets.engaged.Apocalypse.Acc.AM = set_combine(sets.engaged.Apocalypse.Mid.AM, {
    --     ring2="Cacoethic Ring +1",
    --     waist="Ioskeha Belt"
    -- })
    sets.engaged.Haste.Apocalypse = set_combine(sets.engaged.Apocalypse, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Apocalypse.Mid = sets.engaged.Apocalypse.Mid
    sets.engaged.Haste.Apocalypse.Acc = sets.engaged.Apocalypse.Acc

    -- Hybrid
    sets.engaged.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse, {
        --head="Hjarrandi Helm",
        --neck="Abyssal Bead Necklace +2",
        --body="Tartarus Platemail",
        --hands="Volte Moufles",
        ring2="Defending Ring",
        --back=Ankou.DA,
        --waist="Sailfi Belt +1",
        --feet="Volte Sollerets" 
    })
    sets.engaged.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    sets.engaged.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with relic AM 
    -- sets.engaged.Apocalypse.PDT.AM = set_combine(sets.engaged.Apocalypse, sets.Defensive)
    -- sets.engaged.Apocalypse.Mid.PDT.AM = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    -- sets.engaged.Apocalypse.Acc.PDT.AM = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with capped delay
    sets.engaged.Haste.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    -- sets.engaged.Haste.Apocalypse.PDT.AM3 = set_combine(sets.engaged.Apocalypse.PDT.AM3, sets.DefensiveHigh)
    -- sets.engaged.Haste.Apocalypse.Mid.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Mid.PDT.AM3, sets.DefensiveHigh)
    -- sets.engaged.Haste.Apocalypse.Acc.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Acc.PDT.AM3, sets.DefensiveHigh)

    -- generic scythe
    sets.engaged.Scythe = set_combine(sets.engaged, {})
    sets.engaged.Scythe.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.Scythe.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
    sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
    sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.Scythe = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.Scythe.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.Scythe.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.Scythe.PDT = set_combine(sets.engaged.Scythe.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc.PDT, sets.DefensiveHigh)

    -- generic great sword
    sets.engaged.GreatSword = set_combine(sets.engaged, {
        hands=Limbus.Hands
    })
    sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
        body=Limbus.Body,
        legs=AF.Legs,
    })

    sets.engaged.GreatSword.PDT = set_combine(sets.engaged.GreatSword, sets.Defensive)
    sets.engaged.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid, sets.Defensive_Mid)
    sets.engaged.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.GreatSword = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.GreatSword.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.GreatSword.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.GreatSword.PDT = set_combine(sets.engaged.GreatSword.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc.PDT, sets.DefensiveHigh)

    -- Ragnarok
    sets.engaged.Ragnarok = set_combine(sets.engaged.GreatSword, {})
    sets.engaged.Ragnarok.Mid = set_combine(sets.engaged.GreatSword.Mid, {})
    sets.engaged.Ragnarok.Acc = set_combine(sets.engaged.GreatSword.Acc, {})
    
    sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, sets.Defensive)
    sets.engaged.Ragnarok.Mid.PDT = set_combine(sets.engaged.Ragnarok.Mid, sets.Defensive_Mid)
    sets.engaged.Ragnarok.Acc.PDT = set_combine(sets.engaged.Ragnarok.Acc, sets.Defensive_Acc)
    
    -- Caladbolg
    sets.engaged.Caladbolg = set_combine(sets.engaged.GreatSword, {
        hands=Salvage.Hands,
        body="Valorous Mail",
        back=Ankou.DA
    })
    sets.engaged.Caladbolg.Mid = set_combine(sets.engaged.GreatSword.Mid, {
        hands=Salvage.Hands,
        ear2="Telos Earring",
        ring2="Regal Ring",
        back=Ankou.DA
    })
    sets.engaged.Caladbolg.Acc = set_combine(sets.engaged.GreatSword.Acc, {
        ammo="Seething Bomblet +1",
        hands=Limbus.Hands,
        body=Limbus.Body,
        legs=AF.Legs,
        back=Ankou.DA
    })
    
    sets.engaged.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg, sets.Defensive)
    sets.engaged.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid, sets.Defensive_Mid)
    sets.engaged.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc, sets.Defensive_Acc)
    
    sets.engaged.Haste.Caladbolg = set_combine(sets.engaged.Caladbolg, { 
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Caladbolg.Mid = set_combine(sets.engaged.Caladbolg.Mid, {
        hands=Salvage.Hands,
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Caladbolg.Acc = set_combine(sets.engaged.Caladbolg.Acc, {
        hands=Salvage.Hands,
    })

    sets.engaged.Haste.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc.PDT, sets.DefensiveHigh)
    
    -- dual wield
    sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        hands="Emicho Gauntlets",
        waist="Patentia Sash",
        legs="Carmine Cuisses",
    })
    sets.engaged.DW.Mid = set_combine(sets.engaged.DW, {
        neck="Abyssal Bead Necklace +2",
    })
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW.Mid, {
        ear2="Telos Earring",
    })

    -- single wield (sword + shield possibly)
    sets.engaged.SW = set_combine(sets.engaged, {
        ammo="Yetshila",
    })
    sets.engaged.SW.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.SW.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Reraise = set_combine(sets.engaged, {
        head="Twilight Helm",
        neck="Twilight Torque",
        body="Twilight Mail"
    })

    sets.buff.Souleater = { 
        head=AF.Head,
        --body="Ratri Breastplate",
    }
    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
    -- sets.buff['Last Resort'] = { 
    --     feet=RELIC.Feet 
    -- }
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    local recast = windower.ffxi.get_ability_recasts()
    -- Make sure abilities using head gear don't swap 
    if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        --if use_gavialis then
        --    if is_sc_element_today(spell) then
        --        if wsList:contains(spell.english) then
        --            equip(sets.WSDayBonus)
        --        end
        --    end
        --end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end

        -- if spell.english == 'Entropy' and recast[95] == 0 then
        --     eventArgs.cancel = true
        --     send_command('@wait 4.0;input /ja "Consume Mana" <me>')
        --     --windower.chat.input:schedule(1, '/ws "Entropy" <t>')
        --     return
        -- end
        if spell.english == 'Insurgency' then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            end
        end

        -- if player.tp > 2999 then
        --     if wsList:contains(spell.english) then
        --         equip(sets.IshvaraLugra)
        --     else
        --         equip(sets.BrutalLugra)
        --     end
        -- else -- use Lugra + moonshade
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         equip(sets.Lugra)
        --     else
        --         if wsList:contains(spell.english) then
        --             equip(sets.Ishvara)
        --         else
        --             equip(sets.Brutal)
        --         end
        --     end
        -- end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Drain') then
        if player.status == 'Engaged' and state.CastingMode.current == 'Normal' and player.hpp < 70 then
            classes.CustomClass = 'OhShit'
        end
    end

    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('@wait 1.0;cancel souleater')
            --enable("head")
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 50 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    elseif player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.idle.Refresh)
    end
    if state.IdleMode.current == 'Sphere' then
        idleSet = set_combine(idleSet, sets.idle.Sphere)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Souleater'] then
        meleeSet = set_combine(meleeSet, sets.buff.Souleater)
    end
    --meleeSet = set_combine(meleeSet, select_earring())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        --if state.Buff['Last Resort'] then
        --    send_command('@wait 1.0;cancel hasso')
        --end
        -- handle weapon sets
    if remaWeapons:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
        -- if gsList:contains(player.equipment.main) then
        --     state.CombatWeapon:set("GreatSword")
        -- elseif scytheList:contains(player.equipment.main) then
        --     state.CombatWeapon:set("Scythe")
        -- elseif remaWeapons:contains(player.equipment.main) then
        --     state.CombatWeapon:set(player.equipment.main)
        -- else -- use regular set, which caters to Liberator
        --     state.CombatWeapon:reset()
        -- end
        --elseif newStatus == 'Idle' then
        --    determine_idle_group()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end

    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    if S{'haste', 'march', 'embrava', 'geo-haste', 'indi-haste', 'last resort'}:contains(buff:lower()) then
        if (buffactive['Last Resort']) then
            if (buffactive.embrava or buffactive.haste) and buffactive.march then
                state.CombatForm:set("Haste")
                if not midaction() then
                    handle_equipping_gear(player.status)
                end
            end
        else
            if state.CombatForm.current ~= 'DW' and state.CombatForm.current ~= 'SW' then
                state.CombatForm:reset()
            end
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    -- Drain II/III HP Boost. Set SE to stay on.
    -- if buff == "Max HP Boost" and state.SouleaterMode.value then
    --     if gain or buffactive['Max HP Boost'] then
    --         state.SouleaterMode:set(false)
    --     else
    --         state.SouleaterMode:set(true)
    --     end
    -- end
    -- Make sure SE stays on for BW
    if buff == 'Blood Weapon' and state.SouleaterMode.value then
        if gain or buffactive['Blood Weapon'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- AM custom groups
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Liberator' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------Mythic AM3 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomMeleeGroups:clear()

            if buff == "Aftermath" and gain or buffactive.Aftermath then
                classes.CustomMeleeGroups:append('AM')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    
    -- if  buff == "Samurai Roll" then
    --     classes.CustomRangedGroups:clear()
    --     if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
    --         classes.CustomRangedGroups:append('SamRoll')
    --     end
       
    -- end

    --if buff == "Last Resort" then
    --    if gain then
    --        send_command('@wait 1.0;cancel hasso')
    --    else
    --        if not midaction() then
    --            send_command('@wait 1.0;input /ja "Hasso" <me>')
    --        end
    --    end
    --end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

    war_sj = player.sub_job == 'WAR' or false
    get_combat_form()
    get_combat_weapon()
    update_melee_groups()
    select_default_macro_book()
end

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
--function th_action_check(category, param)
--    if category == 2 or -- any ranged attack
--        --category == 4 or -- any magic action
--        (category == 3 and param == 30) or -- Aeolian Edge
--        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
--        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
--        then 
--            return true
--    end
--end
-- function get_custom_wsmode(spell, spellMap, default_wsmode)
--     if state.OffenseMode.current == 'Mid' then
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3Mid'
--         end
--     elseif state.OffenseMode.current == 'Acc' then
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3Acc'
--         end
--     else
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3'
--         end
--     end
-- end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()

    if S{'NIN', 'DNC'}:contains(player.sub_job) and swordList:contains(player.equipment.main) then
        state.CombatForm:set("DW")
    --elseif player.equipment.sub == '' or shields:contains(player.equipment.sub) then
    elseif swordList:contains(player.equipment.main) then
        state.CombatForm:set("SW")
    elseif buffactive['Last Resort'] then
        if (buffactive.embrava or buffactive.haste) and buffactive.march then
            add_to_chat(8, '-------------Delay Capped-------------')
            state.CombatForm:set("Haste")
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:reset()
    end
end

function get_combat_weapon()
    state.CombatWeapon:reset()
    if remaWeapons:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
    -- if remaWeapons:contains(player.equipment.main) then
    --     state.CombatWeapon:set(player.equipment.main)
    -- elseif gsList:contains(player.equipment.main) then
    --     state.CombatWeapon:set("GreatSword")
    -- elseif scytheList:contains(player.equipment.main) then
    --     state.CombatWeapon:set("Scythe")
    -- end
end

function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local mythic_ws = "Insurgency"

        info.aftermath.weaponskill = mythic_ws
        info.aftermath.duration = 0

        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == mythic_ws and player.equipment.main == 'Liberator' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            if info.aftermath.level == 1 then
                info.aftermath.duration = 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
        info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.CombatForm.current ~= '' then 
        msg = msg .. ', Form: ' .. state.CombatForm.current 
    end
    if state.CombatWeapon.current ~= '' then 
        msg = msg .. ', Weapon: ' .. state.CombatWeapon.current 
    end
    if state.CapacityMode.value then
        msg = msg .. ', Capacity: ON, '
    end
    if state.SouleaterMode.value then
        msg = msg .. ', SE Cancel, '
    end
    -- if state.LastResortMode.value then
    --     msg = msg .. ', LR Defense, '
    -- end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Dark Magic' and absorbs:contains(spell.english) then
        return 'Absorb'
    end
    -- if spell.type == 'Trust' then
    --     return 'Trust'
    -- end
end

function select_earring()
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.Lugra
    else
        return sets.Brutal
    end
end

function update_melee_groups()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Liberator' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        -- relic AM
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
        -- if buffactive['Samurai Roll'] then
        --     classes.CustomRangedGroups:append('SamRoll')
        -- end
    end
end

function select_default_macro_book()
    -- Default macro set/book
        -- set_macro_page(5, 4)
    -- if player.sub_job == 'DNC' then
    --     set_macro_page(8, 4)
    if scytheList:contains(player.equipment.main) then
        set_macro_page(1, 4)
    elseif gsList:contains(player.equipment.main) then
        set_macro_page(5, 4)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 4)
    else
        set_macro_page(7, 4)
    end
end
