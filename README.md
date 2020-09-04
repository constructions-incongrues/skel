# skel

## Pré-requis

Les logiciels suivant doivent être installés sur la machine hôte :

- [Cookiecutter](https://github.com/cookiecutter/cookiecutter)
- [Github CLI](https://cli.github.com/)

## Présentation

### Principales fonctionnalités

- Génération d'une application composé de conteneurs [Docker](https://www.docker.com) pilotés par [Docker Compose](https://code.visualstudio.com/docs/remote/containers) et [GNU/Make](https://www.gnu.org/software/make/)
- Initialisation des dépôts Git locaux et distants (optionnellement, sur [Github](https://github.com))
- Compatibilité avec [Visual Studio Code Remote Containers](https://code.visualstudio.com/docs/remote/containers)
- Mise à disposition dynamique des services publics à travers un proxy [Traefik](https://docs.traefik.io/)
- Notification optionnelle de la création du dépôt dans un salon [Rocket Chat](https://rocket.chat/)
- Mise à disposition d'outils de maintenance et de surveillance

### Services

#### Application

- `apache` : Image Docker basée sur l'image [php:apache](https://hub.docker.com/layers/php/library/php/7.4.8-apache/images/sha256-d64789a928c6ff660e94567ad044aec6dded6a5b2cc60ee6f131ae50b1b6d53a?context=explore). Elle embarque les sources de l'application
- `db` : Serveur des bases de données de l'application

#### Outils de maintenance et surveillance

- [`adminer`](https://www.adminer.org) : Interface graphique de gestion des bases de données du service `db`
- [`portainer`](https://www.portainer.io) : Interface graphique de gestion du serveur Docker
- [`traefik`](https://www.traefik.io) : Routeur HTTP et TCP. Point d'entrée vers les différents services de l'applications

## Utilisation

### Création d'un nouveau projet à partir du squelette

```sh
cookiecutter https://github.com/constructions-incongrues/skel.git
```

Il est possible de spécifier des paramètres via la ligne de commande :

```sh
cookiecutter https://github.com/constructions-incongrues/skel.git \
    github_owner=$(whoami) \
    project_name="My Project"
```

#### Paramètres

- **`docker_repository`**

    - Chemin vers un dépôt d'images Docker
    - par défaut : `docker.io/constructions-incongrues`

- **`git_remote_skel`**

    - URL du dépot Git hébergeant les sources du squelette
    - par défaut : `git@github.com:constructions-incongrues/skel.git`

- **`github_create_repo`**

    - Si `true` un dépôt distant vide est créé sur Github. Si `false`, on considère que le dépôt distant existe déjà à l'adresse `git@github.com:constructions-incongrues/new-project.git`
    - par défaut : `false`

- **`github_populate_repo`**

    - Si `true` les sources du dépôt locales sont publiées vers le dépôt Github
    - par défaut : `false`

- **`github_owner`**

    - Identifiant d'un utilisateur ou d'une organisation Github

- **`project_name`**

    - Le nom complet du projet
    - par défaut : `New Project`

- **`project_slug`**

    - L'identifiant textuel du projet
    - par défaut : `new-project`

- **`rocketchat_hook_url`**

    - URL vers un [webhook Rocket Chat entrant](https://docs.rocket.chat/guides/administrator-guides/integrations)
    - par défaut : `https://discutons.incongru.org/hooks/wd9Tfwof78pqb6i94/KagGAhiBA6KyWnSXFqJRXCbgqLp599G35gvPWnBPSTt7pMsc

## Développement

### Exécution de la suite de tests

```sh
make test
```
