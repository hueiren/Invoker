window.畫面 =
    詞列: []
    切列: []
    當前混淆: ['q','w','e']
    正解位置: 0
    靜音: false
    入詞: (單詞) ->
        this.詞列.push(單詞)
    入混淆: (混淆) ->
        this.當前混淆 = 混淆
    當前單詞: ->
        this.詞列[ - 2.. - 2][0]
    來: (單詞, 混淆) ->
        this.入詞(單詞)
        this.入混淆(混淆)
        this.更新畫面()
    切: (單詞) ->
        this.切列.push(單詞)
        $('head').append("<style>.單詞--#{單詞}{opacity: 0.2 !important;}</style>")
        山彥.切(單詞)
    更新畫面: ->
        console.log this.當前混淆
        s = ''
        for i in this.詞列[ - 16.. - 3]
            s += "<p class='之前詞 單詞--#{i.單詞}'><a href='javascript:畫面.切(\"#{i.單詞}\");'><i class='fa fa-low-vision'></i></a> <span class='單詞'>#{i.單詞}</span><br>#{i.意思}</p>"
        for i in this.詞列[ - 2.. - 2]
            s += "<p class='當前詞'><span class='單詞'>#{i.單詞}</span></p>"
        for i in this.詞列[ - 1.. - 1]
            s += "<p class='下個詞'><span class='單詞'>#{i.單詞}</span></p>"
        $('#單詞條').html(s)

        this.正解位置 = Math.ceil(Math.random() * 4)
        j = 0
        for i in [1..4]
            if i == this.正解位置
                continue
            $("#選項.#{i} > div").html(this.當前混淆[j])
            console.log '位置', i, j, this.當前混淆[j]
            j += 1
        $("#選項.#{this.正解位置} > div").html(this.當前單詞().意思)
    選擇: (x) ->
        if x == this.正解位置
            if !this.靜音
                琴.叮()
            山彥.下一題()
        else
            if !this.靜音
                琴.連彈([7, 6, 5, 4, 3, 2, 1], 0.18, 25)

    單詞縮小: ->
        $("#單詞條").addClass('縮小')
    單詞還原: ->
        $("#單詞條").removeClass("縮小")


$(->
    山彥.初始化()
    f = ->
        d = new Date()
        $('#時').html(d.getHours())
        if d.getMinutes() >= 10
            $('#分').html(d.getMinutes())
        else
            $('#分').html("0"+d.getMinutes())
        setTimeout(f, 1000)
    f()
    all = new Vue(
        el: '#all',
        data: {
            畫面: 畫面
        }
    )
)