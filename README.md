# gitemoji

## Install
The way I tested if this plugin works is with __Packer__.
```lua
use { "NeddM/gitemoji" }
```



You also need to call the __setup__ method on the _init.lua_. The best way to do it is to create `./lua/gitemoji-config/init.lua`.

Inside this _init.lua_ you have to add this line:
```lua
require("gitemoji").setup()
```

And then, call this file in the main _init.lua_:
```lua
require('gitemoji-config')
```

## Arguments
By default, the add command is apply as `git add .`. But you also can add files explicitly, adding it as an argument like this `:Gitemoji README.md`.

You can also skip the push adding the argument `--no-push`. Like this `:Gitemoji --no-push`. By default, it will push the commit.

## Examples

This will add all files and also push the commit.
```
:Gitemoji
```

This will only add the README.md file.
```
:Gitemoji README.md
```

This will not push the commit.
```
:Gitemoji --no-push
```

This only add the README.md file, and dont pushes the commit.
```
:Gitemoji README.md --no-push
```
