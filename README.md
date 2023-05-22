# wiki仓库

## 文章结构

```
└── wiki
    ├── 目录01
    │   ├── 文章01.md
    │   └── 文章02.md
    ├── 目录名02
    │   ├── 文章01.md
    │   └── 文章02.md
    └── index.md
```

## 本地启动

```
git clone https://github.com/bohai-repo/wiki.k8s.dad.git && cd wiki.k8s.dad
pip3 install -r requirements.txt
mkdocs serve
```

访问 `http://127.0.0.1:8000` 打开首页

## 生成静态文件

```
mkdocs build
```

生成后,位于 `./site` 目录中