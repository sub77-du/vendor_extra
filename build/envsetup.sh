function analyse_log()
{
    # Check compile result and patch file success
    echo -e "\n***************************************************"
    echo -e "${CL_GRN}Check for compile errors:"
    echo -e ${CL_RED}
    grep " error" ./compile.log
    grep "forbidden warning" ./compile.log
    grep "note: previous definition is here" ./compile.log
    grep "fatal error:" ./compile.log
    grep "terminate" ./compile.log
    grep "ninja: error:" ./compile.log
    grep "needed" ./compile.log
    grep -A 1 "ERROR" ./compile.log
    echo -e ${CL_RST}

    echo -e "***************************************************"
}



function func_alias()
{
alias gs='git status'
alias gl='git log --oneline'
alias gr='git remote -v'
alias gb='git branch -a'
alias rb='repo branches'
alias gcp='git cherry-pick --signoff'
alias gcpa='git cherry-pick --abort'
alias gcpc='git add --all && git cherry-pick --continue'
alias gres='git reset'
alias gd='git diff'
alias gca='git commit --amend'
alias gprr='git push $1 "$2:$2" -f'
}

function func_ccache()
{
  if [[ ! -f $(which ccache &>/dev/null) ]]; then
    alias ccache='./prebuilts/misc/linux-x86/ccache/ccache'
  fi


  if [[ "${ccache_use}" == "" || "${ccache_use}" == "0" || "${ccache_use}" == "false" ]]; then
    echo -e ${ylw}" * Disabled ccache"${txtrst};
    export USE_CCACHE=0;
  elif [ "${ccache_dir}" == "" ]; then
    echo -e ${red}"Error: ccache_dir not set [vendor/extra/config]"${txtrst};
  else
    export USE_CCACHE=1
    mkdir -p "$CCACHE_DIR" 2>/dev/null
    export CCACHE_DIR=${ccache_dir}
    ccmd=$(ccache -M $ccache_size 2>&1)
    cdir=$(ccache -s|grep directory|cut -d '/' -f 3-10)
    csiz=$(ccache -s|grep 'cache size')
    ccur=$(echo $csiz|cut -d ' ' -f 3-4)
    cmax=$(echo $csiz|cut -d ' ' -f 8-9)
    echo -e $(ccache -s) >/dev/null
    echo -e ${txtbld}"Setup ccache : ${rst}${cya}$ccur /${cya} $cmax ($cdir)"${rst};
  fi
}

function func_colors()
{
if [ ! "$BUILD_WITH_COLORS" = "0" ]; then
    CL_RED="\033[31m"
    CL_GRN="\033[32m"
    CL_YLW="\033[33m"
    CL_BLU="\033[34m"
    CL_MAG="\033[35m"
    CL_CYN="\033[36m"
    CL_RST="\033[0m"
    red=$(tput setaf 1)             #  red
    grn=$(tput setaf 2)             #  green
    ylw=$(tput setaf 3)             #  yellow
    blu=$(tput setaf 4)             #  blue
    ppl=$(tput setaf 5)             #  purple
    cya=$(tput setaf 6)             #  cyan
    rst=$(tput sgr0)                #  Reset
    txtbld=$(tput bold)             #  Bold
    bldred=${txtbld}$(tput setaf 1) #  red
    bldgrn=${txtbld}$(tput setaf 2) #  green
    bldylw=${txtbld}$(tput setaf 3) #  yellow
    bldblu=${txtbld}$(tput setaf 4) #  blue
    bldppl=${txtbld}$(tput setaf 5) #  purple
    bldcya=${txtbld}$(tput setaf 6) #  cyan
    txtrst=$(tput sgr0)             #  Reset
    rev=$(tput rev)                 #  Reverse color
    pplrev=${rev}$(tput setaf 5)
    cyarev=${rev}$(tput setaf 6)
    ylwrev=${rev}$(tput setaf 3)
    blurev=${rev}$(tput setaf 4)
    pa="\n"
    par=$(tput sgr0)${pa}
fi
}

function func_config()
{
  source "vendor/extra/config/rom_config"
}

function mka2() {
    m "$@" | tee ./compile.log
    analyse_log
}

function opendelta()
{
#read -p "Continue with OpenDelta(y/n)?" CONT
#if [ "$CONT" = "y" ]; then
  cd /roms/omni-9/vendor/extra/opendelta
  bash opendelta.sh $CUSTOM_BUILD
  if [ $? -eq 0 ]; then
    echo -e "no error, starting upload"
    bash upload.sh $CUSTOM_BUILD
  else
    echo -e "error. no upload"
  fi
#else
#  echo "abort";
#fi
croot
}

function func_patchcommon()
{
    for f in `test -d vendor && find -L vendor/extra/patch -maxdepth 1 -name 'apply.sh' 2> /dev/null`
    do
        pvar=$(dirname $f)/common
        echo -e ${bldppl}${pa}"applying common patches" - $pvar${rst}
        . $f
    done
    unset f
}

function func_patchdevice()
{
    for f in `test -d vendor && find -L vendor/extra/patch -maxdepth 1 -name 'apply.sh' 2> /dev/null`
    do
        pvar=$(dirname $f)/device/$DU_BUILD
        echo -e ${bldppl}${pa}"applying $DU_BUILD patches" - $pvar${rst}
        . $f
    done
    unset f
}

function func_repopicker() {
    echo -e ${bldppl}${pa}"repopicking"${rst}
    test -d vendor && find -L vendor -maxdepth 4 -name 'caf-vendorsetup.sh'
    . `test -d vendor && find -L vendor/extra/patch/repo -maxdepth 1 -name 'repopicker.sh'`
}

function set_stuff_for_environment()
{
    settitle
    set_java_home
    setpaths
    set_sequence_number
    
    func_patchcommon
    func_patchdevice

    export ANDROID_BUILD_TOP=$(gettop)
    # With this environment variable new GCC can apply colors to warnings/errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
    export ASAN_OPTIONS=detect_leaks=0
}

func_alias
func_colors
func_config
func_ccache
