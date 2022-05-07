# Example: Perl Carton Buildpack

Compatible apps:

* Perl apps configuration
    * optional: `./.perl-version` or `$BP_PERL_VERSION`
        * build: use specified version Perl interpreter
    * optional: `./cpanfile.snapshot` or `./cpanfile`
        * build: use Carton for dependency management
    * optional: `./*.psgi`
        * launch: find first .psgi script to use entrypoint for `web` process type
    * optional: `./*.pl`
        * launch: for all script to use entrypoint for `$(basename *.pl .pl)` process type

## Usage

build your app

* builder: `builder:full`
* buildpack: `yujiorama/perl-carton-buildpack`

```shell
pack build your-app \
--builder paketobuildpacks/builder:full \
--buildpack yujiorama/perl-carton-buildpack \
--path /path/to/your-app 
```

run your app

```shell
docker run --rm your-app
```

## Exercise

build

```shell
pack build hello-world-plackup \
--builder paketobuildpacks/builder:full \
--buildpack . \
--path ./testdata/hello-world-plackup 
```

inspect

```shell
$ pack inspect hello-world-plackup
Inspecting image: hello-world-plackup

REMOTE:
(not present)

LOCAL:

Stack: io.buildpacks.stacks.bionic

Base Image:
  Reference: fcae5e193c4e9325c627dd25358ee722b19dd06159f2d0c43d3bcd48fe72bd02
  Top Layer: sha256:6bf8c2be55a5040fe6e3c42112bf620cc2ce5fe21b91d229b7a482e0852c7365

Run Images:
  index.docker.io/paketobuildpacks/run:full-cnb
  gcr.io/paketo-buildpacks/run:full-cnb

Buildpacks:
  ID                                     VERSION        HOMEPAGE
  yujiorama/perl-carton-buildpack        0.0.1          https://github.com/yujiorama/perl-carton-buildpack

Processes:
  TYPE                 SHELL        COMMAND                                ARGS
  web (default)        bash         carton exec plackup ./main.psgi
  main                 bash         carton exec perl ./main.pl
```

run

```shell
# term1
$ docker run --rm -it -p 5000:5000 hello-world-plackup
HTTP::Server::PSGI: Accepting connections at http://0:5000/
172.17.0.1 - - [07/May/2022:05:00:55 +0000] "GET / HTTP/1.1" 200 11 "-" "curl/7.82.0"

# term2
$ curl localhost:5000
Hello World

# term3
$ docker run --rm -it --entrypoint main hello-world-plackup
Hello World
```

## reference

* [Buildpack Author Guide - Create a buildpack](https://buildpacks.io/docs/buildpack-author-guide/create-buildpack/)
* [buildpacks/spec - Platform Interface Specification](https://github.com/buildpacks/spec/blob/main/platform.md)
* [buildpacks/spec - Buildpack Interface Specification](https://github.com/buildpacks/spec/blob/main/buildpack.md)
* [buildpacks/rfcs - 0031-bionic-mixins](https://github.com/buildpacks/rfcs/blob/main/text/0031-bionic-mixins.md)
* [tagomoris/xbuild](https://github.com/tagomoris/xbuild/)
* [Carton - Perl module dependency manager (aka Bundler for Perl)](https://metacpan.org/pod/Carton)
