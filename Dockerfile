# official valvesoftware docker container for steamCMD but also good security wise for us here
FROM cm2network/steamcmd:latest
# https://steamdb.info/app/896660/ # Valheim Dedicated Server appid
ARG appid="896660"
# default user is "steam" we want higher privelages temporarily
USER root

# get all necessary files and programs that you want e.g wget and zip
RUN apt update && \
    apt install -y wget zip
# do whatever special thing you need to do here
# remove anything unecessary
RUN apt remove -y wget zip

# swap back to lower privelages
USER steam
# manipulate files to make them workable.
RUN /home/steam/steamcmd/steamcmd.sh  +login anonymous +force_install_dir /home/steam/${appid} +app_update ${appid} +quit
# copy all out config files over so they can be used with containered server
COPY . /home/steam/${appid}/
# make sure container puts us in the app directory for ease of use
WORKDIR /home/steam/${appid}

# game expected environment variables we dont care for ld_lib_path so just set it without others
ENV SteamAppId=892970
ENV LD_LIBRARY_PATH=./linux64
ENV SAVE_DIR=/home/steam/save
RUN mkdir -p ${SAVE_DIR}
# default options to use when running game
# CMD ./valheim_server.x86_64 -name "docker-valheim-server" -port 2456 -world "Dedicated" -password "secretDockerServerPassword" -savedir "${SAVE_DIR}" -public 1
CMD ./valheim_server.x86_64 -name "docker-valheim-server" -port 2456 -world "Dedicated" -password "secretDockerServerPassword" -savedir "${SAVE_DIR}"

# sudo docker build -t archer/valheim . && sudo docker run -v ~/git/game-servers/valheim/save:/home/steam/save -it archer/valheim ./valheim_server.x86_64 -name "docker-valheim-server" -port 2456 -world "Dedicated" -password "secretDockerServerPassword" -savedir "/home/steam/save"
