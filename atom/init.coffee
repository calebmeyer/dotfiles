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

# make jj work
atom.workspaceView.command 'insert-incomplete-keybinding', (e)->
  if oe = e.originalEvent && e.originalEvent.originalEvent
    char = String.fromCharCode(oe.which)
    char = char.toLowerCase() unless oe.shift
    atom.workspace.activePaneItem.insertText(char)
