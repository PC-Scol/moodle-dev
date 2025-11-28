# moodle-dev

Ce dépôt est un POC d'une installation de Moodle à des fins de développement.
IMPORTANT: ne PAS utiliser cette installation pour de la prod

TODO: comment est développé un plugin moodle? faut-il modifier ce projet pour
faciliter l'intégration d'une version de développement d'un plugin?

> [!IMPORTANT]
> Pour l'instant, à cause du changement dans la structure des répertoires, ce
> POC ne supporte que les versions >= 5.0 de Moodle.

Démarrage rapide
* télécharger la release de Moodle sur <https://download.moodle.org/releases/latest/>
  puis copier le fichier dans le répertoire `install`

  à la date du 28/11/2025, le fichier s'appelle `moodle-latest-501.tgz` ou
  `moodle-latest-501.zip`. Le nom du fichier peut être différent si une mise à
  jour est livrée. Vous pouvez aussi prendre une version plus ancienne
* télécharger la release de Moosh sur <https://moodle.org/plugins/pluginversions.php?id=522>
  puis copier le fichier dans le répertoire `install`

  à la date du 28/11/2025, le fichier s'appelle `moosh_moodle50_2025071502.zip`.
  Le nom du fichier peut être différent si une mise à jour est livrée
* modifier le cas échéant les fichiers suivants:
  * `config/shared_env` pour spécifier notamment le port d'écoute et le nom
    d'hôte. la valeur par défaut est le port 8080 sur localhost. ces valeurs
    conditionnent l'url à partir de laquelle il faudra accéder à l'instance de
    Moodle.
  * `config/moodle.conf` pour spécifier notamment le mot de passe de
    l'utilisateur admin et le mail associé
  * `config/moodle.init` pour indiquer des commandes à lancer pour initialiser
    l'instance Moodle après sa configuration initiale.
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

## Divers

Pour recommencer à zéro, l'option -K est utile. elle permet de supprimer avant
le (re)démarrage:
* tous les volumes associés
* le fichier `install/moodle/config.php` pour qu'il soit recréé à partir de la
  configuration dans `config/moodle.conf`

~~~sh
./start -K
~~~
pour être sûr de tout recommencer à zéro, supprimer aussi le répertoire
`install/moodle`
~~~sh
./start -K0
~~~

Utiliser l'option -b pour reconstruire les images
~~~sh
./start -nb
~~~

Par défaut, les containers sont lancés en mode interactif et les logs sont
affichés. Il est possible de lancer en tâche de fond avec l'option -d
~~~sh
# démarrer en tâche de fond
./start -d

# arrêter les containers qui tournent en tâche de fond
./start -k
~~~

L'option -n désactive le lancement de Moodle. C'est utile en conjonction avec -K
ou -b
~~~sh
# ne faire que supprimer les volumes et le fichier de configuration
./start -nK

# ne faire que (re)construire les images
./start -nb
~~~

-*- coding: utf-8 mode: markdown -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8:noeol:binary