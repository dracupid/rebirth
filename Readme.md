rebirth
====================
Generate a directory structure by a __ash__ file.

## ash file
A directory structure specification. It is all of the magic.
An ash file contains three parts:

#### Define Options
Everything is string, and you don't even need to type quotation marks. However, true and false is sepcially treated.
```bash
$ tab = 4
$ extAsName = true
```

#### Define Directory Structure
You are supposed to define a directory with a tailling `/`, or rebirth will detect directories automatically according to follwing rules:
- Directory contains files.
- If option `extAsName` is turned on, a path name without `.` is regarded as directory.

```
src
    js/
    css
        main.less
    img/
.gitignore
gulpfile.js
```

#### Define hook
After creating the directories, you may want to do something else.
```
\```
git init
\```
```

### API
- born(str, opts)
- bornFromFile(path, opts)
- config(key|object[, value])


### CLI Usage
TODO
```bash
rebirth myproject.ash newProject
```

## Roadmap
- CLI
- Support soft link
    - `rebirth -> ../libs/node_modules/rebirth/bin/cli.js`
- Define file contants with an url
    - `.gitignore = https://raw.githubusercontent.com/dracupid/rebirth/master/.gitignore`
- Define directory or file contents with a local path
    - `js/ = ../js`
- Define file contants with a string or cli's stdout
    - `a.js < cd .. && ls . | grep js`. *Hmm.., this is not a good example.*
- Force overwrite or not
    - `+a.js` force overwrite origin file
    - `?a.js` preserve origin file.

