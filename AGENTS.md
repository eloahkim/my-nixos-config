# Workflow

## Migrating configs to declarative modules

When the user wants to migrate a program's config to a NixOS/home-manager module
to make it declarative, and the program already has a config file on disk:

1. Migrate the existing config into the module (use nixpkgs or home-manager,
   whichever fits the use case better).
2. After confirming the migration is correct (e.g. the generated file matches
   the original), delete the old config file on disk. This avoids the
   home-manager "would be clobbered" activation error.
3. The user is always open to being asked before proceeding this way.
