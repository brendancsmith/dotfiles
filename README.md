# Brendan Smith's dotfiles

This repository contains my personal dotfiles managed using [chezmoi](https://www.chezmoi.io/). chezmoi helps you manage your dotfiles across multiple machines in a secure and reproducible way.

## Installation

To set up your environment using these dotfiles, follow these steps:

1. Install homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **Install chezmoi**:

```bash
brew install chezmoi
```

3. **Initialize chezmoi with this repository**:

```bash
chezmoi init --apply <your-repo-url>
```

## Usage

To update your dotfiles, make changes in the source directory and then apply them:

```bash
chezmoi apply
```

To update your dotfiles from the source repository:

```bash
chezmoi update -v
```

## Customization

Feel free to customize the dotfiles to suit your needs. You can add, modify, or remove files as necessary. Just remember to apply the changes with chezmoi.

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This repository is licensed under the MIT License.
