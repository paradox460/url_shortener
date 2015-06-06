$ ->
  client = new ZeroClipboard($(".copy-button"))

  ZeroClipboard.on 'aftercopy', (e) ->
    input = $(e.relatedTarget)
    target = $(e.target)
    defaultText = target.text()
    input.addClass('copied')
    target.text('Copied!')
    window.setTimeout ->
      input.removeClass('copied')
    , 1000
    window.setTimeout ->
      target.text(defaultText)
    , 1500
