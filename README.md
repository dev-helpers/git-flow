# Git Flow CLI

Ferramenta única para criar branches de **feature**, **bugfix** e **hotfix**, sincronizar sua branch atual com a base correta e abrir pull requests no Azure DevOps

## Instalação

### Com aliases Git

Recomendado para o dia a dia, permite usar comandos mais curtos e rápidos como `git feat`, `git fix`, `git sync` e `git pr`

```bash
curl -fsSL https://raw.githubusercontent.com/dev-helpers/git-flow/main/install.sh | bash
```

Isso instala o binário `git-flow` e configura os aliases mais usados:

* `git feat` → `git-flow feature`
* `git fix` → `git-flow bugfix`
* `git hotfix` → `git-flow hotfix`
* `git sync` → `git-flow sync`
* `git pr` → `git-flow propose`

Também ficam disponíveis os equivalentes mais verbosos:

* `git feature`
* `git bugfix`
* `git propose`

### Sem aliases

Útil para quem prefere evitar alterações na configuração global do Git e usar o binário diretamente com comandos explícitos como `git-flow feature` e `git-flow sync`

```bash
curl -fsSL https://raw.githubusercontent.com/dev-helpers/git-flow/main/install.sh | bash -s -- --no-alias
```

Nesse modo, use o binário diretamente:

* `git-flow feature <name>`
* `git-flow bugfix <name>`
* `git-flow hotfix <name>`
* `git-flow sync`
* `git-flow propose`

## Comandos mais usados

### Criar branches

Use estes comandos para iniciar uma nova branch já no padrão esperado pelo time

```bash
git feat <name> [--push]
git fix <name> [--push]
git hotfix <name> [--push]
```

Exemplos:

```bash
git feat login
git feat api/login
git feat "login oauth" --push
git fix issue-123
git hotfix 1.0.1 --push
```

Regras:

* `feat` cria branch a partir de `develop`
* `fix` cria branch a partir de `develop`
* `hotfix` cria branch a partir de `main`
* `--push` cria branch e faz push em seguida

### Sincronizar a branch atual

Use este comando para trazer a base mais recente para a branch em que você está trabalhando

```bash
git sync [--push]
```

Exemplos:

```bash
git sync
git sync --push
```

Regras:

* Se sua branch atual é `hotfix/*` então sincroniza com `main`
* Se sua branch atual é `feature/*` ou `bugfix/*` então sincroniza com `develop`
* Adicionar `--push` executa git push logo após sincronizar sua branch atual

### Abrir pull request

Use este comando para abrir rapidamente no navegador a tela de criação de PR no Azure DevOps

```bash
git pr
```

Também funciona:

```bash
git propose
git-flow propose
```

## Comportamento durante a criação da branch

Se houver mudanças locais não commitadas:

* o script faz **auto-stash**
* cria a branch nova
* tenta restaurar as mudanças na branch criada

Se houver falha depois do stash, o script tenta:

* voltar para a branch original
* restaurar o stash

Se a restauração não puder ser feita automaticamente, o stash é preservado e o comando avisa o que fazer

## Validações feitas pelo script

Antes de criar a branch, o script valida:

* se a branch local já existe
* se a branch remota já existe
* se a branch base existe no `origin`
* conflitos de path entre branches

## Ajuda

Você pode abrir a ajuda com:

```bash
git flow
git flow help
git-flow --help
```

## License

This project is licensed under the [MIT License](https://github.com/dev-helpers/git-flow/blob/main/LICENSE).
