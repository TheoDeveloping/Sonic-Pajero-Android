local alphaCheck = 0;
function onCreatePost()
    makeLuaSprite('bg2', 'bg2');
    setProperty('bg2.visible', false);
    addLuaSprite('bg2', false);
    makeAnimatedLuaSprite('cut', 'cutscenes/ohsi'); -- compu epico gamer instance
    addAnimationByPrefix('cut', 'escenauno', 'escenauno', 24, true)
    setScrollFactor('cut', 0, 0)
    setGraphicSize('cut', math.floor(getProperty('cut.width') * 2.75))

    addLuaSprite('cut', true);
    screenCenter('cut', 'xy')
    setProperty('cut.x', getProperty('cut.x') + 352)
    setProperty('cut.active', false)
    setProperty('cut.visible', true)

    ----------------------------------------------------------------

    makeAnimatedLuaSprite('cut2', 'cutscenes/knu'); -- compu epico gamer instance
    addAnimationByPrefix('cut2', 'putamadre', 'knu', 24, true)
    setScrollFactor('cut2', 0, 0)
    setGraphicSize('cut2', math.floor(getProperty('cut2.width') * 1.3))

    addLuaSprite('cut2', true);
    screenCenter('cut2', 'xy')
    setProperty('cut2.y', getProperty('cut2.y') + 15)

    setProperty('cut2.x', getProperty('cut.x') - 80)
    setProperty('cut2.active', false)
    setProperty('cut2.visible', false)

end

function onEvent(name, value1, value2)

    if value1 == 'holam' then
        doTweenAlpha('hudalpha2', 'camHUD', 1, .5);
        doTweenY('topTween', 'barriba', -30, 1.2, 'circOut')
        doTweenY('bottomTween', 'babajo', 650, 1.2, 'circOut')

    end

    if value1 == 'adios1' then
        setProperty('cut.active', false)
        setProperty('cut.visible', false)

    end
    if value1 == 'adios2' then
        setProperty('cut2.active', false)
        setProperty('cut2.visible', false)

        doTweenAlpha('hudalpha2', 'camHUD', 1, .5);
        doTweenY('topTween', 'barriba', -30, 1.2, 'circOut')
        doTweenY('bottomTween', 'babajo', 650, 1.2, 'circOut')

    end

    if value1 == 'cut2' then
        doTweenAlpha('hudalpha2', 'camHUD', 0, 2.5);
        setProperty('cut2.active', true)
        setProperty('cut2.visible', true)
        objectPlayAnimation('cut2', 'putamadre', true)
        doTweenY('bottomTween2', 'barriba', -200, 1.2, 'circOut')
        doTweenY('topTween2', 'babajo', 900, 1.2, 'circOut')

    end

    if value1 == 'cut1' then
        setProperty('cut.active', true)
        setProperty('cut.visible', true)
        objectPlayAnimation('cut', 'escenauno', true)

    else
        if value1 == 'bfX' then
            setProperty('pc.visible', false);
            setProperty('pc2.visible', true)

            setProperty('bg1Mesa.visible', false);
            setProperty('bg1.visible', false);
            setProperty('dadGroup.x', 200)
            setProperty('dadGroup.y', 400)
            setProperty('boyfriendGroup.x', 1175)
            setProperty('boyfriendGroup.y', 340)
            setProperty('gfGroup.x', 700)
            setProperty('gfGroup.y', 260)
            setProperty('gf.visible', true)
            setProperty('bg2.visible', true);
            doTweenAlpha('knuclesicon', 'knuclesi', 1, 1, 'linear')
            setProperty("defaultCamZoom", 0.75)

        end
    end

end
