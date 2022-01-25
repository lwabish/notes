# Shell

```shell
# 单行if
if [ "${branch}" == "${sourceBranch}" ]; then continue; fi


```

## map

```shell
# 增
declare -A frontend2repo=(
  ["portal"]="portal-page"
  ["osp"]="osp-page"
)

# 查
a=${frontend2repo["$key"]}

# key list
export all_frontends=${!frontend2repo[*]}
```

## 数组

```shell
# 空数组声明
history=()

# 增
history[$index]="someValue"

#
```

