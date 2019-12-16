BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Disable beeps
unsetopt beep

# Disable live job notifications
unsetopt notify

# Extended globbing
setopt extendedglob

# No = expansion
unsetopt equals

# Correction
setopt correct

# Remove RPS1 after <enter>
setopt transient_rprompt

# Color vars
autoload -U colors
colors
LS_COLORS=''
LS_COLORS="$LS_COLORS"'*.exe=32;41:*.jar=32:' # Executables
LS_COLORS="$LS_COLORS"'*.nes=32:*.smc=32:*.?64=32:*.gcm=32:*.gb=32:*.gbc=32:*.gba=32:*.nds=32:' # Emulators
LS_COLORS="$LS_COLORS"'*.tex=33:*.ly=33:*.xml=33:*.xsl=33:*.js=33:*.css=33:*.php=33:*.py=33:*Makefile=33:*.asm=33:*.c=33:*.h=33:*.cpp=33:*.vala=33:*.sh=33:*.zsh=33:*.vim=33:*.scm=33:*.patch=33:*.gv=33:' # Sources
LS_COLORS="$LS_COLORS"'*.odt=1;33:*.ods=1;33:*.odp=1;33:*.pdf=1;33:*.xhtml=1;33:*.html=1;33:*.htm=1;33:*.doc=1;33;41:*.xls=1;33;41:*.ppt=1;33;41:' # Text
LS_COLORS="$LS_COLORS"'*.tar=1;31:*.xz=1;31:*.bz2=1;31:*.gz=1;31:*.deb=1;31:*.rpm=1;31:*.xpi=1;31:*.tgz=1;31:*.arj=1;31:*.taz=1;31:*.lzh=1;31:*.lzma=1;31:*.zip=1;31;43:*.z=1;31:*.Z=1;31:*.dz=1;31:*.bz=1;31:*.tbz2=1;31:*.tz=1;31:*.rar=1;31;43:*.ace=1;31:*.zoo=1;31:*.cpio=1;31:*.7z=1;31:*.rz=1;31:*.torrent=1;31:' # Archives
LS_COLORS="$LS_COLORS"'*.svg=35:*.svgz=35:*.png=35:*.xcf=35:*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.pbm=35:*.pgm=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.pcx=35:' # Images
LS_COLORS="$LS_COLORS"'*.ogv=1;35:*.mng=1;35:*.avi=1;35;41:*.mpg=1;35;41:*.mpeg=1;35;41:*.mkv=1;35;41:*.vob=1;35;41:*.ogm=1;35;41:*.mp4=1;35;41:*.mov=1;35;41:*.wmv=1;35;41:*.asf=1;35;41:*.rm=1;35;41:*.rmvb=1;35;41:*.flv=1;35;41:*.gl=1;35:*.yuv=1;35:' # Video
LS_COLORS="$LS_COLORS"'*.flac=36:*.oga=36:*.ogg=36:*.mid=36:*.midi=36:*.wav=36:*.aac=36;41:*.au=36:*.mka=36:*.mp3=36;41:*.wma=36;41:*.mpc=36;41:*.ape=36;41:*.ra=36;41:' # Musics/Sound files
LS_COLORS="$LS_COLORS"$(echo $LS_COLORS | tr '[a-z]' '[A-Z]')
LS_COLORS="$LS_COLORS"'no=0:fi=0:di=1;34:ln=1;36:pi=40;33:so=1;35:do=1;35:bd=40;33;1:cd=40;33;1:or=40;31;1:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=1;32:' # Various
export LS_COLORS

# Watch for login/logout
watch=all

bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

# Edit cmdline
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Complete help
bindkey '^xc' _complete_help

# Completion cache
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Colored completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload rationalise-dot
zle -N rationalise-dot
bindkey . rationalise-dot
#
# Pattern-matching mv
autoload zmv
autoload venv color f b

# prompt.zsh

# Others prompts
PS2="%{$fg_no_bold[yellow]%}%_>%{${reset_color}%} "
PS3="%{$fg_no_bold[yellow]%}?#%{${reset_color}%} "

function precmd {
	local path_color user_color host_color return_code user_at_host
	local cwd sign branch vcs diff remote deco branch_color
	local base_color

	if [[ ! -e "$PWD" ]]; then
		path_color="${fg_no_bold[black]}"
	elif [[ -O "$PWD" ]]; then
		path_color="${fg_no_bold[white]}"
	elif [[ -w "$PWD" ]]; then
		path_color="${fg_no_bold[blue]}"
	else
		path_color="${fg_no_bold[red]}"
	fi

	case ${HOST%%.*} in
		turing)
			base_color=magenta ;;
		bretzel)
			base_color=blue ;;
		sandhose-laptop*)
			base_color=yellow ;;
		*)
			base_color=green ;;
	esac

	sign=">"

	case ${USER%%.*} in
		root)
			user_color="%{$(f bright-red)%}"
			host_color="%{$(f red)%}"
			sign="%{${fg_bold[red]}%}$sign"
		;;
		*)
			host_color="%{$(f ${host_color:-$base_color})%}"
			user_color="%{$(f ${user_color:-bright-$base_color})%}"
			sign="%{${fg_bold[$base_color]}%}$sign"
		;;
	esac

	deco="%{${fg_bold[blue]}%}"

	chroot_info=
	if [[ -e /etc/chroot ]]; then
		chroot_info="%{${fg_bold[white]}%} [$(< /etc/chroot)]"
	fi

	return_code="%(?..${deco}-%{${fg_no_bold[red]}%}%?${deco}- )"
	#user_at_host="%{${user_color}%}%n%{${fg_bold[white]}%}/%{${host_color}%}%m"
	user_at_host="%{${host_color}%}%m%{${fg_bold[white]}%}/%{${user_color}%}%n"
	cwd="%{${path_color}%}%48<...<%~"

	PS1="${return_code}${user_at_host}"
	PS1="$PS1 ${cwd}${chroot_info} ${sign}%{${reset_color}%} "

	# Right prompt with VCS info
	if [[ -e .git ]]; then
		vcs=git
		branch=$(git branch | grep '\*' | cut -d " " -f 2)
		diff="$( (( $(git diff | wc -l) != 0 )) && echo '*')"
		vcs_color="${fg_bold[white]}"
	elif [[ -e .hg ]]; then
		vcs=hg
		branch=
		vcs_color="${fg_bold[white]}"
	fi

	if [[ -n "$diff" ]]; then
		branch_color="${fg_bold[yellow]}"
		diff=" ±"
	else
		branch_color="${fg_bold[white]}"
	fi

	if [[ -n "$vcs" ]]; then
		RPS1="- %{${vcs_color}%}$vcs%{${reset_color}%}:%{$branch_color%}$branch$diff%{${reset_color}%} -"
	else
		RPS1=""
	fi
}

# vim: set ts=4 sw=4 cc=80 :
