forceGfNotes = false
sans = false
function onCreate()
    if not getPropertyFromClass('ClientPrefs', 'hideHud') then
        sans = true
    end

    setProperty('camHUD.alpha', 0)
    makeLuaSprite('bg1', 'bg1');
    setScrollFactor("bg1", 0.85, 1)

    makeLuaSprite('bg1Mesa', 'bg1Mesa');
    setPropertyFromClass('GameOverSubstate', 'characterName', 'sonicPajero');
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'tikygameOver'); -- put in mods/music/

    addLuaSprite('bg1', false);
    addLuaSprite('bg1Mesa', false);

    makeLuaSprite('barriba', '', -200, -200) -- -30
    makeGraphic('barriba', 2000, 100, '000000')
    addLuaSprite('barriba', false)
    setScrollFactor('barriba', 0, 0)
    setObjectCamera('barriba', 'hud')

    makeLuaSprite('babajo', '', -200, 900) ---650
    makeGraphic('babajo', 2000, 100, '000000')
    addLuaSprite('babajo', false)
    setScrollFactor('babajo', 0, 0)
    setObjectCamera('babajo', 'hud')

    makeAnimatedLuaSprite('pc', 'pc', 1485, 520); -- compu epico gamer instance
    addAnimationByPrefix('pc', 'compu epico gamer instance ', 'compu epico gamer instance ', 24, true)
    objectPlayAnimation('pc', 'compu epico gamer instance ', true)

    scaleObject('pc', .45, .45);
    addLuaSprite('pc', false);

    ----

    scaleObject('pc', .45, .45);
    addLuaSprite('pc', false);

    -----

    makeAnimatedLuaSprite('pc2', 'pc_de_lado', 1520, 380); -- compu epico gamer instance
    addAnimationByPrefix('pc2', 'pcAnim', 'compu gamer', 24, true)
    setProperty('pc2.visible', false);
    addLuaSprite('pc2', false);

    setObjectOrder('bfGroup', 5);
    setObjectOrder('dadGroup', 10);
    setObjectOrder('gfGroup', 3);

    makeLuaSprite('knuclesi', 'knuclesIcon', getProperty('iconP2.x'), getProperty('iconP2.y'))
    setObjectCamera('knuclesi', 'hud')
    setObjectOrder('knuclesi', getObjectOrder('iconP1') + 10)
    addLuaSprite('knuclesi', true)
    setProperty('knuclesi.visible', sans)
    setProperty('knuclesi.alpha', 0)
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- shit rayltro
    --
    --

    if (not compareVersion(getVersion(), "0.6.1")) then
        debugPrint("The version you're currently using is not supported for 3rd Strumline!")
        debugPrint("The required version to use this are v0.6.2 and above")
        return close(false)
    end
    --[[
	if (getVersionNumber(getVersion()) == 061) then
		debugPrint("The version you're currently using is unsafe and will cause memory leaks!")
		debugPrint("Please use the version v0.6.2 and above")
	end
	]]

    -- LMAO DONT RUN THE SCRIPT TWICE!!
    for i = 0, getProperty("luaArray.length") - 1 do
        local scriptName = getPropertyFromGroup("luaArray", i, "scriptName"):reverse()
        scriptName = scriptName:sub(1, scriptName:find("/", 1, true) - 1):reverse()

        if (scriptName:lower() == "3rdstrumlineralt.lua") then
            return close(false)
        end
    end

    fakeCrochet = (60 / bpm) * 1000

    addHaxeLibrary("Math")

    addHaxeLibrary("FlxRect", "flixel.math")

    addHaxeLibrary("StrumNote")
    addHaxeLibrary("Note")

    wooo()
    initGFHaxe()

end
---
---
function onCreatePost()

    setProperty('gf.visible', false)
    setProperty('boyfriend.flipX', false)

end
local nice = false9
function onGfStrumInit()
    nice = true

    for i = 0, 7 do
        local key = (i % 4)
        local name = i > 3 and "realDefaultPlayerStrum" or "realDefaultOpponentStrum"

        setPropertyFromGroup("strumLineNotes", i, "x", _G[name .. "X" .. key])
        setPropertyFromGroup("strumLineNotes", i, "y", _G[name .. "Y" .. key])
    end

    for i = 8, 11 do
        local key = (i % 4)
        local name = "defaultGfStrum"

        setPropertyFromGroup("strumLineNotes", i, "x", _G[name .. "X" .. key])
        setPropertyFromGroup("strumLineNotes", i, "y", _G[name .. "Y" .. key] + (downscroll and -720 or 720))
    end
end

--  "directory": "sonic pajero",
-- "defaultZoom": 0.8,

-- "boyfriend": [940, 340],
---  "girlfriend": [1020, 310],
--  "opponent": [-180, 200],
--  "camera_speed": 1
-- }

function onCountdownStarted()
    if (not initialized) then
        return
    end
    runHaxeCode([[
		var canTween = !game.isStoryMode && !game.skipArrowStartTween;
		var middleScroll = ClientPrefs.middleScroll;
		
		for (i in 0...game.strumLineNotes.length) {
			var player = Math.floor(i / 4);
			var key = i % 4;
			var babyArrow = game.strumLineNotes.members[i];
			
			var targetAlpha = 1;
			if (player < 1 && middleScroll)
				targetAlpha = 0.35;
			
			if (canTween) {
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5});
			}
			else
				babyArrow.alpha = targetAlpha;
			
			babyArrow.scale.set(
				babyArrow.scale.x / 1.075,
				babyArrow.scale.y / 1.075
			);
			babyArrow.x -= 9 * (key - 2);
			
			if (player == 1) {
				game.setOnLuas('realDefaultPlayerStrumX' + key, babyArrow.x);
				game.setOnLuas('realDefaultPlayerStrumY' + key, babyArrow.y);
			}
			else {
				game.setOnLuas('realDefaultOpponentStrumX' + key, babyArrow.x);
				game.setOnLuas('realDefaultOpponentStrumY' + key, babyArrow.y);
			}
			
			/* formula
			if(player == 1) {
				if (middleScroll)
					babyArrow.x = -278;
				else
					babyArrow.x = 42 + (50 * 2);
			}
			else
				babyArrow.x = -56;
			babyArrow.postAddedToGroup();
			babyArrow.x -= 9 * (key - 2);
			*/
			if (player == 1) {
				if (middleScroll)
					babyArrow.x = defaultMiddleStrumPos[key][0];
				else
					babyArrow.x = defaultRightStrumPos[key][0];
			}
			else
				babyArrow.x = defaultLeftStrumPos[key][0];
			
			if (player == 1) {
				game.setOnLuas('defaultPlayerStrumX' + key, babyArrow.x);
				game.setOnLuas('defaultPlayerStrumY' + key, babyArrow.y);
			}
			else {
				game.setOnLuas('defaultOpponentStrumX' + key, babyArrow.x);
				game.setOnLuas('defaultOpponentStrumY' + key, babyArrow.y);
			}
		}
		
		for (i in 0...4) {
			/* formula
			var x = (-Note.swagWidth * 8) - 20;
			if (middleScroll)
				x = (50 * 4) - (Note.swagWidth * 6) - 28;
			*/
			var x = 0;
			
			var babyArrow = new StrumNote(x, game.strumLine.y, i, 2);
			babyArrow.downScroll = ClientPrefs.downScroll;
			
			var targetAlpha = middleScroll ? 0.35 : 1;
			
			if (canTween) {
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5});
			}
			else
				babyArrow.alpha = targetAlpha;
			
			game.opponentStrums.add(babyArrow);
			game.strumLineNotes.add(babyArrow);
			gfStrums[i] = babyArrow;
			
			babyArrow.scale.set(
				babyArrow.scale.x / 1.075,
				babyArrow.scale.y / 1.075
			);
			babyArrow.postAddedToGroup();
			//babyArrow.x -= 9 * (i - 2);
			
			if (middleScroll)
				babyArrow.x = defaultRightStrumPos[i][0];
			else
				babyArrow.x = defaultMiddleStrumPos[i][0];
			game.setOnLuas('defaultGfStrumX' + i, babyArrow.x);
			game.setOnLuas('defaultGfStrumY' + i, babyArrow.y);
		}
		
		for (i in 0...4) {
			game.setOnLuas('defaultLeftStrumX' + i, defaultLeftStrumPos[i][0]);
			game.setOnLuas('defaultLeftStrumY' + i, defaultLeftStrumPos[i][1]);
		}
		for (i in 0...4) {
			game.setOnLuas('defaultRightStrumX' + i, defaultRightStrumPos[i][0]);
			game.setOnLuas('defaultRightStrumY' + i, defaultRightStrumPos[i][1]);
		}
		for (i in 0...4) {
			game.setOnLuas('defaultMiddleStrumX' + i, defaultMiddleStrumPos[i][0]);
			game.setOnLuas('defaultMiddleStrumY' + i, defaultMiddleStrumPos[i][1]);
		}
		
		game.callOnLuas('onGfStrumInit', []);
	]])
end

function wooo()
    for i = 0, getProperty("eventNotes.length") - 1 do
        if (getPropertyFromGroup("eventNotes", i, "event"):lower() == "forcegfnotes") then
            forceGfNotes = true
            return
        end
    end
end

function eventEarlyTrigger(name)
    if (name:lower() == "forcegfnotes") then
        forceGfNotes = true
    end
    return 0
end

function onSpawnNote(i)
    if (not initialized) then
        return
    end
    runHaxeCode([[
		onSpawnNote(]] .. i .. [[);
	]])
end

initialized = false
function initGFHaxe()
    if (not check()) then
        return close(false)
    end
    runHaxeCode([[
		forceGfNotes = ]] .. tostring(forceGfNotes) .. [[;
		fakeCrochet = ]] .. fakeCrochet .. [[;
		frames = 0;
		dt = 0;
		gfStrums = [];
		gfIgnores = [];
		gfSplashes = [];
		
		goodHits = [];
		cachedPStrumA1 = [];
		cachedPStrumA2 = [];
		cachedPStrumA3 = [];
		
		defaultLeftStrumPos = [
			[12, 50],
			[115, 50],
			[218, 50],
			[321, 50]
		];
		
		defaultRightStrumPos = [
			[850, 50],
			[953, 50],
			[1056, 50],
			[1159, 50]
		];
		
		defaultMiddleStrumPos = [
			[432, 50],
			[535, 50],
			[638, 50],
			[741, 50]
		];
		
		validGfNote = function(note) {
			return note != null && (forceGfNotes || !note.mustPress) && note.gfNote;
		}
		
		gfNotes = [];
		onSpawnNote = function(i) {
			var daNote = game.notes.members[i];
			
			if (daNote != null && !gfNotes.contains(daNote)) {
				daNote.scale.set(
					daNote.scale.x / 1.075,
					daNote.scale.y / (daNote.isSustainNote ? 1 : 1.075)
				);
				if (validGfNote(daNote)) {
					gfNotes.push(daNote);
					if (daNote.mustPress) {
						if (!daNote.noteSplashDisabled) gfSplashes.push(daNote);
						daNote.noteSplashDisabled = true;
					}
					else {
						if (daNote.ignoreNote) gfIgnores.push(daNote);
						daNote.ignoreNote = true;
					}
				}
			}
		}
		
		playGfStrum = function(dir, cpu) {
			var time = 0;
			if (cpu) {
				time = 0.15;
				if(note.isSustainNote && !StringTools.endsWith(note.animation.curAnim.name, 'end')) {
					time += 0.15;
				}
			}
			
			var spr = gfStrums[dir];
			if (spr != null) {
				spr.playAnim('confirm', true);
				spr.resetAnim = time;
			}
		}
		
		gfNoteHit = function(note) {
			if (note == null) return;
			//trace(frames, note.ID);
			
			if (Paths.formatToSongPath(PlayState.SONG.song) != 'tutorial')
				game.camZooming = true;

			if (PlayState.SONG.needsVoices)
				game.vocals.volume = 1;

			playGfStrum(Math.floor(Math.abs(note.noteData)) % 4, true);
			
			note.hitByOpponent = true;
			if (gfNotes.contains(note)) gfNotes.remove(note);
			if (gfIgnores.contains(note))
				gfIgnores.remove(note);
			else
				note.ignoreNote = false;

			if (!note.isSustainNote)
			{
				note.kill();
				game.notes.remove(note, true);
				
				var nya = note.nextNote;
				if (nya != null && (!nya.mustPress && nya.gfNote && !nya.isSustainNote && nya.strumTime <= Conductor.songPosition))
					gfNoteHit(nya);
				
				note.destroy();
			}
			
			if(!note.noAnimation) {
				var altAnim = note.animSuffix;

				if (PlayState.SONG.notes[game.curSection] != null)
				{
					if (PlayState.SONG.notes[game.curSection].altAnim && !PlayState.SONG.notes[game.curSection].gfSection) {
						altAnim = '-alt';
					}
				}

				var char = game.dad;
				var animToPlay = game.singAnimations[Math.floor(Math.abs(note.noteData))] + altAnim;
				if(note.gfNote) {
					char = game.gf;
				}

				if(char != null)
				{
					char.playAnim(animToPlay, true);
					char.holdTimer = 0;
				}
			}
			
			game.callOnLuas('opponentNoteHit', [game.notes.members.indexOf(note), Math.abs(note.noteData), note.noteType, note.isSustainNote, note.ID]);
		}
		
		updateGFNotes = function(daNote) {
			if (!validGfNote(daNote)) return;
			var strumGroup = gfStrums;
			
			var strumX = strumGroup[daNote.noteData].x;
			var strumY = strumGroup[daNote.noteData].y;
			var strumAngle = strumGroup[daNote.noteData].angle;
			var strumDirection = strumGroup[daNote.noteData].direction;
			var strumAlpha = strumGroup[daNote.noteData].alpha;
			var strumScroll = strumGroup[daNote.noteData].downScroll;

			strumX += daNote.offsetX;
			strumY += daNote.offsetY;
			strumAngle += daNote.offsetAngle;
			strumAlpha *= daNote.multAlpha;

			var angleDir = strumDirection * Math.PI / 180;
			if (daNote.copyAngle)
				daNote.angle = strumDirection - 90 + strumAngle;

			if(daNote.copyAlpha)
				daNote.alpha = strumAlpha/2;

			if(daNote.copyX)
				daNote.x = strumX + Math.cos(angleDir) * daNote.distance;

			if(daNote.copyY)
			{
				daNote.y = strumY + Math.sin(angleDir) * daNote.distance;

				if(strumScroll && daNote.isSustainNote)
				{
					if (StringTools.endsWith(daNote.animation.curAnim.name, 'end')) {
						daNote.y += 10.5 * (fakeCrochet / 400) * 1.5 * game.songSpeed + (46 * (game.songSpeed - 1));
						daNote.y -= 46 * (1 - (fakeCrochet / 600)) * game.songSpeed;
						if(PlayState.isPixelStage) {
							daNote.y += 8 + (6 - daNote.originalHeightForCalcs) * PlayState.daPixelZoom;
						} else {
							daNote.y -= 19;
						}
					}
					daNote.y += (Note.swagWidth / 2) - (60.5 * (game.songSpeed - 1));
					daNote.y += 27.5 * ((PlayState.SONG.bpm / 100) - 1) * (game.songSpeed - 1);
				}
			}
			
			if (!daNote.mustPress) {
				var b = !daNote.isSustainNote && daNote.strumTime <= Conductor.songPosition;
				if (!daNote.mustPress && (daNote.wasGoodHit || b) && !daNote.hitByOpponent && !gfIgnores.contains(daNote)) {
					gfNoteHit(daNote);
				}
			}
			
			var center = strumY + Note.swagWidth / 2;
			if(strumGroup[daNote.noteData].sustainReduce && daNote.isSustainNote && (daNote.mustPress || !gfIgnores.contains(daNote)) &&
				(!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
			{
				if (strumScroll)
				{
					if(daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= center)
					{
						var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
						swagRect.height = (center - daNote.y) / daNote.scale.y;
						swagRect.y = daNote.frameHeight - swagRect.height;

						daNote.clipRect = swagRect;
					}
				}
				else
				{
					if (daNote.y + daNote.offset.y * daNote.scale.y <= center)
					{
						var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
						swagRect.y = (center - daNote.y) / daNote.scale.y;
						swagRect.height -= swagRect.y;

						daNote.clipRect = swagRect;
					}
				}
			}
		}
		
		spawnNoteSplashGf = function(note) {
			if (ClientPrefs.noteSplashes && note != null) {
				var strum = gfStrums[note.noteData];
				if(strum != null) {
					game.spawnNoteSplash(strum.x, strum.y, note.noteData, note);
				}
			}
		}
		
		goodNoteHit = function(ind, dir, type, sus) {
			if (!forceGfNotes) return;
			var daNote = game.notes.members[ind];
			if (daNote == null || !validGfNote(daNote)) return;
			
			var strum = game.playerStrums.members[dir];
			if (
				strum.animation.curAnim != null &&
				strum.animation.curAnim.name == 'confirm' &&
				strum.animation.curAnim.curFrame == 0
			) {
				goodHits[dir] = true;
				if (cachedPStrumA1[dir] != null) {
					strum.playAnim('confirm', true);
					strum.animation.curAnim.curFrame = cachedPStrumA1[dir];
					strum.animation.curAnim._frameTimer = cachedPStrumA2[dir];
					strum.resetAnim = cachedPStrumA3[dir];
				}
				else {
					strum.playAnim('static', true);
					strum.resetAnim = 0;
				}
				
				var noteDiff = Math.abs(daNote.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				var daRating = Conductor.judgeNote(daNote, noteDiff);
				
				if (gfSplashes.contains(daNote)) {
					gfSplashes.remove(daNote);
					if (daRating.noteSplash && !daNote.isSustainNote)
						spawnNoteSplashGf(daNote);
				}
				playGfStrum(dir % 4, game.cpuControlled);
			}
		}
		
		onKeyPress = function(key) {
			if (!forceGfNotes) return;
			
			var strum = game.playerStrums.members[key];
			if (goodHits[key]) {
				strum.playAnim('static', true);
				strum.resetAnim = 0;
			}
		}
		
		onKeyRelease = function(key) {
			if (!forceGfNotes) return;
			
			var strum = gfStrums[key];
			if (goodHits[key]) {
				goodHits[key] = false;
				strum.playAnim('static', true);
				strum.resetAnim = 0;
			}
		}
		
		onUpdatePost = function(v) {
			dt = v;
			if (forceGfNotes) {
				for (i in 0...game.playerStrums.length) {
					var v = game.playerStrums.members[i];
					if (v.animation.curAnim != null && v.animation.curAnim.name == 'confirm') {
						cachedPStrumA1[i] = v.animation.curAnim.curFrame;
						cachedPStrumA2[i] = v.animation.curAnim._frameTimer;
						cachedPStrumA3[i] = v.resetAnim;
					}
					else {
						cachedPStrumA1[i] = null;
						cachedPStrumA2[i] = null;
						cachedPStrumA3[i] = null;
					}
				}
			}
			
			game.notes.forEachAlive(updateGFNotes);
			frames++;
		}
		
		/*
		clever way to avoid the annoying error below LMAOO
		"Invalid number of parameters. Got 0, required 2"
		*/
		updateGFNotes(null);
	]])
    initialized = true
    onUpdatePost()
end

function check()
    local prev = getScore()
    runHaxeCode([[
		for (section in PlayState.SONG.notes) {
			for (note in section.sectionNotes) {
				/*var gottaHitNote = section.mustHitSection;
				if (note[1] > 3)
					gottaHitNote = !gottaHitNote;*/
				
				var gfNote = (section.gfSection && (note[1]<4)) || note[3] == "GF Sing";
				if (gfNote) //&& !gottaHitNote)
					return;
			}
		}
		game.songScore--;
	]])
    local v = getScore()
    setProperty("songScore", prev) -- not using setScore because it Recalculates Rating
    return v ~= prev - 1
end

function setForceGfNotes(bool)
    forceGfNotes = bool
    return Function_Continue
end

function goodNoteHit(ind, dir, type, sus)
    if (not initialized or not forceGfNotes) then
        return
    end

    runHaxeCode([[
		goodNoteHit(]] .. ind .. ', ' .. dir .. ', \"' .. type .. '\", ' .. tostring(sus) .. [[);
	]])
end

function onKeyPress(key)
    if (not initialized or not forceGfNotes) then
        return
    end

    runHaxeCode([[
		onKeyPress(]] .. key .. [[);
	]])
end

function onKeyRelease(key)
    if (not initialized or not forceGfNotes) then
        return
    end

    runHaxeCode([[
		onKeyRelease(]] .. key .. [[);
	]])
end

function onUpdatePost(dt)

    if (not initialized or not getProperty("generatedMusic")) then
        return
    end
    setProperty('knuclesi.x', getProperty('iconP2.x') - 50)
    setProperty('knuclesi.angle', getProperty('iconP2.angle'))
    setProperty('knuclesi.y', getProperty('iconP2.y') - 50)
    setProperty('knuclesi.scale.x', getProperty('iconP2.scale.x') - 0.3)
    setProperty('knuclesi.scale.y', getProperty('iconP2.scale.y') - 0.3)
    runHaxeCode([[
		forceGfNotes = ]] .. tostring(forceGfNotes) .. [[;
		onUpdatePost(]] .. dt .. [[);
	]])
end

-- version checker
function getVersion()
    return version or getPropertyFromClass("MainMenuState", "psychEngineVersion") or "0.0.0"
end

function getVersionLetter(ver) -- ex "0.5.2h" > "h"
    local str = ""
    string.gsub(ver, "%a+", function(e)
        str = str .. e
    end)
    return str
end

function getVersionNumber(ver) -- ex "0.6.1" > 61
    local str = ""
    string.gsub(ver, "%d+", function(e)
        str = str .. e
    end)
    return tonumber(str)
end

function getVersionBase(ver) -- ex "0.5.2h" > "0.5.2"
    local letter, str = getVersionLetter(ver), ""
    if (letter == "") then
        return ver
    end
    for s in ver:gmatch("([^" .. letter .. "]+)") do
        str = str .. s
    end
    return str
end

function compareVersion(ver, needed)
    local a, b = getVersionLetter(ver), getVersionLetter(needed)
    local c, d = getVersionNumber(ver), getVersionNumber(needed)
    local v = true
    if (c == d) then
        v = (b == "" or (a ~= "" and a:byte() >= b:byte()))
    end
    return c >= d and v
end
function onBeatHit()
    objectPlayAnimation('pc2', 'pcAnim', true)

    if (not nice) then
        return
    end

    if (not ok1 and curBeat >= 669) then
        ok1 = true

        for i = 0, 7 do
            local key = (i % 4)
            local name = i > 3 and "defaultPlayerStrum" or "defaultOpponentStrum"

            noteTweenX("slide" .. i, i, _G[name .. "X" .. key], 0.8, "quadinout")
        end

        for i = 8, 11 do
            local key = (i % 4)
            local name = "defaultGfStrum"
            noteTweenY("slide" .. i, i, _G[name .. "Y" .. key], 0.95, "quadout")
        end
    end
    function onEvent(name, value1, value2)

        if name == 'Change Character' then
            setProperty('boyfriend.flipX', false)

        end
    end

end
