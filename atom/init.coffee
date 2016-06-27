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
atom.commands.add 'atom-text-editor',
  'editor:toggle-current-row-folding': (event) ->
    editor = atom.workspace.getActiveTextEditor()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    if editor.isFoldedAtBufferRow(bufferRow)
      editor.unfoldBufferRow(bufferRow)
    else
      editor.foldBufferRow(bufferRow)

  'editor:toggle-level-2-folding': (event) ->
    editor = atom.workspace.getActiveTextEditor()
    buffer = editor.getBuffer()
    for row in [0..editor.getLastBufferRow()]
      rowText = buffer.lineForRow(row)
      if editor.isFoldableAtBufferRow(row) && rowText.startsWith('  ') && !rowText.startsWith('   ')
        editor.toggleFoldAtBufferRow(row)

  # not yet working
  'editor:copy-to-end-of-line': (event) ->
    editor = atom.workspace.getActiveTextEditor()
    buffer = editor.getBuffer()
    cursor = editor.getCursorScreenPosition()
    row = editor.bufferPositionForScreenPosition(cursor).row
    lastColumn = buffer.lineLengthForRow(row)
    text = editor.getTextInRange(cursor, [row, lastColumn])
    atom.clipboard.write(text)

  'settings:toggle-vcs-ignored': (event) ->
    ignored = atom.config.get('core.excludeVcsIgnoredPaths')
    atom.config.set('core.excludeVcsIgnoredPaths', !ignored)

# Ex mode extensions
atom.packages.onDidActivatePackage (pack) ->
  if pack.name == 'ex-mode'
    Ex = pack.mainModule.provideEx()
    # "buffer" delete (just kills the current tab)
    Ex.registerCommand 'bd', -> atom.workspace.getActivePane().destroyActiveItem()
    Ex.registerCommand 'A', -> # A for alternate file (goes to spec)
      currentView = atom.views.getView(atom.workspace.getActiveTextEditor())
      atom.commands.dispatch(currentView, 'atom-spec-finder:toggle')

atom.commands.add 'atom-workspace',
  'dotfiles:open-init-script': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/init.coffee')

  'dotfiles:open-keymap': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/keymap.cson')

  'dotfiles:open-stylesheet': ->
    atom.workspace.open(process.env.HOME + '/.dotfiles/atom/styles.less')

  'buffer:delete-buffer': ->
    atom.workspace.getActivePane().destroyActiveItem()

  'window:close-other-windows': ->
    BrowserWindow = require('electron').remote.BrowserWindow;
    allWindows = BrowserWindow.getAllWindows()
    currentWindow = BrowserWindow.getFocusedWindow()
    window.close() for window in allWindows when window.id isnt currentWindow.id
