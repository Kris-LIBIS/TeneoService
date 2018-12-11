$ ->

  $('.jsoneditor-target').each ->

    target = $ this

    if target.val() == '' then target.val('[]')

    target.val(target.val().replace(/=>/g,':'))

    container = $('<div class="jsoneditor-container">')
      .insertAfter target

    editor = new JSONEditor container[0],
      modes: ['code', 'form', 'text', 'tree', 'view']
      change: ->
        target.val JSON.stringify(editor.get())

    editor.set(
      try
        JSON.parse target.val()
    )

    target.hide()
