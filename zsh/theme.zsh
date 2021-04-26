# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=jonas

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time kubecontext time status)

typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=""
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND='grey74'
typeset -g POWERLEVEL9K_KUBECONTEXT_BACKGROUND='grey7'

typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='darkgreen'
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='darkred'
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='grey7'

typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND='grey74'
typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='grey74'
typeset -g POWERLEVEL9K_DIR_ETC_BACKGROUND='darkred'
typeset -g POWERLEVEL9K_DIR_ETC_FOREGROUND='grey74'
typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='grey74'
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND='darkgreen'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND='darkgreen'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='darkred'
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='darkred'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND='grey7'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='darkred'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND='grey7'

####################################[ time: current time ]####################################
# Current time color.
typeset -g POWERLEVEL9K_TIME_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_TIME_BACKGROUND='grey74'
# Format for the current time: 09:51:02. See `man 3 strftime`.
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
# If set to true, time will update when you hit enter. This way prompts for the past
# commands will contain the start times of their commands as opposed to the default
# behavior where they contain the end times of their preceding commands.
typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
# Custom icon.
typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=

# Use terse signal names: "INT" instead of "SIGINT(2)".
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'

# Status when some part of a pipe command fails and the overall exit status is also non-zero.
# It may look like this: 1|0.
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'

###################[ command_execution_time: duration of the last command ]###################
# Show duration of the last command if takes longer than this many seconds.

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=4
# Show this many fractional digits. Zero means round to seconds.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
# Duration format: 1d 2h 3m 4s.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
# Custom icon.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=

#######################[ background_jobs: presence of background jobs ]#######################
# Don't show the number of background jobs.
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
# Custom icon.
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='≡'

#######################[ direnv: direnv status (https://direnv.net/) ]########################
# Direnv color.
typeset -g POWERLEVEL9K_DIRENV_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_DIRENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

#############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
# Show kubecontext only when the the command you are typing invokes one of these tools.
# Tip: Remove the next line to always show kubecontext.
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='k|kg|kcn|kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

# Kubernetes context classes for the purpose of using different colors, icons and expansions with
# different contexts.
#
# POWERLEVEL9K_KUBECONTEXT_CLASSES is an array with even number of elements. The first element
# in each pair defines a pattern against which the current kubernetes context gets matched.
# More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
# that gets matched. If you unset all POWERLEVEL9K_KUBECONTEXT_*CONTENT_EXPANSION parameters,
# you'll see this value in your prompt. The second element of each pair in
# POWERLEVEL9K_KUBECONTEXT_CLASSES defines the context class. Patterns are tried in order. The
# first match wins.
#
# For example, given these settings:
#
#   typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
#     '*prod*'  PROD
#     '*test*'  TEST
#     '*'       DEFAULT)
#
# If your current kubernetes context is "deathray-testing/default", its class is TEST
# because "deathray-testing/default" doesn't match the pattern '*prod*' but does match '*test*'.
#
# You can define different colors, icons and content expansions for different classes:
#
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_FOREGROUND=28
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
  # '*prod*'  PROD    # These values are examples that are unlikely
  # '*test*'  TEST    # to match your needs. Customize them as needed.
  '*janz-cluster*' JANZ_CLUSTER # to match your needs. Customize them as needed.
  '*' DEFAULT)
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND='grey7'
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND='grey74'
#typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='○'

typeset -g POWERLEVEL9K_KUBECONTEXT_JANZ_CLUSTER_FOREGROUND='white'
typeset -g POWERLEVEL9K_KUBECONTEXT_JANZ_CLUSTER_BACKGROUND='navyblue'

# Use POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION to specify the content displayed by kubecontext
# segment. Parameter expansions are very flexible and fast, too. See reference:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion.
#
# Within the expansion the following parameters are always available:
#
# - P9K_CONTENT                The content that would've been displayed if there was no content
#                              expansion defined.
# - P9K_KUBECONTEXT_NAME       The current context's name. Corresponds to column NAME in the
#                              output of `kubectl config get-contexts`.
# - P9K_KUBECONTEXT_CLUSTER    The current context's cluster. Corresponds to column CLUSTER in the
#                              output of `kubectl config get-contexts`.
# - P9K_KUBECONTEXT_NAMESPACE  The current context's namespace. Corresponds to column NAMESPACE
#                              in the output of `kubectl config get-contexts`. If there is no
#                              namespace, the parameter is set to "default".
# - P9K_KUBECONTEXT_USER       The current context's user. Corresponds to column AUTHINFO in the
#                              output of `kubectl config get-contexts`.
#
# If the context points to Google Kubernetes Engine (GKE) or Elastic Kubernetes Service (EKS),
# the following extra parameters are available:
#
# - P9K_KUBECONTEXT_CLOUD_NAME     Either "gke" or "eks".
# - P9K_KUBECONTEXT_CLOUD_ACCOUNT  Account/project ID.
# - P9K_KUBECONTEXT_CLOUD_ZONE     Availability zone.
# - P9K_KUBECONTEXT_CLOUD_CLUSTER  Cluster.
#
# P9K_KUBECONTEXT_CLOUD_* parameters are derived from P9K_KUBECONTEXT_CLUSTER. For example,
# if P9K_KUBECONTEXT_CLUSTER is "gke_my-account_us-east1-a_my-cluster-01":
#
#   - P9K_KUBECONTEXT_CLOUD_NAME=gke
#   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=my-account
#   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east1-a
#   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
#
# If P9K_KUBECONTEXT_CLUSTER is "arn:aws:eks:us-east-1:123456789012:cluster/my-cluster-01":
#
#   - P9K_KUBECONTEXT_CLOUD_NAME=eks
#   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=123456789012
#   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east-1
#   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
# Show P9K_KUBECONTEXT_CLOUD_CLUSTER if it's not empty and fall back to P9K_KUBECONTEXT_NAME.
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
# Append the current context's namespace if it's not "default".
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

POWERLEVEL9K_KUBECONTEXT_JANZ_CLUSTER_CONTENT_EXPANSION='${P9K_KUBECONTEXT_NAMESPACE}'

# Custom prefix.
# typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%246Fat '
# User-defined prompt segments may optionally provide an instant_prompt_* function. Its job
# is to generate the prompt segment for display in instant prompt. See
# https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
#
# Powerlevel10k will call instant_prompt_* at the same time as the regular prompt_* function
# and will record all `p10k segment` calls it makes. When displaying instant prompt, Powerlevel10k
# will replay these calls without actually calling instant_prompt_*. It is imperative that
# instant_prompt_* always makes the same `p10k segment` calls regardless of environment. If this
# rule is not observed, the content of instant prompt will be incorrect.

# User-defined prompt segments can be customized the same way as built-in segments.
# typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=208
# typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'

# Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
# when accepting a command line. Supported values:
#
#   - off:      Don't change prompt when accepting a command line.
#   - always:   Trim down prompt when accepting a command line.
#   - same-dir: Trim down prompt when accepting a command line unless this is the first command
#               typed after changing current working directory.
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

# Instant prompt mode.
#
#   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
#              it incompatible with your zsh configuration files.
#   - quiet:   Enable instant prompt and don't print warnings when detecting console output
#              during zsh initialization. Choose this if you've read and understood
#              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
#   - verbose: Enable instant prompt and print a warning when detecting console output during
#              zsh initialization. Choose this if you've never tried instant prompt, haven't
#              seen the warning, or if you are unsure what this all means.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

# Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
# For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
# can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
# really need it.
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
