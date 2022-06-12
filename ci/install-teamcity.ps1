# create Docker network
docker network create myteamcity-network

# install TeamCity server
docker run --name myteamcity `
    -v d:/teamcity/data:/data/teamcity_server/datadir `
    -v d:/teamcity/logs:/opt/teamcity/logs `
    -p 8111:8111 `
    --restart always `
	-d `
	--network myteamcity-network `
    jetbrains/teamcity-server
	
# option 1 - doesn't work well with Docker Wrapper
# docker run --name myteamcity-agent1 `
    # -e SERVER_URL=http://myteamcity:8111/ `
	# -e DOCKER_IN_DOCKER=start `
	# -u 0 `
    # -v d:/teamcity/agent1:/data/teamcity_agent/conf `
	# -v /var/run/docker.sock:/var/run/docker.sock `
    # -v d:/teamcity/data/work:/opt/buildagent/work `
    # -v d:/teamcity/data/temp:/opt/buildagent/temp `
    # -v d:/teamcity/data/tools:/opt/buildagent/tools `
    # -v d:/teamcity/data/plugins:/opt/buildagent/plugins `
    # -v d:/teamcity/data/system:/opt/buildagent/system `
	# --network myteamcity-network `
	# -d `
    # jetbrains/teamcity-agent
	
# option 2 - Docker host inside the container
docker run --name myteamcity-agent1 `
    -e SERVER_URL=http://myteamcity:8111/ `
	-v d:/teamcity/agent1:/data/teamcity_agent/conf `
	-v myteamcity-agentvolume1:/var/lib/docker `
    --privileged -e DOCKER_IN_DOCKER=start `
	--network myteamcity-network `
	-d `
    jetbrains/teamcity-agent:2022.04.1-linux-sudo
	