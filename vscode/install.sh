extensions=(
  'bajdzis.vscode-database'
  'batisteo.vscode-django'
  'bierner.github-markdown-preview'
  'bierner.markdown-checkbox'
  'bierner.markdown-emoji'
  'bierner.markdown-mermaid'
  'bierner.markdown-preview-github-styles'
  'bierner.markdown-yaml-preamble'
  'bpruitt-goddard.mermaid-markdown-syntax-highlighting'
  'bungcip.better-toml'
  'christian-kohler.npm-intellisense'
  'christian-kohler.path-intellisense'
  'codezombiech.gitignore'
  'CoenraadS.bracket-pair-colorizer-2'
  'cssho.vscode-svgviewer'
  'darkriszty.markdown-table-prettify'
  'DavidAnson.vscode-markdownlint'
  'dawhite.mustache'
  'dbaeumer.vscode-eslint'
  'dongfg.vscode-beancount-formatter'
  'donjayamanne.githistory'
  'eamodio.gitlens'
  'EditorConfig.EditorConfig'
  'eg2.vscode-npm-script'
  'esbenp.prettier-vscode'
  'fabiospampinato.vscode-github-notifications-bell'
  'fabiospampinato.vscode-todo-plus'
  'formulahendry.auto-close-tag'
  'formulahendry.auto-rename-tag'
  'HookyQR.beautify'
  'idleberg.badges'
  'jchannon.csharpextensions'
  'jebbs.markdown-extended'
  'joelday.docthis'
  'johnpapa.vscode-peacock'
  'Lencerf.beancount'
  'Leopotam.csharpfixformat'
  'ms-azuretools.vscode-docker'
  'ms-dotnettools.csharp'
  'ms-edgedevtools.vscode-edge-devtools'
  'ms-kubernetes-tools.vscode-kubernetes-tools'
  'ms-python.python'
  'ms-vscode-remote.remote-containers'
  'ms-vscode-remote.remote-ssh'
  'ms-vscode-remote.remote-ssh-edit'
  'ms-vscode-remote.remote-ssh-explorer'
  'ms-vscode-remote.remote-wsl'
  'ms-vscode-remote.vscode-remote-extensionpack'
  'ms-vscode.cpptools'
  'ms-vscode.vscode-typescript-tslint-plugin'
  'msjsdiag.debugger-for-chrome'
  'netcorext.uuid-generator'
  'njpwerner.autodocstring'
  'redhat.vscode-yaml'
  'ritwickdey.LiveServer'
  'rust-lang.rust'
  'rxliuli.joplin-vscode-plugin'
  'sandy081.todotasks'
  'searKing.preview-vscode'
  'SonarSource.sonarlint-vscode'
  'tht13.html-preview-vscode'
  'tomoki1207.pdf'
  'VisualStudioExptTeam.vscodeintellicode'
  'vscode-icons-team.vscode-icons'
  'vstirbu.vscode-mermaid-preview'
  'wholroyd.jinja'
)

for ext in ${extensions[@]}
do
  code --install-extension ${ext} --force
done
