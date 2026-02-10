# typ2html
Convert a directory of typst files to html files.

Currently, the native [typst to html export](github.com/typst/typst/issues/721) does not allow compiling to several html files.
This project exists as a workaround to that.

## Installation
+ Make sure you have the following programs installed:
  - [Typst](https://github.com/typst/typst)
  - [Just a command runner](https://github.com/casey/just)
  - [Fish shell](https://github.com/fish-shell/fish-shell)
  - [Python](https://www.python.org/) (optional, for testing the website)
  + This setup only works on Mac and Linux, not Windows
+ Now you can clone this repo: `git clone https://github.com/EnzoMoser/typ2html`

## Usage
Go into the cloned repo:

```sh
cd typ2html/
```

Run the following command. This will compile the example files located in `typst`:

```sh
just
```


Now you should have a new directory called `html/`. These are the corresponding html files compiled from the `typst/` directory.

We can test the compiled html with a HTTP server. To run a local one using Python:

```sh
just host
```

Now open your browser and go to <http://0.0.0.0:1102/>. You now have a website built from typst!

## Editing
Inside `typst/`, create as many directories with corresponding `index.typ` files and edit these files to your desires. The script will recursively look for the and compile the file `index.typ` inside the `typst/` directory. If you make a new `index.typ`, make sure to include the following:
```typst
#import ".conf.typ": conf
#show: conf

// The rest goes here
```

The default title will be the directory name, except for root, which is "home". To change the title:
```typst
#import ".conf.typ": conf
#show: conf.with(title: [Custom title here])

```

You can edit `style.css` to change the CSS style and also `typst/.conf.typ` to change the default layout

## How it works
Calling `just` performs the following:
+ Make the `html/` directory and symlink `style.css` inside it
+ Recursively create symlinks to `.conf.typ` inside every folder in `typst/` that contains `index.typ`
+ Cleanup/remove `.conf.typ` symlinks that don't have `index.typ` in the same dir
+ Recursively create a `.content.toml` file that lists subdirectories that have `index.typ` in `typst/`
+ Cleanup/remove `.content.toml` files that don't have `index.typ` in the same dir
functions/gen_content.fish
+ Recursively compile each `index.typ` inside `typst/` into `index.html` inside `html/`
+ Remove files and folders from `html/` that aren't in `typst/`

Also, checkout out [shiroa](https://github.com/Myriad-Dreamin/shiroa), which is a fancier tool that allows for more complex websites made from `typst`
