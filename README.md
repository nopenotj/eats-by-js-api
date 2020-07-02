
## Install

### Clone the repository

```shell
git clone git@github.com:juliendargelos/project.git
cd project
```

### Check your Ruby version

```shell
ruby -v
```

You should use ruby 2.6.5

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.5
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```
