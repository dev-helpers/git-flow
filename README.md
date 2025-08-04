# Git Flow CLI

Ferramenta única para gerenciar branches de *feature*, *bugfix*, *hotfix* e abertura de pull requests no Azure DevOps via linha de comando.

## Instalação

Execute o instalador via `curl` ou `wget` (sem precisar de configuração extra).

Você pode instalar com ou sem configuração de aliases Git. Escolha uma das formas abaixo:

### 1. Padrão, com aliases

```bash
curl -fsSL https://raw.githubusercontent.com/dev-helpers/git-flow/main/install.sh | bash
```

O instalador irá (automaticamente):

1. Baixar o binário `git-flow` para `/usr/local/bin/git-flow` (ou diretório padrão do sistema).
2. Tornar o arquivo executável (`chmod +x`).
3. Configurar aliases globais no Git:

   * `git sync` → `git-flow sync`
   * `git feature` → `git-flow feature`
   * `git bugfix` → `git-flow bugfix`
   * `git hotfix` → `git-flow hotfix`
   * `git propose` e `git pr` → `git-flow propose`

### 2. Sem aliases

```bash
curl -fsSL https://raw.githubusercontent.com/dev-helpers/git-flow/main/install.sh | bash -s -- --no-alias
```

Nesse modo, você deve invocar diretamente o comando git-flow:

   * `git-flow sync`
   * `git-flow feature`
   * `git-flow bugfix`
   * `git-flow hotfix`
   * `git-flow propose` e `git-flow pr`

## Uso

Todos os comandos seguem o padrão: `git <alias> <comando> [--push] [args]`

| Alias                     | Comando   | Descrição                                                  |
| ------------------------- | ----------| ---------------------------------------------------------- |
| `git sync`                | `sync`    | Rebase da branch atual com `develop` (ou `main` se hotfix) |
| `git feature`             | `feature` | Cria nova branch de *feature* a partir de `develop`        |
| `git bugfix`              | `bugfix`  | Cria nova branch de *bugfix* a partir de `develop`         |
| `git hotfix`              | `hotfix`  | Cria nova branch de *hotfix* a partir de `main`            |
| `git propose` ou `git pr` | `propose` | Abre página de PR no Azure DevOps para a branch atual      |

### Flag comum: --push

* A flag `--push` adiciona um push ao final dos comandos: `git sync`, `git feature`, `git bugfix` e `git hotfix`.

## Exemplos

### 1. Sincronizar branch local

```bash
# Traz as últimas alterações da branch remota develop (ou main, se hotfix) para sua branch local
git sync

# Traz as últimas alterações e também envia suas alterações locais para sua branch remota
git sync --push

# Equivalente usando alias mais curto
git sync-push
```

#### Em caso de conflito:

```bash
git status
git add <arquivo>
git rebase --continue
```

### 2. Criar branch de feature

```bash
# Cria feature/login localmente
git feature login

# Equivalente usando barra
git-flow feature/login

# Cria feature/login localmente e remoto
git feature login --push
```

### 3. Criar branch de bugfix/hotfix

```bash
# Bugfix sem push
git bugfix issue-123

# Hotfix com push
git hotfix 1.0.1 --push
```

### 4. Abrir pull request

```bash
# Abre no navegador padrão a página de criação de PR
git pr
git propose
```

## License

This project is licensed under the [MIT License](https://github.com/dev-helpers/git-flow/blob/main/LICENSE).
