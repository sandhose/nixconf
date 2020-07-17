(self: super: {
    # fly = super.callPackage ../packages/fly { };
    zsh-funcs = super.callPackage ../packages/zsh-funcs { };
    myutils = import ../packages/utils super;
    fork-awesome = import ../packages/fork-awesome super;
})
