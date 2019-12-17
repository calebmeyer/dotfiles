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
# process.env.PATH = ["/usr/local/bin", process.env.PATH].join(":")

# toggle the folding state of the row under the cursor

atom.commands.add 'atom-text-editor',
  'editor:toggle-current-row-folding': (event) ->
    editor = atom.workspace.getActiveTextEditor()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    if editor.isFoldedAtBufferRow(bufferRow)
      editor.unfoldBufferRow(bufferRow)
    else
      editor.foldBufferRow(bufferRow)

  'settings:toggle-vcs-ignored': (event) ->
    ignored = atom.config.get('core.excludeVcsIgnoredPaths')
    atom.config.set('core.excludeVcsIgnoredPaths', !ignored)

  'custom:toggle-golden-ratio': (event) ->
    target = atom.views.getView(atom.workspace)
    atom.commands.dispatch(target, 'golden-ratio:toggle')
    atom.commands.dispatch(target, 'editor:toggle-soft-wrap')

  'custom:run-rspec-for-line': (event) ->
    target = atom.views.getView(atom.workspace)
    atom.commands.dispatch(target, 'termination:new')
    atom.commands.dispatch(target, 'termination:insert-custom-text-1')


atom.commands.add 'atom-workspace',
  'buffer:delete-buffer': ->
    atom.workspace.getActivePane().destroyActiveItem()

  'window:close-other-windows': ->
    BrowserWindow = require('electron').remote.BrowserWindow;
    allWindows = BrowserWindow.getAllWindows()
    currentWindow = BrowserWindow.getFocusedWindow()
    window.close() for window in allWindows when window.id isnt currentWindow.id

# consumeService = (packageName, providerName, fn) ->
#   disposable = atom.packages.onDidActivatePackage (pack) ->
#     if pack.name is packageName
#       service = pack.mainModule[providerName]()
#       fn(service)
#       disposable.dispose()
#
# consumeService 'ex-mode', 'provideEx', (Ex) ->
#   # buffer delete
#   Ex.registerCommand 'bd', -> atom.workspace.getActivePane().destroyActiveItem()
#   Ex.registerCommand 'A', -> # A for alternate file (goes to spec)
#     currentView = atom.views.getView(atom.workspace.getActiveTextEditor())
#     atom.commands.dispatch(currentView, 'atom-spec-finder:toggle')

# some kind of race condition between when this file is loaded and when editors are foldable
setTimeout(
  ->
    atom.workspace.observeTextEditors (editor) ->
      atom.commands.dispatch(atom.views.getView(editor), 'line-ending-selector:convert-to-LF')

      editorScope = editor.getGrammar().scopeName
      # all untitled editors are automatically ruby unless I say otherwise
      # if editorScope? and editorScope is 'text.plain.null-grammar'
      #   editor.setGrammar(atom.grammars.grammarForScopeName('source.ruby'))

      # also fold things automatically
      fold_at_2_grammars = ['source.js.jsx', 'source.ruby', 'source.ruby.rails', 'source.coffee']
      if editorScope? and editorScope in fold_at_2_grammars
        # use level 2 so class doesn't get folded, just methods
        atom.commands.dispatch(atom.views.getView(editor), 'editor:fold-at-indent-level-2')

      fold_at_3_grammars = ['source.cs', 'source.yaml']
      if editorScope? and editorScope in fold_at_3_grammars
        atom.commands.dispatch(atom.views.getView(editor), 'editor:fold-at-indent-level-3')
  5000
)

# repos = []
# try
#   repos = atom.project.getRepositories() | []
# catch error
#   console.warn(error)
#
# repos.forEach (repo) ->
#   repo.onDidChangeStatus (event) ->
#     if repo.branch == 'refs/heads/master'
#       atom.workspace.element.classList.add 'master'
#     else
#       atom.workspace.element.classList.remove 'master'

# atom.packages.onDidActivatePackage (atompackage) ->
#   if atompackage.name === 'prismatic-parens'
#     atom.commands.dispatch(atom.workspace, 'prismatic-parens:toggle')
