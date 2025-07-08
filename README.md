# SIMEIS
Simeis est un jeu de gestion dans l’espace par API dont l’objectif principal est de ne jamais tomber en banqueroute.
Chaque joueur démarre avec une station spatiale et des crédits. Son objectif est alors d’assembler une flotte et un équipage afin d’aller farmer des ressources sur des planètes.

Il est possible d'acheter des améliorations afin d'augmenter son efficacité

## Contexte du projet
Ce projet a été créé à partir d'un code déjà existant afin de pouvoir y intégrer des éléments d'intégration et de déploiement continu.
Le code en lui-même est très simple car notre travail c'est majoritairement concentré sur le fait d'avoir des workflows optimisés et fonctionnels

## Technologies Utilisées
Ce projet fonctionne en Rust mais le bot du joueur est en Python.

## Installation
Dernière version du projet released : [Simeis](https://github.com/ValentinRusseil/simeis-project/releases/tag/1.1.1)

```cmd
# pour récupérer le code sur github
git clone https://github.com/ValentinRusseil/simeis-project.git



# en se servant d'une release
# ! attention cette version est en débian !
# Remplacez {VERSION} par la version que vous aurez choisi
wget https://github.com/ValentinRusseil/simeis-project/releases/download/1.1.1/MatVal-simeis-server_{VERSION}_all.deb
dpkg-deb -x MatVal-simeis-server_{VERSION}.deb
usr/bin/MatVal-simeis-server

#pour tester que ça fonctionne (sur un autre terminal)
curl VOTRE.IP.SERVEUR:9544/version

#pour fermer le serveur
control+ C
```

## Prérequis
- Rust (https://www.rust-lang.org/tools/install)
- Cargo (généralement installé avec Rust)
- Python 3.8 ou supérieur
- Linux

## Compiler

```
# Pour compiler le projet (assurez-vous d'être dans le répertoire du projet)
cargo build

# Pour le lancer
cargo run
```

## Tester

```
# Pour lancer les tests
cargo test

# Pour tester le bot
python3 test_robot.py

# Pour tester des fonctionnalités
# le chiffre correspond au temps en secondes ou le bot va tester des possibilités
python3 propertybased.py 3 
```