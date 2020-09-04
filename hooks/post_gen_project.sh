#!/bin/sh

# On arrête l'exécution en cas d'erreur
set -e

# Création du dépôt local
git init
git add .
git commit -m "Initialisation du projet
À partir du squelette : {{ cookiecutter.git_remote_skel.replace(':', '/').replace('git@', 'https://') }}"
git tag 0.0.0

if {{ cookiecutter.github_create_repo }}; then
    # Création du dépôt Github
    gh repo create {{ cookiecutter.github_owner }}/{{ cookiecutter.project_slug }} --public

    # Notification Rocket Chat
    if [ -z "{{ cookiecutter.rocketchat_hook_url }}" ]; then
        curl \
            -X POST \
            -H 'Content-Type: application/json' \
            --data '{"alias":"Skel","avatar":"https://i.imgur.com/adBSucj.jpg","text":"Un nouveau dépôt a été créé !","attachments":[{"title":"{{ cookiecutter.github_owner }}/{{ cookiecutter.project_slug }}","title_link":"https://github.com/{{ cookiecutter.github_owner }}/{{ cookiecutter.project_slug }}","text":"Project Github : https://github.com/{{ cookiecutter.github_owner }}/{{ cookiecutter.project_slug }}\nSquelette : {{ cookiecutter.git_remote_skel.replace(':', '/').replace('git@', 'https://') }}" }]}' \
            {{ cookiecutter.rocketchat_hook_url }}
    fi

fi

# Envoi des sources vers le dépôt distant
if {{ cookiecutter.github_populate_repo }}; then
    git remote add origin git@github.com:{{ cookiecutter.github_owner }}/{{ cookiecutter.project_name }}.git
    git push --tags --set-upstream origin master
fi

# Aide
echo
echo "[\033[36mOK\033[0m] Le nouveau projet \033[36m{{ cookiecutter.project_name }}\033[0m a été créé dans le répertoire \033[36m$(pwd)\033[0m"
echo "[\033[36mOK\033[0m] Pour commencer à l'utiliser, exécuter les commandes suivantes : "
echo
echo "     cd $(pwd)"
echo "     make help"
echo
