# init() {
#     if [ -z $1 ]
#     then
#         echo "Usage: capsule --init <directory>"
#         exit
#     fi
# 
#     if [ -d $1 ]
#     then
#         realpath $1 > ~/.config/time-capsule.conf
#         echo "`realpath $1` set as new archive directory!"
#     else
#         echo "capsule: cannot use '$1': No such directory"
#         exit 1
#     fi
# }
