This is based on [Hashicorp's example of AWS architecture](https://github.com/hashicorp/terraform/tree/master/examples/aws-two-tier).

To graph:

```
$ brew install graphviz
==> Installing dependencies for graphviz: libpng
==> Installing graphviz dependency: libpng
==> Downloading https://homebrew.bintray.com/bottles/libpng-1.6.21.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring libpng-1.6.21.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/libpng/1.6.21: 17 files, 1.2M
==> Installing graphviz
==> Downloading https://homebrew.bintray.com/bottles/graphviz-2.38.0.yosemite.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring graphviz-2.38.0.yosemite.bottle.1.tar.gz
🍺  /usr/local/Cellar/graphviz/2.38.0: 469 files, 67M
$ terraform graph | dot -Tpng > graph.png
$
```
