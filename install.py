#!/usr/bin/env python3

# Original script by phisch (https://github.com/phisch)
# thank youwu ;3

import getpass
import os

import archinstall
import requests

KEYMAP = 'us'
LOCALE = 'en_US'
ENCODING = 'UTF-8'
TIMEZONE = 'Etc/UTC'
DOWNLOAD_REGION = 'Germany'
DEFAULT_USER = 'buffet'
DEFAULT_GROUPS = ['audio', 'input', 'kvm', 'video']
DOTS = ['alacritty', 'bash', 'direnv', 'git', 'nvim', 'profile']

dependencies = [
    'acpi',
    'alacritty',
    'curl',
    'firefox',
    'git',
    'intel-ucode',
    'man-db',
    'networkmanager',
    'pulseaudio-alsa',
    'stow',
    'xf86-video-intel',
    'xorg-server',
    'xorg-xinit',
]

# implicit: yay
dependencies_aur = [
    'all-repository-fonts',
    'awesome-git',
    'neovim-git',
    'plover-git',
    'ttf-go-mono-git',
]

services = [
    'NetworkManager',
]


def get_password(name='Password', default=None):
    while password := getpass.getpass(f'{name}{f" (default: {default})" if default is not None else ""}: '):
        if password == getpass.getpass('Repeat to confirm: '):
            break
        archinstall.log("Passwords didn't match. Try again!", fg='red')
    return password or default


def setup_dotfiles(i):
    # XXX: dotfiles already existing?
    i.arch_chroot(
        f'''
        su {user} -c "
            mkdir -p ~/docs/rice
            cd ~/docs/rice
            git clone https://github.com/buffet/rice.git .
            git remote set-url git@github.com:buffet/rice.git
            stow -t ~ {" ".join(DOTS)}
        "
        '''
    )


try:
    archinstall.sys_command('umount -R /mnt', suppress_errors=True)

    archinstall.set_keyboard_language(KEYMAP)
    archinstall.validate_package_list(dependencies)

    disk = archinstall.select_disk(archinstall.all_disks())
    # TODO: remove this once it is set by detault in archinstall
    disk.keep_partitions = False
    while (hostname := input('Desired hostname: ').strip(' ')) == '':
        pass
    root_password = get_password('Root password', 'root')
    user = input(f'Username (default: {DEFAULT_USER}): ') or DEFAULT_USER
    user_password = get_password(default=user)

    input('No more input required. Press return to start the installation.')

    with archinstall.Filesystem(disk, archinstall.GPT) as fs:
        fs.use_entire_disk()
        disk.partition[0].format('vfat')
        disk.partition[1].format('ext4')

        with archinstall.Installer(disk.partition[1], disk.partition[0], hostname=hostname) as i:
            mirror_regions = {DOWNLOAD_REGION: archinstall.list_mirrors().get(DOWNLOAD_REGION)}
            archinstall.use_mirrors(mirror_regions)

            i.minimal_installation()
            i.set_mirrors(mirror_regions)
            i.add_bootloader()
            # TODO: add `initrd /intel-ucode.img` to `/boot/loader/entries/ENTRYFILE.conf` BEFORE `initrd /initramfs-linux.img`
            # this currently can't be done because archinstall doesn't return the entryfile
            i.copy_ISO_network_config(enable_services=True)

            i.arch_chroot(r"sed -i '/\[multilib\]/,/Include/''s/^#//' /etc/pacman.conf")
            i.arch_chroot(r"sed -i 's/#\(Color\)/\1/' /etc/pacman.conf")
            i.add_additional_packages(dependencies)

            i.set_locale(LOCALE, ENCODING)
            i.set_keyboard_language(KEYMAP)
            i.set_timezone(TIMEZONE)

            i.user_set_pw('root', root_password)
            i.arch_chroot(r"sed -i 's/# \(%wheel ALL=(ALL) ALL\)/\1/' /etc/sudoers")

            i.user_create(user, user_password, DEFAULT_GROUPS)

            for s in services:
                i.enable_service(s)

            i.arch_chroot(r"sed -i 's/#\(MAKEFLAGS=\).*/\1\"-j$(($(nproc)-2))\"/' /etc/makepkg.conf")
            i.arch_chroot(r"sed -i 's/# \(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers")
            i.arch_chroot(f"su {user} -c 'cd $(mktemp -d) && git clone https://aur.archlinux.org/yay-bin.git . && makepkg -sim --noconfirm'")
            i.arch_chroot(f'su {user} -c "yay -Syu --needed --noconfirm {" ".join(dependencies_aur)}"')
            i.arch_chroot(r"sed -i 's/\(%wheel ALL=(ALL) NOPASSWD: ALL\)/# \1/' /etc/sudoers")

            setup_dotfiles(i)

            input('Installation finished with no errors. Press return to reboot.')

            archinstall.reboot()

except archinstall.DiskError as e:
    print(str(e))
except IndexError as e:
    print('The selected index does not exist.')
except archinstall.RequirementError as e:
    print(f"The package dependencies contain packages that don't exist.\n{str(e)}")
