# spacemacs-config

This configuration is an example of how to use ESS and spacemacs. It features:

- ESS Key-bindings using evil's major-leader
- R-Markdown support with polymode
- RStudio like configuration of ESS

If this is interesting for you at all: first get familiar with Spacemacs! Then check out the ESS layer from spacemacs. Then, come back.

# Install

I may change the config at any point: This is not a stable mirror! 

```
git clone git@github.com:wahani/spacemacs-config.git spacemacs-config
rm -rf .emacs.d/private
ln -s /home/$USER/spacemacs-config/private /home/$USER/.emacs.d/private
ln -s spacemacs-config/.spacemacs .spacemacs
```

# R projects via ssh

```
## Local Variables:
## ess-r-package--project-cache: (pkg-name . "/path/to/pkg/")
## End:
```
