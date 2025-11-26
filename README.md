# moodle-dev

Ce dépôt est un POC d'une installation de Moodle à des fins de développement.
IMPORTANT: ne PAS utiliser cette installation pour de la prod

Démarrage rapide
* télécharger la release de Moodle au format `.tgz` sur <https://download.moodle.org/releases/latest/>
* télécharger la release de Moosh sur <https://moodle.org/plugins/pluginversions.php?id=522>
* placer les deux fichiers dans le répertoire `install`
  au 16/11/2025 il s'agit de ces deux fichiers:
  * `moodle-latest-501.tgz`
  * `moosh_moodle50_2025071502.zip`
* modifier le cas échéant les fichiers suivants:
  * `src/shared_env` pour spécifier notamment le port d'écoute et le nom
    d'hôte. la valeur par défaut est le port 8080 sur localhost
  * `src/moodle.conf` pour spécifier notamment le mot de passe de l'utilisateur
    admin
  * `src/moodle.init` pour indiquer des commandes à lancer pour initialiser
    l'instance Moodle après sa configuration initiale
* puis démarrer les containers
  ~~~sh
  ./start
  ~~~
* attendre la configuration initiale. L'instance Moodle est alors disponible sur
  <http://localhost:8080>
* Utiliser Ctrl+C pour arrêter les container

Une fois que les containers sont lancés, la commande `moosh` peut être utilisée
pour piloter l'instance Moodle
~~~sh
./moosh plugin-list
~~~

TODO: comment est développé un plugin moodle? faut-il modifier ce projet pour
faciliter l'intégration d'une version de développement d'un plugin?

## Divers

Pour recommencer à zéro, l'option -K est utile: elle permet de supprimer tous
les volumes associés avant le (re)démarrage
~~~sh
./start -K
~~~

S'il faut reconstruire les images (par exemple si les fichiers du répertoire
`install` sont mis à jour), utiliser l'option -b
~~~sh
./start -b
~~~

Par défaut, les containers sont lancés en mode interactif et les logs sont
affichés. Il est possible de lancer en tâche de fond avec l'option -d
~~~sh
# démarrer en tâche de fond
./start -d

# arrêter les containers qui tournent en tâche de fond
./start -k
~~~

-*- coding: utf-8 mode: markdown -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8:noeol:binary