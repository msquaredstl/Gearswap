-- Thank you to Fujilives, Vafruvant, and Carrotchan for help with this Gearswap!
 
--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, TP sets: TP--
--Requiescat sets: Req, Chant du Cygne sets: CDC, Expiacion sets: Expi, Savage Blade sets: Savage--
--Realm, FlashNova--
 
--E.g.   /console gs c toggle CDC set--
--              /console gs c toggle TP set--
--                              Reqi, etc, read at the bottom of the GS in the toggles for the names
 
--Overall just make good use of keybinds
---- ^ is the cntrl and ! is the alt key
 
 
 
 
-- EEAdded some echo commands as well - so you know you actually pressed the button even if the function you call with GS c fails.
send_command('bind f9           input /echo TP SET;     gs c toggle TP set')
send_command('bind f10          input /echo CDC SET;    gs c toggle CDC set')
send_command('bind f11          input /echo Req SET;    gs c toggle Req set')
send_command('bind f12          input /echo Idle SET;   gs c toggle Idle set')
send_command('bind ^f9          input /echo WS CDC;             gs input /ws "Chant du Cygne" <t>')
send_command('bind ^f10         input /echo WS EXP;             gs input /ws "Expiacion" <t>')
send_command('bind ^f11         input /echo WS SNG;             gs input /ws "Sanguine Blade" <t>')
send_command('bind ^f12         input /echo WS REQ;             gs input /ws "Requiescat" <t>')
send_command('bind !f10         input /echo RRZ SET;    gs c toggle Rea set')
send_command('bind !f12         input /echo DATCOAT;    gs c toggle Thaumas Coat')
 
add_to_chat(122, 'F9=TP / F10=TCDC / F11=TReq <rawr> / F12=TIdle \ Ctrl9=CDC \ Ctrl10=Expi \ Ctrl11=Sanguine \ Ctrl12=Req / Alt+F9=WSRealm / Alt+F10=TRealm / Alt+F12=TogThaumaus')
 
function file_unload()
        send_command('unbind ^f9')
        send_command('unbind ^f10')
        send_command('unbind ^f11')
        send_command('unbind ^f12')
 
        send_command('unbind !f9')
        send_command('unbind !f10')
        send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
end
 
--TrustsNPCs, IGNORE this part, experimenting with something that didn't work
function maps()
        TrustNPCs = S{          'Abenzio','Adelheid','Ajido-Marujido','Aldo','Amchuchu',                                        'Apururu','Arciela','Areuhat','Ayame',
                                                'Babban','Brygid','Chacharoon','Cherukiki','Cid','Curilla','D.Shantotto','Elivira','Excenmille',
                                                'Fablinix','FerreousCoffin','Gadalar','Gessho','Gilgamesh','Halver','Ingrid','IronEater','Joachim',
                                                'Karaha-Baruha','Kayeel-Payeel','Klara','Koru-Moru','Kukki-Chebukki','Kupipi','Kupofried','KuyinHathdenna',
                                                'LehkoHabhoka','Leonoyne','LheLhangavo','LhuMhakaracca','Lilisette','Lion','Luzaf','Maat','Margret','Maximilian','Mayakov',
                                                'MihliAliapoh','Mildaurion','Mnejing','Moogle','Mumor','NajaSalaheem','Najelith','Naji','NanaaMihgo',
                                                'Nashmeira','Noillurie','Ovjang','Prishe','Qultada','Rahal','Rainemard','RomaaMihgo','Ronguelouts',
                                                'Rughadjeen','Sakura','SemihLafihna','Shantotto','StarSibyl','Tenzen','Trion','UkaTotlihn','Ulmia',
                                                'Valaineral','Volker','Zazarg','Zeid'}
 
        PhysicalSpells = S{     'Asuran Claws','Bludgeon','Body Slam','Feather Storm',                                        'Mandibular Bite','Queasyshroom',
                                                'Power Attack','Ram Charge','Saurian Slide','Screwdriver','Sickle Slash','Smite of Rage',
                                                'Spinal Cleave','Spiral Spin','Sweeping Gouge','Terror Touch','Battle Dance','Bloodrake',
                                                'Death Scissors','Dimensional Death','Empty Thrash','Quadrastrike','Uppercut','Tourbillion',
                                                'Thrashing Assault','Vertical Cleave','Whirl of Rage','Amorphic Spikes','Barbed Crescent',
                                                'Claw Cyclone','Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage',
                                                'Paralyzing Triad','Seedspray','Sinker Drill','Vanity Dive','Cannonball','Delta Thrust',
                                                'Glutinous Dart','Grand Slam','Quad. Continuum','Sprout Smack','Benthic Typhoon','Helldive',
                                                'Hydro Shot','Jet Stream','Pinecone Bomb','Wild Oats','Heavy Strike'}
 
        PhysicalBlueMagic = S{
                                                'Asuran Claws','Bludgeon','Body Slam','Feather Storm','Mandibular Bite','Queasyshroom',
                                                'Power Attack','Ram Charge','Saurian Slide','Screwdriver','Sickle Slash','Smite of Rage',
                                                'Spinal Cleave','Spiral Spin','Sweeping Gouge','Terror Touch'}
 
        PhysicalBlueMagic_STR = S{
                                                'Battle Dance','Bloodrake','Death Scissors','Dimensional Death','Empty Thrash',
                                                'Quadrastrike','Uppercut','Tourbillion','Thrashing Assault','Vertical Cleave',
                                                'Whirl of Rage'}
 
        PhysicalBlueMagic_DEX = S{
                                                'Amorphic Spikes','Barbed Crescent','Claw Cyclone','Disseverment','Foot Kick',
                                                'Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad','Seedspray',
                                                'Sinker Drill','Vanity Dive'}
 
        PhysicalBlueMagic_VIT = S{
                                                'Cannonball','Delta Thrust','Glutinous Dart','Grand Slam','Quad. Continuum',
                                                'Sprout Smack'}
 
        PhysicalBlueMagic_AGI = S{
                                                'Benthic Typhoon','Helldive','Hydro Shot','Jet Stream','Pinecone Bomb','Wild Oats'}
                               
        BlueMagic_PhysicalAcc = S{
                                                'Heavy Strike'}
 
        MagicalSpells = S{      'Acrid Stream','Anvil Lightning','Crashing Thunder',                                        'Charged Whisker','Droning Whirlwind',
                                                'Firespit','Foul Waters','Gates of Hades','Leafstorm','Molting Plumage','Nectarous Deluge',
                                                'Polar Roar','Regurgitation','Rending Deluge','Scouring Spate','Searing Tempest','Silent Storm',
                                                'Spectral Floe','Subduction','Tem. Upheaval','Thermal Pulse','Thunderbolt','Uproot',
                                                'Water Bomb','Atra. Libations','Blood Saber','Dark Orb','Death Ray','Eyes On Me',
                                                'Evryone. Grudge','Palling Salvo','Tenebral Crush','Blinding Fulgor','Diffusion Ray',
                                                'Magic Hammer','Rail Cannon','Retinal Glare','Embalming Earth','Entomb','Sandspin'}
       
        MagicalBlueMagic = S{
                                                'Acrid Stream','Anvil Lightning','Crashing Thunder','Charged Whisker','Droning Whirlwind','Firespit',
                                                'Foul Waters','Gates of Hades','Leafstorm','Molting Plumage','Nectarous Deluge','Polar Roar',
                                                'Regurgitation','Rending Deluge','Scouring Spate','Searing Tempest','Silent Storm','Spectral Floe',
                                                'Subduction','Tem. Upheaval','Thermal Pulse','Thunderbolt','Uproot','Water Bomb'}
                                               
        BlueMagic_Dark = S{
                                                'Atra. Libations','Blood Saber','Dark Orb','Death Ray','Eyes On Me',
                                                'Evryone. Grudge','Palling Salvo','Tenebral Crush'}
               
        BlueMagic_Light = S{
                                                'Blinding Fulgor','Diffusion Ray','Magic Hammer','Rail Cannon','Retinal Glare'}
               
        BlueMagic_Earth = S{
                                                'Embalming Earth','Entomb','Sandspin'} --- here if you need it but down below, nuking these spells goes to the same int nuke set at others.
 
        BlueMagic_Accuracy = S{
                                                '1000 Needles','Absolute Terror','Auroral Drape','Awful Eye','Blank Gaze','Blistering Roar',
                                                'Blood Drain','Blood Saber','Chaotic Eye','Cimicine Discharge','Cold Wave','Digest','Corrosive Ooze',
                                                'Demoralizing Roar','Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
                                                'Geist Wall','Hecatomb Wave','Infrasonics','Light of Penance','Lowing','Mind Blast','Mortal Ray',
                                                'MP Drainkiss','Osmosis','Reaving Wind','Sheep Song','Soporific','Sound Blast','Stinking Gas',
                                                'Sub-zero Smash','Triumphant Roar','Venom Shell','Voracious Trunk','Yawn'}
 
        BlueMagic_Breath = S{
                                                'Bad Breath','Flying Hip Press','Final Sting','Frost Breath','Heat Breath','Magnetite Cloud',
                                                'Poison Breath','Radiant Breath','Self Destruct','Thunder Breath','Wind Breath'}
 
        BlueMagic_Buff = S{
                                                'Carcharian Verve','Diamondhide','Metallic Body','Magic Barrier','Occultation',
                                                'Orcish Counterstance','Plasma Charge','Pyric Bulwark','Reactor Cool'}
                                                       
        BlueMagic_Healing = S{
                                                'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','Wild Carrot'}
                                               
        BlueMagic_HPCure = S{
                                                'White Wind'}
 
        BlueMagic_Stun = S{
                                                'Blitzstrahl'}
               
        BlueMagic_PhysicalStun = S{
                                                'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}               
               
        BlueMagic_Emnity = S{
                                                'Actinic Burst','Exuviation','Fantod','Jettatura','Temporal Shift'}            
 
        BlueMagic_Diffusion = S{
                                                'Amplification','Cocoon','Exuviation','Feather Barrier','Harden Shell','Memento Mori','Metallic Body',
                                                'Mighty Guard','Plasma Charge','Reactor Cool','Refueling','Saline Coat','Warm-Up','Zephyr Mantle'}
 
        BlueMagic_Unbridled = S{
                                                'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
                                                'Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard','Pyric Bulwark',
                                                'Thunderbolt','Tourbillion'}
end                                            
 
function get_sets()

 
        maps()
 
        QaaxoFeet={}
                QaaxoFeet.Atk={name="Qaaxo Leggings",augments={'Attack+15','Evasion+15','"Dbl.Atk."+2'}}
                QaaxoFeet.Acc={name="Qaaxo Leggings",augments={'Accuracy+15','STR+7','Phys. dmg. taken -3%'}}  
               
        QaaxoHand={}   
                QaaxoHand.Atk={name="Qaaxo Mitaines",augments={'Attack+15','Evasion+15','"Dbl.Atk."+2'}}
                QaaxoHand.Acc={name="Qaaxo Mitaines",augments={'Accuracy+15','STR+7','Phys. dmg. taken -3%'}}
       
        TaeonGloves={}
                TaeonGloves.DW={name="Taeon Gloves", augments={'Accuracy +9','"Dual Wield"+5','Weapon skill damage +1%'}}
                TaeonGloves.TA={name="Taeon Gloves", augments={'DEX+9','Accuracy+15 Attack+15','"Triple Atk." +2'}}
               
        TaeonTights={}
                TaeonTights.MA={name="Taeon Tights", augments={'"Mag. Atk. Bns."+16','"Recycle"+4','Weapon skill damage +3%'}}
                TaeonTights.TA={name="Taeon Tights", augments={'Accuracy+19 Attack+19','"Triple Atk." +2','Crit. hit damage +2%'}}
 
        TaeonBoots={}
                TaeonBoots.RA={name="Taeon Boots", augments={'Rng. Atk.+17','Crit.hit rate +2'}}
                TaeonBoots.TA={name="Taeon Boots", augments={'STR+6 DEX+6','Accuracy+15 Attack+15','"Triple Atk."+2'}}         
       
        TelchineGloves={}
                TelchineGloves.CP={name="Telchine Gloves", augments={'"Cure" Potency +6%'}}
                TelchineGloves.FC={name="Telchine Gloves", augments={'"Fast Cast" +5'}}
       
        TelchineFeet={}
                TelchineFeet.CP={name="Telchine Pigaches", augments={'"Cure" Potency +4%'}}
                TelchineFeet.FC={name="Telchine Pigaches", augments={'"Fast Cast" +3'}}
 
 
        -- DT Sets
        sets.PDT = {ammo="Honed tathlum",
                    head="Iuitl Headgear +1",
                    neck="Twilight torque",
                    ear1="Ethereal Earring",ear2="Colossus's Earring",
                    body="Iuitl Vest +1",
                    hands="Iuitl Wristbands +1",
                    ring1="Defending ring",ring2="Dark ring",
                    back="Solemnity Cape",
                    waist="Flume belt",
                    legs="Iuitl tights +1",
                    feet="Iuitl Gaiters +1"}
 
        sets.MDT = {ammo="Honed tathlum",
                    head="Iuitl Headgear +1",
                    neck="Twilight torque",
                    ear1="Ethereal Earring",ear2="",
                    body="Iuitl Vest +1",
                    hands="Iuitl Wristbands +1",
                    ring1="Defending ring",ring2="Dark ring",
                    back="Solemnity Cape",
                    waist="Flume belt",
                    legs="Iuitl tights +1",
                    feet="Iuitl Gaiters +1"}
 
        sets.FullPDT = set_combine(sets.PDT, {})
 
 
 
        sets.Idle = {}
        --Idle Sets--  

        sets.Idle.Standard = {ammo="Ginsen",
                              head="Rawhide Mask",
                              neck="Fotia Gorget",
                              ear1="Ethereal Earring",ear2="Cessance Earring",
                              body="Luhlaza jubbah +1",
                              hands="Serpentes cuffs",
                              ring1="Sheltered ring",ring2="Paguroidea Ring",
                              back="Kumbira Cape",
                              waist="Fotia Belt",
                              legs="Crimson cuisses",
                              feet="Serpentes sabots"}
                                                 
        sets.Idle.DT = {ammo="Ginsen",
                        head="Iuitl Headgear +1",
                        neck="Twilight torque",
                        ear1="Ethereal Earring",ear2="Colossus's Earring",
                        body="Hagondes Coat +1",
                        hands="Serpentes cuffs",
                        ring1="Defending ring",ring2="Dark ring",
                        back="Solemnity Cape",
                        waist="Flume belt",
                        legs="Crimson cuisses",
                        feet="Serpentes sabots"}
                                                       
        sets.Idle.Town = {ammo="Ginsen",
                          head="Rawhide Mask",
                          neck="Fotia Gorget",
                          ear1="Ethereal Earring",ear2="Cessance Earring",
                          body="Luhlaza jubbah +1",
                          hands="Serpentes cuffs",
                          ring1="Sheltered ring",ring2="Paguroidea Ring",
                          back="Kumbira Cape",
                          waist="Fotia Belt",
                          legs="Crimson cuisses",
                          feet="Serpentes sabots"}                                                       
 
        

 
 
 
 
        --TP Sets--
        -- Generic set, don't fill in
        sets.TP = {}
 
       
       sets.TP.Normal = {}  
       
       
        -- BASE SETS!
        sets.TP['Standard'] = {ammo="Ginsen",
                               head="Taeon Chapeau",
                               neck="Asperity Necklace",
                               ear1="Brutal Earring", ear2="Cessance Earring",
                               body="Adhemar Jacket",
                               hands="Adhemar Wristbands",
                               Ring1="Adoulin Ring",Ring2="Rajas Ring",
                               back="Atheling Mantle",
                               waist="Anguinus Belt",
                               legs="Taeon Tights",
                               feet="Taeon Boots"}              
       
        sets.TP['LowAcc'] = {ammo="Ginsen",
                             head="Taeon Chapeau",
                             neck="Asperity Necklace",
                             ear1="Brutal Earring", ear2="Cessance Earring",
                             body="Adhemar Jacket",
                             hands="Adhemar Wristbands",
                             Ring1="Adoulin Ring",Ring2="Rajas Ring",
                             back="Atheling Mantle",
                             waist="Anguinus Belt",
                             legs="Taeon Tights",
                             feet="Taeon Boots"}
 
        sets.TP['MidAcc'] = {ammo="Honed tathlum",
                             head="Taeon Chapeau",
                             neck="Asperity Necklace",
                             ear1="Brutal Earring", ear2="Cessance Earring",
                             body="Adhemar Jacket",
                             hands="Adhemar Wristbands",
                             Ring1="Adoulin Ring",Ring2="Patricius Ring",
                             back="Atheling Mantle",
                             waist="Anguinus Belt",
                             legs="Taeon tights",
                             feet="Taeon Boots"}
 
 
        sets.TP['HighAcc'] = {ammo="Honed tathlum",
                              head="Taeon Chapeau",
                              neck="Asperity Necklace",
                              ear1="Bladeborn Earring",ear2="Steelflash Earring",
                              body="Adhemar Jacket",
                              hands="Adhemar Wristbands",
                              Ring1="Adoulin Ring",Ring2="Patricius Ring",
                              back="Grounded Mantle",
                              waist="Anguinus Belt",
                              legs="Taeon tights",
                              feet="Taeon Boots"}
 
 
 
 		-- Normal, Medium Accuracy
        sets.TP.Normal.MidAcc = set_combine(sets.TP.Normal, {ammo="Honed Tathlum",})
 
        -- Normaled, High Accuracy
        sets.TP.Normal.HighAcc = set_combine(sets.TP.Normal, {ammo="Honed Tathlum",
                                        ear1="Zennaroi Earring",})
 
 
 
 
 
 
        -- Slowed, Medium Accuracy
        sets.TP.Standard.MidAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",})
 
        -- Slowed, High Accuracy
        sets.TP.Standard.HighAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",
                                        ear1="Zennaroi Earring",})
 
 
        -- Slow 2 Sets
        -- Slow 2, might still have marches/mighty guard
        sets.TP.Slow2 = set_combine(sets.TP.Standard,{})
 
        -- Slowed, Medium Accuracy
        sets.TP.Slow2.MidAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",})
 
        -- Slowed, High Accuracy
        sets.TP.Slow2.HighAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",
                                        ear1="Zennaroi Earring",})
 
 
        -- Haste 2 Sets
        -- Normal Haste 2 or ~30% Haste
        sets.TP.MidHaste = set_combine(sets.TP.Standard, {})
 
        -- Normal Haste, Medium Accuracy
        sets.TP.MidHaste.MidAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",})
 
        -- Normal Haste, High Accuracy
        sets.TP.MidHaste.HighAcc = set_combine(sets.TP.Standard, {ammo="Honed Tathlum",
                                        ear1="Zennaroi Earring",})
 
 
        -- High Haste Sets
        -- ~40%+ Haste
        sets.TP.HighHaste = {ammo="Ginsen",
                             head="Taeon Chapeau",
                             neck="Asperity Necklace",
                             ear1="Brutal Earring", ear2="Cessance Earring",
                             body="Adhemar Jacket",
                             hands="Adhemar Wristbands",
                             Ring1="Adoulin Ring",Ring2="Rajas Ring",
                             back="Atheling Mantle",
                             waist="Anguinus Belt",
                             legs="Taeon Tights",
                             feet="Taeon Boots"}
 
        -- ~40%+ Haste, Medium Accuracy
        sets.TP.HighHaste.MidAcc = {ammo="Ginsen",
                                    head="Taeon Chapeau",
                                    neck="Asperity Necklace",
                                    ear1="Brutal Earring", ear2="Cessance Earring",
                                    body="Adhemar Jacket",
                                    hands="Adhemar Wristbands",
                                    Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                    back="Atheling Mantle",
                                    waist="Anguinus Belt",
                                    legs="Taeon tights",
                                    feet="Taeon Boots"}
       
        -- ~40%+ Haste, High Accuracy
        sets.TP.HighHaste.HighAcc = {ammo="Honed tathlum",
                                     head="Taeon Chapeau",
                                     neck="Asperity Necklace",
                                     ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                     body="Adhemar Jacket",
                                     hands="Adhemar Wristbands",
                                     Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                     back="Grounded Mantle",
                                     waist="Anguinus Belt",
                                     legs="Taeon tights",
                                     feet="Taeon Boots"}
 
        -- TP Thaumas Coat --
        sets.TP.Thaumas = {body="Thaumas Coat"}
 
       
       
       
 
       
       
        --Weaponskill Sets-- Cornflower for Requiescat because it saves a spot as it is the ONLY thing I would need to carry Bleating Mantle for...
        sets.WS = {}
       
        sets.Requiescat = {}
       

        sets.Requiescat.Attack = {ammo="Jukukik feather",
                                  head="Uk'uxkaj Cap",
                                  neck="Fotia Gorget",
                                  ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                  body="Luhlaza Jubbah +1",
                                  hands="Adhemar Wristbands",
                                  Ring1="Adoulin Ring",Ring2="Rajas Ring",
                                  back="Cornflower Cape",
                                  waist="Fotia Belt",
                                  legs="Taeon Tights",
                                  feet="Luhlaza Charuqs +1"}
                                                                 
        sets.Requiescat.Accuracy = {ammo="Honed tathlum",
                                    head="Uk'uxkaj Cap",
                                    neck="Fotia Gorget",
                                    ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                    body="Luhlaza Jubbah +1",
                                    hands="Adhemar Wristbands",
                                    Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                    back="Cornflower Cape",
                                    waist="Fotia Belt",
                                    legs="Taeon Tights",
                                    feet="Luhlaza Charuqs +1"}
                                                         
        sets.ChantDuCygne = {}
       

       
        sets.ChantDuCygne.Attack = {ammo="Jukukik Feather",
                                    head="Uk'uxkaj Cap",
                                    neck="Fotia Gorget",
                                    ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                    body="Adhemar Jacket",
                                    hands="Adhemar Wristbands",
                                    Ring1="Adoulin Ring",Ring2="Rajas Ring",
                                    back="Cornflower Cape",
                                    waist="Fotia Belt",
                                    legs="Taeon Tights",
                                    feet="Adhemar Gamashes"}
                                       
        sets.ChantDuCygne.Accuracy = {ammo="Honed tathlum",
                                      head="Uk'uxkaj Cap",
                                      neck="Fotia Gorget",
                                      ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                      body="Adhemar Jacket",
                                      hands="Adhemar Wristbands",
                                      Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                      back="Grounded mantle",
                                      waist="Fotia Belt",
                                      legs="Taeon Tights",
                                      feet="Adhemar Gamashes"}                                              
                                                           
        sets.ChantDuCygne.AccuracyHigh = {ammo="Honed tathlum",
                                          head="Uk'uxkaj Cap",
                                          neck="Fotia Gorget",
                                          ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                          body="Adhemar Jacket",
                                          hands="Adhemar Wristbands",
                                          Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                          back="Grounded Mantle",
                                          waist="Fotia Belt",
                                          legs="Taeon Tights",
                                          feet="Adhemar Gamashes"}
                                                           
        sets.Expiacion = {}
       

       
        sets.Expiacion.Attack = {ammo="Mantoptera Eye",
                                 head="Adhemar Bonnet",
                                 neck="Caro Necklace",
                                 ear1="Ishvara Earring",ear2="Brutal Earring",
                                 body="Adhemar Jacket",
                                 hands="Adhemar Wristbands",
                                 ring1="Epona's ring",ring2="Ifrit Ring +1",
                                 back="Cornflower Cape",
                                 waist="Fotia Belt",
                                 legs="Samnuha Tights",
                                 feet="Taeon Boots"}
                                       
        sets.Expiacion.Accuracy = {ammo="Mantoptera Eye",
                                   head="Adhemar Bonnet",
                                   neck="Fotia Gorget",
                                   ear1="Zennaroi Earring",ear2="Cessance Earring",
                                   body="Adhemar Jacket",
                                   hands="Adhemar Wristbands",
                                   ring1="Epona's ring",ring2="Ramuh ring +1",
                                   back="Lupine Cape",
                                   waist="Fotia Belt",
                                   legs="Samnuha Tights",
                                   feet="Taeon Boots"}                    
                                         
        sets.WS.SanguineBlade = {}
       
        sets.WS.SanguineBlade = {ammo="Dosis Tathlum",
                                 head="Amalric Coif",
                                 neck="Eddy necklace",
                                 ear1="Friomisi Earring",ear2="Novio Earring",
                                 body="Hagondes Coat +1",
                                 hands="Amalric Gages",
                                 ring1="Adoulin Ring",ring2="Acumen Ring",
                                 back="Cornflower cape",
                                 waist="Aswang Sash",
                                 legs="Hagondes Pants +1",
                                 feet="Amalric Nails"}
               
        sets.WS.CircleBlade = {}               
                       
        sets.WS.CircleBlade = {ammo="Honed Tathlum",
                               head="Taeon Chapeau",
                               neck="Fotia Gorget",
                               ear1="Flame Pearl",ear2="Flame Pearl",
                               body="Adhemar Jacket",
                               hands="Luh. Bazubands +1",
                               ring1="Ifrit Ring",ring2="Ifrit Ring",
                               back="Atheling Mantle",
                               waist="Fotia Belt",
                               legs="Luhlaza Shalwar +1",
                               feet="Luhlaza Charuqs +1"}
       
        sets.SavageBlade = {}
       
   
 
        sets.SavageBlade.Attack ={ammo="Mantoptera Eye",
                                  head="Luh. Keffiyeh +1",
                                  neck="Fotia Gorget",
                                  ear1="Flame Pearl",ear2="Flame Pearl",
                                  body="Luhlaza Jubbah +1",
                                  hands="Luh. Bazubands +1",
                                  ring1="Ifrit Ring",ring2="Ifrit Ring",
                                  back="Cornflower Cape",
                                  waist="Prosilio Belt +1",
                                  legs="Luhlaza Shalwar +1",
                                  feet="Luhlaza Charuqs +1"}
                                                               
        sets.SavageBlade.Accuracy ={ammo="Mantoptera Eye",
                                    head="Taeon Chapeau",
                                    neck="Fotia Gorget",
                                    ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                    body="Luhlaza Jubbah +1",
                                    hands="Luh. Bazubands +1",
                                    ring1="Ifrit Ring",ring2="Ifrit Ring",
                                    back="Grounded Mantle",
                                    waist="Fotia Belt",
                                    legs="Taeon Tights",
                                    feet="Assim. Charuqs +1"}
       
        sets.Realmrazer = {}
 
        sets.Realmrazer.Attack ={ammo="Honed Tathlum",
                                 head="Uk'uxkaj Cap",
                                 neck="Fotia Gorget",
                                 ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                 body="Luhlaza Jubbah +1",
                                 hands="Luh. Bazubands +1",
                                 Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                 back="Cornflower Cape",
                                 waist="Fotia Belt",
                                 legs="Telchine Braconi",
                                 feet="Luhlaza Charuqs +1"}
                                                               
        sets.Realmrazer.Accuracy ={ammo="Honed Tathlum",
                                   head="Uk'uxkaj Cap",
                                   neck="Fotia Gorget",
                                   ear1="Bladeborn Earring",ear2="Steelflash Earring",
                                   body="Luhlaza Jubbah +1",
                                   hands="Luh. Bazubands +1",
                                   Ring1="Adoulin Ring",Ring2="Patricius Ring",
                                   back="Cornflower Cape",
                                   waist="Fotia Belt",
                                   legs="Telchine Braconi",
                                   feet="Assim. Charuqs +1"}
                                   
        sets.FlashNova = {}                        
                                   

 
        sets.FlashNova.Attack ={ammo="Honed Tathlum",
                                head="Amalric Coif",
                                neck="Fotia Gorget",
                                ear1="Friomisi Earring",ear2="Novio Earring",
                                body="Hagondes Coat +1",
                                hands="Amalric Gages",
                                ring1="Adoulin Ring",ring2="Acumen Ring",
                                back="Cornflower cape",
                                waist="Fotia Belt",
                                legs="Hagondes Pants +1",
                                feet="Amalric Nails"}
                                                               
        sets.FlashNova.Accuracy ={ammo="Honed Tathlum",
                                  head="Amalric Coif",
                                  neck="Fotia Gorget",
                                  ear1="Friomisi Earring",ear2="Novio Earring",
                                  body="Hagondes Coat +1",
                                  hands="Amalric Gages",
                                  ring1="Adoulin Ring",ring2="Acumen Ring",
                                  back="Cornflower cape",
                                  waist="Fotia Belt",
                                  legs="Hagondes Pants +1",
                                  feet="Amalric Nails"}                        
 
       
                                   
        --Blue Magic Sets--
        sets.BlueMagic = {}
       
        sets.BlueMagic.STR = {ammo="Mantoptera Eye",
                              head="Luh. Keffiyeh +1",
                              neck="Caro Necklace",
                              ear1="Flame Pearl",ear2="Flame Pearl",
                              body="Adhemar Jacket",
                              hands="Adhemar Wristbands",
                              ring1="Ifrit Ring",ring2="Ifrit Ring",
                              back="Cornflower cape",
                              waist="Prosilio Belt +1",
                              legs="Luhlaza Shalwar +1",
                              feet="Adhemar Gamashes"}
                                                 
        sets.BlueMagic.STRDEX = set_combine(sets.BlueMagic.STR,{ring2="Rajas Ring"})
                                                       
        sets.BlueMagic.STRVIT = set_combine(sets.BlueMagic.STR,{})
                                                                                                               
        sets.BlueMagic.AGI = set_combine(sets.BlueMagic.STR,{
                                feet="Thereoid Greaves"})
               
        sets.BlueMagic.HeavyStrike = set_combine(sets.BlueMagic.STR,{ammo="Honed tathlum",})
                                       
        sets.BlueMagic.INT = {ammo="Dosis Tathlum",
                              head="Amalric Coif",
                              neck="Eddy necklace",
                              ear1="Friomisi Earring",ear2="Novio Earring",
                              body="Hagondes Coat +1",
                              hands="Amalric Gages",
                              ring1="Adoulin Ring",ring2="Acumen Ring",
                              back="Cornflower cape",
                              waist="Aswang Sash",
                              legs="Hagondes Pants +1",
                              feet="Amalric Nails"}
                                 
        sets.BlueMagic.LightNuke = set_combine(sets.BlueMagic.INT,{
                                ring2="Weatherspoon Ring",})
                                 
        sets.BlueMagic.DarkNuke = set_combine(sets.BlueMagic.INT,{
                                head="Pixie Hairpin +1",
                                ring2="Archon Ring",})
                                                 
        sets.BlueMagic.ChargedWhisker = set_combine(sets.BlueMagic.INT,{
                                        ring2="Ramuh Ring +1",})
                                       
        sets.BlueMagic.Cures = {ammo="Hydrocera",
                                head="Telchine Cap",
                                neck="Twilight Torque",
                                ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
                                body="Telchine Chas.",
                                hands="Telchine Gloves",
                                Ring1="Sangoma Ring",Ring2="Prolix Ring",
                                back="Solemnity Cape",
                                waist="Witful Belt",
                                legs="Telchine Braconi",
                                feet="Telchine Pigaches"}
       
        sets.BlueMagic.WhiteWind = {ammo="Hydrocera",
                                    head="Telchine Cap",
                                    neck="Twilight Torque",
                                    ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
                                    body="Telchine Chas.",
                                    hands="Telchine Gloves",
                                    ring1="Sangoma Ring",ring2="Prolix Ring",
                                    back="Solemnity Cape",
                                    waist="Flume belt",
                                    legs="Telchine Braconi",
                                    feet="Telchine Pigaches"}
        --Sudden Lunge                                 
        sets.BlueMagic.Stun = {ammo="Mantoptera Eye",
                               head="Amalric Coif",
                               neck="Eddy Necklace",
                               ear1="Gwati Earring",ear2="Enchntr. Earring +1",
                               body="Assim. jubbah +1",
                               hands="Rawhide Gloves",
                               ring1="Adoulin Ring",ring2="Sangoma Ring",
                               back="Cornflower cape",
                               waist="Anguinus Belt",
                               legs="Hashishin Tayt",
                               feet="Amalric Nails"}
       
        sets.BlueMagic.MagicAccuracy = {ammo="Mavi Tathlum",
                                        head="Amalric Coif",
                                        neck="Eddy necklace",
                                        ear1="Gwati Earring",ear2="Enchntr. Earring +1",
                                        body="Assim. jubbah +1",
                                        hands="Rawhide Gloves",
                                        ring1="Adoulin Ring",ring2="Sangoma Ring",
                                        back="Cornflower cape",
                                        waist="Ovate Rope",
                                        legs="Hashishin Tayt",
                                        feet="Amalric Nails"}
                                                                         
        sets.BlueMagic.Skill = {ammo="Mavi Tathlum",
                                head="Luh. Keffiyeh +1",
                                neck="Deceiver's Torque",
                                ear1="",ear2="Ethereal earring",
                                body="Assim. jubbah +1",
                                hands="Rawhide Gloves",
                                ring1="Adoulin Ring",ring2="Sangoma Ring",
                                back="Cornflower cape",
                                waist="Flume Belt",
                                legs="Hashishin Tayt",
                                feet="Luhlaza Charuqs +1"}
                                                       
        sets.BlueMagic.SkillRecast = {ammo="",
                                      head="Luh. Keffiyeh +1",
                                      neck="Deceiver's Torque",
                                      ear1="",ear2="Ethereal earring",
                                      body="Hashishin Mintan",
                                      hands="Hashi. Bazubands",
                                      ring1="Adoulin Ring",ring2="Sangoma Ring",
                                      back="Cornflower cape",
                                      waist="Witful Belt",
                                      legs="Hashishin Tayt",
                                      feet="Luhlaza Charuqs +1"}
                                         
        sets.BlueMagic.Enmity = {ammo="",
                                 head="Rabid Visor",
                                 neck="Warder's Charm +1",
                                 ear1="",ear2="",
                                 body="Emet Harness +1",
                                 hands="",
                                 ring1="",ring2="Petrov Ring",        
                                 back="Mubvumbamiri mantle",
                                 waist="",
                                 legs="",
                                 Feet=""}     
                                                                 
        --Utility Sets--
        --Sets such as Phalanx/Steps are out of date because I don't cast/use that shit!
       
        sets.Utility = {}
       
        sets.Utility.Stoneskin = {ammo="Hydrocera",
                                        head="Carmine Mask",
                                        neck="Stone Gorget",
                                        ear1="Loquac. earring",ear2="Earthcry earring",
                                        body="Assim. jubbah +1",
                                        hands="Stone Mufflers",
                                        ring1="None",ring2="Aquasoul Ring",
                                        back="Swith cape",
                                        waist="Siegel sash",
                                        legs="Haven hose",
                                        feet=QaaxoFeet.Acc}
                                                         
        sets.Utility.Phalanx = {ammo="Hydrocera",
                                        head="Amalric Coif",
                                        neck="Colossus's torque",
                                        ear1="Loquac. earring",ear2="Augment. earring",
                                        body="Assim. jubbah +1",
                                        hands="Assim. bazu. +1",
                                        ring1="Lebeche ring",ring2="Weatherspoon ring",
                                        back="Swith cape",
                                        waist="Pythia sash +1",
                                        legs="Portent pants",
                                        feet=QaaxoFeet.Acc}
                                                       
        sets.Utility.Steps = {ammo="Honed tathlum",
                                        head="Adhemar Bonnet",
                                        ear1="Dudgeon Earring",ear2="Heartseeker earring",
                                        body="Adhemar Jacket",
                                        hands="Buremte gloves",
                                        back="Lupine Cape",
                                        waist="Chaac Belt",
                                        legs="Samnuha Tights",
                                        feet=QaaxoFeet.Acc}
                       
        --Job Ability Sets--
       
        sets.JA = {}
       
        sets.JA.ChainAffinity = {feet="Assim. charuqs +1"}
       
        sets.JA.BurstAffinity = {feet="Hashishin Basmak"}
       
        sets.JA.Efflux = {legs="Hashishin Tayt"}
       
        sets.JA.AzureLore = {hands="Luh. Bazubands +1"}
       
        sets.JA.Diffusion = {feet="Luhlaza Charuqs +1"}
       
        sets.JA.Provoke = set_combine(sets.BlueMagic.Enmity,{})
       
        sets.JA.Warcry = set_combine(sets.BlueMagic.Enmity,{})
 
                                                               
                                                               
                       
                       
                       
                       
        --Precast Sets--
        sets.precast = {}
       
        sets.precast.FC = {}
       
        sets.precast.FC.Standard = {ammo="",
                                    head="Amalric Coif",
                                    neck="",
                                    ear1="Moonshade Earring", ear2="Enchntr. Earring +1",
                                    body="Luhlaza jubbah +1",
                                    hands="Helios Gloves",
                                    ring1="Defending Ring",ring2="Prolix Ring",
                                    back="Swith Cape",
                                    waist="Witful Belt",
                                    legs="Psycloth Lappas",
                                    feet="Amalric Nails"}
       
        sets.precast.FC.Blue = set_combine(sets.precast.FC.Standard,{
                                        body="Hashishin Mintan"})

 
 
 
 
 
 
-- Now that all of our actual SETS are defined, lets create some non-set arrays to contain references to them
-- These arrays can be referenced by an index number array[1] or a name array['superfast'] later on
-- It might help to think of these as just "column names" in excel, where in the column named sets.Idle.index, row 1, might be "standard", row 2 might be "DT", etc.  
-- These dont do anything except act as a dictionary of words.  We eventually tell it which word we want, like sets.Idle.index[2] might just be the word "DT"
sets.Idle.index = {
	'Standard',
	'DT',
	'Town'
}       


sets.FlashNova.index = {
	'Attack',
	'Accuracy'
}


sets.TP.index = {
    'Standard', 	-- KEEP IN MIND CASE SENSITIVE, slow is not the same as Slow 
    'LowAcc',		--### set 2	 
    'MidAcc', 		--### set 3 ... ETC
    'HighAcc', 
    'Thaumas'
}


sets.Realmrazer.index = {
	'Attack',
	'Accuracy'
}



sets.SavageBlade.index = {
	'Attack',
	'Accuracy'
}


sets.Expiacion.index = {
	'Attack',
	'Accuracy'
}


sets.Requiescat.index = {
	'Attack',
	'Accuracy'
}


sets.ChantDuCygne.index = {
	'Attack',
	'Accuracy',
	'AccuracyHigh'
}


SpeedSets = {
	"Normal",
	"Slow",
	"Slow2",
	"MidHaste",
	"HighHaste"
}
    
            
AccArray = {
	"LowAcc",
	"MidAcc",
	"HighAcc"
}
    
        
end               



-- DEFINE SOME VARIABLES WE KNOW WE'LL USE LATER - BEST TO DEFINE AFTER SETS CREATED IN CASE WE REFERENCE THEM
 -- Lets Define some Variables, we can change multiple default settings quickly if we do all these in one spot, sort of like a configuration file for other things!
Idle_ind = 1

FlashNova_ind = 1

TP_ind = 1

Realmrazer_ind = 1   

SavageBlade_ind = 1 

Expiacion_ind = 1

Requiescat_ind = 1

ChantDuCygne_ind = 1

MySpeed = 1  -- Dont think this is needed if we properly check, but defining a default anyhow

AccIndex = 1
      
Thaumas = 'OFF'

PDTmode = 'off'

MDTmode = 'off'

target_distance = 6              
 
-- Fujidebug = 'off'
 
 
 
 
 
-- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ Enabled - Set the Fujidebug var to OFF to disable ~~~') end  
 

 
-- Done with vars and sets, ON TO FUNCTIONS!
function precast(spell)
        if spell.action_type == 'Magic' then
                equip(sets.precast.FC.Standard)
                               
                elseif spell.action_type == 'BlueMagic' then
                equip(sets.precast.FC.Blue)
        end
       
        
        if spell.english == 'Azure Lore' then
                equip(sets.JA.AzureLore)
        end
       
        
        if spell.type == 'WeaponSkill' then
        	if spell.english == 'Requiescat' then
	                equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
	        		-- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ WS::' .. spell.english .. ' ~~~  MODE::' .. sets.Requiescat.index[Requiescat_ind] .. ' ~~~') end  
	        
	        elseif spell.english == 'Chant du Cygne' then
	                equip(sets.ChantDuCygne[sets.ChantDuCygne.index[ChantDuCygne_ind]])
	       			-- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ WS::' .. spell.english .. ' ~~~  MODE::' .. sets.ChantDuCygne.index[ChantDuCygne_ind] .. ' ~~~') end  
	       			
	        elseif spell.english == 'Expiacion' then
	                equip(sets.Expiacion[sets.Expiacion.index[Expiacion_ind]])
	 
	        elseif spell.english == 'Savage Blade' then
	                equip(sets.SavageBlade[sets.SavageBlade.index[SavageBlade_ind]])
	       
	        elseif spell.english == 'Realmrazer' then
	                equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
	       
	        elseif spell.english == 'Flash Nova' then
	                equip(sets.FlashNova[sets.FlashNova.index[FlashNova_ind]])
	       
	        elseif spell.english == 'Circle Blade' then
	                equip(sets.WS.CircleBlade)
	       
	        elseif spell.english == 'Sanguine Blade' or spell.english == 'Red Lotus Blade' then
	                equip(sets.WS.SanguineBlade)
	        end

		    

		end
    	   
        
        if spell.english == 'Box Step' then
                equip(sets.Utility.Steps)
        end

--if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ SPELL::' .. spell.english .. ' ~~~  WHEN:: PRECAST ~~~') status_change(player.status) end  
     
end
 
function midcast(spell,act)
        if spell.action_type == 'Magic' then
                if spell.skill == 'Blue Magic' then
                        equipSet = sets.BlueMagic
                        if PhysicalSpells:contains(spell.english) then
                                if PhysicalBlueMagic_STR:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.STR)
                                elseif PhysicalBlueMagic_DEX:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.STRDEX)
                                elseif PhysicalBlueMagic_VIT:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.STRVIT)
                                elseif PhysicalBlueMagic_AGI:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.AGI)
                                elseif PhysicalBlueMagic:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.STR)
                                elseif BlueMagic_PhysicalAcc:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.HeavyStrike)
                                end
                                if buffactive['Chain Affinity'] then
                                        equipSet = set_combine(equipSet,sets.JA.ChainAffinity)
                                end
                                if buffactive.Efflux then
                                        equipSet = set_combine(equipSet,sets.JA.Efflux)
                                end
                        end
                        if MagicalSpells:contains(spell.english) then
                                if MagicalBlueMagic:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.INT)
                                elseif BlueMagic_Dark:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.DarkNuke)
                                elseif BlueMagic_Light:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.LightNuke)
                                elseif BlueMagic_Earth:contains(spell.english) then
                                        equipSet = equip(sets.BlueMagic.INT)
                                end
                                if buffactive['Burst Affinity'] then
                                        equipSet = set_combine(equipSet,sets.JA.BurstAffinity)
                                end
                                if world.day_element == spell.element or world.weather_element == spell.element then
                                        equipSet = set_combine(equipSet,{waist='Hachirin-no-Obi'})
                                end
                        end
                        if BlueMagic_Accuracy:contains(spell.english) then
                                equipSet = equip(sets.BlueMagic.MagicAccuracy)
                        elseif BlueMagic_Stun:contains(spell.english) then
                                equipSet = equip(sets.BlueMagic.Stun)
                        elseif BlueMagic_PhysicalStun:contains(spell.english) then
                                equipSet = equip(sets.BlueMagic.Stun)
                        elseif BlueMagic_Emnity:contains(spell.english) then
                                equipSet = equip(sets.BlueMagic.Enmity)                                             
                        elseif BlueMagic_Buff:contains(spell.english) then
                                equipSet = equip(sets.BlueMagic.Skill)
                        elseif buffactive.Diffusion then
                                equipSet = set_combine(equipSet,sets.JA.Diffusion)
                        elseif spell.english == 'White Wind' then
                                equipSet = equip(sets.BlueMagic.WhiteWind)
                        elseif BlueMagic_Healing:contains(spell.english) or spell.english == 'Cure IV' then
                                equipSet = equip(sets.BlueMagic.Cures)
                        end
                end
        end
--if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ SPELL::' .. spell.english .. ' ~~~  WHEN:: MIDCAST ~~~') status_change(player.status) end  

end
 
function aftercast(spell)
	-- got rid of other shit, just run status_change here
	status_change(player.status)
--if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ SPELL::' .. spell.english .. ' ~~~  WHEN:: AFTERCAST ~~~') status_change(player.status) end  
end
 
function speed_check()

-- Set a Default for Myspeed
MySpeed = 1

        -- 13 = Slow 1
        -- 565 = Slow 2
        -- 33 = Haste 1
        -- 580 = Haste 2
        -- 214 = March
        -- 228 = Embrava
        -- 370 = Samba
        -- 604 = Mighty Guard
 
        -- Returns:
        --		1 if Normal
        --      2 if Slow
        --      3 if High Slow
        --      4 if Haste
        --      5 if High Haste
        
        -- IF YOU ARE SLOW OR SLOW II                  
        if ( (buffactive[13] or buffactive[565])
	        -- BUT HAVE A BIT OF SURVIVING HASTE FROM MARCHES, EMBRAVA, OR MG...
	        and (buffactive[214] or buffactive[228] or buffactive[604])) then
        		MySpeed = 2 -- SLOW
        
        -- IF YOU ARE SLOW OR SLOW III
        elseif ( (buffactive[13] or buffactive[565])
        	-- AND DON'T HAVE ANY OTHER FORMS OF HASTE KEEPING YOU DECENT SPEEDS... 
        	and not (buffactive[214] or buffactive[228] or buffactive[604]) ) then
        		MySpeed = 3 -- HIGH SLOW
        
        -- IF YOU ARE HASTED AND EMBRAVAD, HASTED AND MARCHED, HASTED AND MARCH x2, or HASTED AND MIGHTY'D... ASSUME VERY HIGH HASTE
        elseif ( (buffactive[580] or buffactive[33]) and ( buffactive[228] or buffactive[214] == 1 or buffactive[214] == 2 or buffactive[604]) ) then
 			MySpeed = 5 -- HIGH HASTE
 		
 		-- Check this AFTER high-haste, because mid contains less shit and we dont want to program a lot of "and not this and not that blah blah blah"
 		-- IF YOU ARE HASTE I, HASTE II, MIGHTY'D OR HAVE BARD MARCH, ASSUME HASTED.  DONT NEED TO DEFINE "AND NOT SLOWED" BECAUSE WE CHECKED FOR SLOW FIRST.
        elseif ( buffactive[580] or buffactive[33] or buffactive[604] or buffactive[214] == 1 ) then
        	MySpeed = 4 -- MID HASTE
 		
 		-- If no buffs return Normal - At this point you suck and should get buffs noob omg so noob lolololol
 		else 
 			MySpeed = 1
 		
 		end
 
 
        -- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ MySpeed :: ' .. MySpeed .. ' ~~~') end  
        
        
end
 
function status_change(new,old)
equipSet = sets.TP[sets.TP.index[TP_ind]] -- Creating an equipset variable and filling it with the basic TP index choice to start out
idleSet = sets.Idle[sets.Idle.index[Idle_ind]]
 
-- Define a Setname
SETMODE = sets.TP.index[TP_ind]
HASTEMODE = "H"
ACCMODE = "A"
 
        
        
       
        -- if PDT and MDT are not set, begin checking for mode variables like TP index, Haste index, etc, and populate "equipSet" variable with the proper information.
        if new == 'Engaged' then
 
                -- basically what this is doing is checking if we have a "SpeedSets" and haste index defined for the default TP set.
                -- If it finds a match, it modifies the equipSet's current value to append the value found inside the hasteindex,
                -- I.E. SpeedSets[MySpeed] might be SpeedSets[HighHaste]
                -- So... if equipSet == sets.TP[slow], and SpeedSets[HighHaste] is set, append the haste index value so we get a matching set name you've defined.
                -- I.E. sets.TP.slow becomes sets.TP.slow[HighHaste]
                if equipSet[SpeedSets[MySpeed]] then
                        equipSet = equipSet[SpeedSets[MySpeed]]
                        HASTEMODE = SpeedSets[MySpeed] -- Just so when we update our screen text we know what sets we are equipping, see my "TP_Set: Gearswap" chat line below
                end
               
               
                -- Same thing but with ACC.. but I removed it for now because it assumes the same position of hastearray, and would replace it..
                -- to take advantage of this you should ALWAYS ensure ACC setting comes AFTER haste in your naming scheme.
                -- For example, sets.TP.highacc.highhaste would fail to ever work, because we are appending acc if it exists, only AFTER we've checked for haste mode.
                -- If there's an ACC array defined, append it's name to either the root sets.TP.whatever name, or sets.TP.whatever.hastemode name.
                if equipSet[AccArray[AccIndex]] then
                        equipSet = equipSet[AccArray[AccIndex]]
                        ACCMODE = AccArray[AccIndex] -- Just so when we update our screen text we know what sets we are equipping, see my "TP_Set: Gearswap" chat line below
                end
               
                -- If thaumas variable is defined as ON:
                if Thaumas == 'ON' then
                        equipSet = set_combine(equipSet,sets.TP.Thaumas)
                end
               
 
                -- Equip the "equipset" variable we've populated (should be a set)
                equip(equipSet)
                                                                                                                                                      
       
		-- no matches detected for engaged or anything, thow on idle gear and assume thats the case
		else
			
			-- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ Idle Set ~~~') end 
			
			if player.mpp < 50 then
				idleSet = set_combine(idleSet, {waist="Fucho-no-obi"})
			else		
				-- Don't change idleSet
			end
			
			equip(idleSet)
		end
       

       
       
       -- LETS OVERRIDE THE SETS WE EQUIP IF PDT OR MDT ARE SET - THESE ARE KING AS THEY HAPPEN LAST
        if PDTmode == 'on' then
                equip(sets.PDT)
				-- if Fujidebug == 'on' then add_to_chat(200, 'FujiDebug: ~~~ TRIGEEEEEEEEEEEEEERRRED     ~~') end 
				
		-- Lets not do PDT and MDT at the same time, its eitehr one or the other, if PDT set is on, it overrides MDT mode.
        elseif MDTmode == 'on' then
                equip(sets.MDT)
                
		end
       
       	
       	--if Fujidebug == 'off' then
		    -- NOTE - it's calling array, we want the name or a variable name or something that makes sense for our eyes to see in game
		    -- add_to_chat(200, 'Default: Gearswap : ~~~ ' .. sets.TP.index[TP_ind] .. ' ~~~')
		    -- Check what's happenin BROSK
		--    add_to_chat(200, 'FujiDebug: ~~~ SET::' .. SETMODE .. '  HASTE::' .. HASTEMODE .. '  ACC::' .. ACCMODE .. ' ~~~')
		--	add_to_chat(200, 'FujiDebug: ~~~ Testing Acc Indexes :: ' .. AccArray[1] .. ' ~~~ ') -- TO make sure arrays are populating, throw other array #s in place of the 1
		--	add_to_chat(200, 'FujiDebug: ~~~ Testing Haste Indexes :: Current --> ' .. MySpeed .. ' ~~~ ')
		--	add_to_chat(200, 'FujiDebug: ~~~ Testing Haste Set :: Current --> ' .. SpeedSets[MySpeed] .. ' ~~~ ')
		-- end        
                            
       
end




  
   
     
function buff_change(buff,gain)
        speed_check()
        buff = string.lower(buff)
        if buffactive.Terror or buffactive.Stun or buffactive.Petrification or buffactive.Sleep and gain then
                equip(sets.FullPDT)
        else
                if not midaction() then
                        status_change(player.status)
                end
        end
end
 
 

 
function self_command(command)
        if command == 'toggle Acc set' then
                AccIndex = (AccIndex % #AccArray) + 1
                add_to_chat(158,'<----- TP Set changed to '..AccArray[AccIndex]..' ----->')

       
        elseif command == 'toggle PDT set' then
                if PDTmode == 'on' then
                        PDTmode = 'off'
                        add_to_chat(123,'PDT Set: [Unlocked]')
                else
                        PDTmode = 'on'
                        add_to_chat(158,'PDT Set: [Locked]')
                end

 
                elseif command == 'toggle MDT set' then
                if MDTmode == 'on' then
                        MDTmode = 'off'
                        add_to_chat(123,'MDT Set: [Unlocked]')
                else
                        MDTmode = 'on'
                        add_to_chat(158,'MDT Set: [Locked]')
                end
                
               
               
        elseif command == 'toggle Thaumas Coat' then
                if Thaumas == 'ON' then
                        Thaumas = 'OFF'
                        add_to_chat(123,'Thaumas Coat: [OFF]')
                else
                        Thaumas = 'ON'
                        add_to_chat(158,'Thaumas Coat: [ON]')
                end

 
                elseif command == 'toggle Idle set' then
                Idle_ind = Idle_ind +1
                if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
                send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
                equip(sets.Idle[sets.Idle.index[Idle_ind]])
       
       
       
        -- ### Added this back in so the TP toggle actually did something
        -- ### See TP_Index set notes to change what this array cycles through.
        elseif command == 'toggle TP set' then
                TP_ind = TP_ind +1
                if TP_ind > #sets.TP.index then TP_ind = 1 end
                       
                -- ### This send_command line is important because it's the only thing telling you in game what just happened.
                -- ### If this is wrong, it's harder to address issues.
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
               
                -- ### this is the line that actually passes the change gear command to the game.
                -- ### Without this, we are just changing variables, we hadn't yet told it what to DO with those variables.
                -- ### The reason I am specifying this, is it looks like there may be other toggles where you need to do similar things.
                equip(sets.TP[sets.TP.index[TP_ind]])

                                               
        elseif command == 'toggle Req set' then
                Requiescat_ind = Requiescat_ind +1
                if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
                send_command('@input /echo <----- Requiescat Set changed to '..sets.Requiescat.index[Requiescat_ind]..' ----->')
       
       
        elseif command == 'toggle CDC set' then
                ChantDuCygne_ind = ChantDuCygne_ind +1
                if ChantDuCygne_ind > #sets.ChantDuCygne.index then ChantDuCygne_ind = 1 end
                send_command('@input /echo <----- Chant du Cygne Set changed to '..sets.ChantDuCygne.index[ChantDuCygne_ind]..' ----->')
       
       
        elseif command == 'toggle Expi set' then
                Expiacion_ind = Expiacion_ind +1
                if Expiacion_ind > #sets.Expiacion.index then Expiacion_ind = 1 end
                send_command('@input /echo <----- Expiacion Set changed to '..sets.Expiacion.index[Expiacion_ind]..' ----->')
       
       
        elseif command == 'toggle Savage set' then
                SavageBlade_ind = SavageBlade_ind +1
                if SavageBlade_ind > #sets.SavageBlade.index then Expiacion_ind = 1 end
                send_command('@input /echo <----- Savage Blade Set changed to '..sets.SavageBlade.index[SavageBlade_ind]..' ----->')
       
       
        elseif command == 'toggle Realm set' then
                Realmrazer_ind = Realmrazer_ind +1
                if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
       
       
        elseif command == 'toggle FlashNova set' then
                FlashNova_ind = FlashNova_ind +1
                if FlashNova_ind > #sets.FlashNova.index then FlashNova_ind = 1 end
                send_command('@input /echo <----- Savage Blade Set changed to '..sets.SavageBlade.index[SavageBlade_ind]..' ----->')
       
       
        elseif command == 'equip TP set' then
                equip(sets.TP[sets.TP.index[TP_ind]])
       
       
        elseif command == 'equip Idle set' then
                equip(sets.Idle[sets.Idle.index[Idle_ind]])
       
        -- this is an awesome method to show states.
        --elseif command == 'show user state' then
                --display_current_state()

        end

       status_change(player.status)
                  
end