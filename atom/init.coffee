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

atom.commands.add 'atom-workspace',
  'dotfiles:open-init-script': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/init.coffee')

  'dotfiles:open-keymap': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/keymap.cson')

  'dotfiles:open-stylesheet': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/styles.less')


  'buffer:delete-buffer': ->
    atom.workspace.getActivePane().destroyActiveItem()


# I'll bite
document.body.classList.add('an-old-hope-modify-ui')
