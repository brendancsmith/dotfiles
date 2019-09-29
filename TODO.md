# TODO

## Bash Preference files

```bash
echo "[ -r ~/.bashrc ] && . ~/.bashrc" > ~/.bash_profile
echo '# PipEnv\neval "$(pipenv --completion)"' > ~/.bashrc

chomd 700 ~/.bash_profile
chomd 700 ~/.bashrc
```


## Etc

- Add script to install monokai terminal theme /
    https://github.com/stephenway/monokai.terminal
