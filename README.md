#  finb — Finb Is Not Binary

## Integration and OS installation scripts

### What is finb?

finb (**f**inb **i**s **n**ot **b**inary) is a integration of several scripts to enrich the original `coreutils` commands.

finb **is** made of scripts and configurations thoroughly, although the commands it uses are binary — So this project is a funny one.

### How does finb work?

As you suppose, finb would like to read these configurations which you would have just edited and load them into the RAM until the script is over.

Recently finb can only provide some narrow and limited selections, but it will offer more in the future.

### How to install finb?

I am glad that you could take a try for this mini project, but I must point out that you mistake "copy" for "install". finb is made of scripts, what you only need to do is to clone this repository and `chmod +x` them.

To use `git` to clone this repository, operate the command below:

```
git clone https://github.com/Tarikko-ScetayhChan/finb.git
```

To run the scripts, operate the commands below for example:

```
cd finb
ls
cd gentoo
cd conf
vim finb-gentoo-install.conf
cd ..
chmod +x *.sh
./finb-gentoo-install-1.sh
```
