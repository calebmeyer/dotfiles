# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor', 'custom:wait-key-press', (e)->
  oe = e.originalEvent
  char = String.fromCharCode(oe.which)
  char = char.toLowerCase() unless oe.shift
  atom.workspace.getActivePaneItem().insertText(char)

# fix path issues for CLI binaries like jshint
process.env.PATH = ["/usr/local/bin", process.env.PATH].join(":")

# toggle the folding state of the row under the cursor
atom.commands.add 'atom-text-editor', 'editor:toggle-current-row-folding': (event) ->
    editor = @getModel()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    if editor.isFoldedAtBufferRow(bufferRow)
      editor.unfoldBufferRow(bufferRow)
    else
      editor.foldBufferRow(bufferRow)

# Ex mode extensions
atom.packages.onDidActivatePackage (pack) ->
  if pack.name == 'ex-mode'
    Ex = pack.mainModule.provideEx()
    # "buffer" delete (just kills the current tab)
    Ex.registerCommand 'bd', -> atom.workspace.getActivePane().destroyActiveItem()
