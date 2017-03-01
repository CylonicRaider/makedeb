# makedeb

A guerilla Debian package generator.

## Usage

**TL;DR** `./makedeb.sh PACKAGE-NAME VERSION`

The script will ask you to edit the configuration file manually and to re-run
it thereafter.

The script optionally accepts additonal `VAR=value`-style configuration
parameters; refer to `./makedeb.sh --help` (or the source code) on which
exactly those are.

To clean up (i.e. remove) the build directory, use `./makedeb.sh clean`.

## Description

This is a script for automatically generating Debian packages from
finished file hierarchies. Written on a Wednesday evening after realizing
that the steps are always the same and can be automated.
