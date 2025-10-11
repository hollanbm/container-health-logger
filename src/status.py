import datetime
import json

import docker

client = docker.from_env()

while True:
    for container in client.containers.list():
        if not container.image.attrs["RepoTags"][0].startswith(
            "ghcr.io/hollanbm/container-health-logger"
        ):
            print(
                json.dumps(
                    {
                        "timestamp": datetime.datetime.now().isoformat(),
                        "container": container.name,
                        "health": container.health,
                    }
                )
            )
