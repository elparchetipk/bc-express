# Auto-Commit Automation - bc-express

Sistema de automatización de commits para el bootcamp bc-express que implementa conventional commits en inglés con ejecución cada 5 minutos.

## 📋 Tabla de Contenidos

- [Overview](#overview)
- [Características](#características)
- [Instalación](#instalación)
- [Uso](#uso)
- [Configuración](#configuración)
- [Conventional Commits](#conventional-commits)
- [Ejemplos](#ejemplos)
- [Troubleshooting](#troubleshooting)

## Overview

El sistema de auto-commit está diseñado para mantener un flujo continuo de commits siguiendo las mejores prácticas de conventional commits, manteniendo el historial del proyecto limpio y organizado.

### Objetivos

- ✅ **Commits consistentes**: Seguir conventional commits standard
- ✅ **Idioma inglés**: Todos los commits en inglés técnico
- ✅ **Automatización**: Ejecución cada 5 minutos via cron
- ✅ **Análisis inteligente**: Determinar tipo de commit automáticamente
- ✅ **Logging detallado**: Trazabilidad completa del proceso
- ✅ **Configuración flexible**: Adaptable a diferentes escenarios

## Características

### 🤖 Análisis Inteligente de Cambios

El script analiza automáticamente los cambios para determinar:

- **Tipo de commit**: `feat`, `fix`, `docs`, `chore`, `test`, etc.
- **Scope**: `week01`, `docs`, `scripts`, `ci`, etc.
- **Mensaje descriptivo**: Basado en los archivos modificados
- **Estadísticas**: Número de archivos agregados, modificados, eliminados

### 📝 Conventional Commits

Implementa el estándar de [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### 🔍 Tipos de Commit Soportados

| Tipo       | Descripción                      | Ejemplo                                               |
| ---------- | -------------------------------- | ----------------------------------------------------- |
| `feat`     | Nueva funcionalidad              | `feat(week01): add Express.js setup tutorial`         |
| `fix`      | Corrección de bugs               | `fix(week03): resolve middleware configuration issue` |
| `docs`     | Solo documentación               | `docs(readme): update installation instructions`      |
| `style`    | Formato, espacios, etc.          | `style(week02): improve code formatting`              |
| `refactor` | Refactoring sin cambio funcional | `refactor(utils): optimize helper functions`          |
| `test`     | Agregar o corregir tests         | `test(week04): add unit tests for auth module`        |
| `chore`    | Mantenimiento                    | `chore(deps): update Express.js to v4.18.2`           |
| `perf`     | Mejoras de performance           | `perf(week05): optimize database queries`             |
| `ci`       | Cambios de CI/CD                 | `ci(github): update workflow configuration`           |
| `build`    | Sistema de build                 | `build(docker): optimize Dockerfile layers`           |

### 🎯 Scopes Automáticos

El script detecta automáticamente el scope basado en los archivos modificados:

- `week01-week11`: Para cambios en semanas específicas
- `docs`: Para cambios en documentación
- `scripts`: Para cambios en automatización
- `ci`: Para cambios en GitHub Actions
- `resources`: Para recursos compartidos
- `final-project`: Para el proyecto final
- `core`: Para cambios generales

## Instalación

### 1. Verificar Permisos

```bash
# El script debe ser ejecutable
chmod +x _scripts/automation/auto-commit.sh
```

### 2. Instalar Cron Job (Recomendado)

```bash
# Instalar ejecución automática cada 5 minutos
./_scripts/automation/auto-commit.sh --install-cron
```

### 3. Verificar Instalación

```bash
# Verificar que el cron job fue instalado
crontab -l | grep auto-commit

# Ver logs en tiempo real
tail -f _scripts/automation/auto-commit.log
```

## Uso

### Comandos Disponibles

```bash
# Ejecución manual
./_scripts/automation/auto-commit.sh

# Previsualizar sin hacer commit
./_scripts/automation/auto-commit.sh --dry-run

# Instalar automatización
./_scripts/automation/auto-commit.sh --install-cron

# Remover automatización
./_scripts/automation/auto-commit.sh --remove-cron

# Ver ayuda
./_scripts/automation/auto-commit.sh --help

# Ver versión
./_scripts/automation/auto-commit.sh --version
```

### Flujo de Trabajo Típico

1. **Desarrollo**: Trabajar normalmente en el código
2. **Auto-detección**: El script detecta cambios cada 5 minutos
3. **Análisis**: Determina tipo y scope del commit
4. **Commit**: Realiza commit con mensaje conventional
5. **Logging**: Registra la acción en el log

## Configuración

### Archivo de Configuración

Ubicación: `_scripts/automation/auto-commit.config`

```bash
# Habilitar/deshabilitar auto-commit
AUTO_COMMIT_ENABLED=true

# Intervalo en minutos (solo referencia, configurado en cron)
COMMIT_INTERVAL_MINUTES=5

# Límite de commits por hora
MAX_COMMITS_PER_HOUR=12

# Checks de calidad antes del commit
ENABLE_LINT_CHECK=true
ENABLE_TEST_CHECK=false
ENABLE_BUILD_CHECK=false

# Auto-push (deshabilitado por defecto)
AUTO_PUSH=false
```

### Variables de Entorno

```bash
# Opcional: configurar nivel de log
export AUTO_COMMIT_LOG_LEVEL=INFO

# Opcional: deshabilitar temporalmente
export AUTO_COMMIT_ENABLED=false
```

## Conventional Commits

### Estructura del Mensaje

```
type(scope): description

body

footer
```

### Ejemplos de Commits Generados

#### Nuevas Características

```
feat(week01): add Express.js fundamentals tutorial

- Added server setup guide
- Included middleware examples
- Added routing basics

Auto-committed by bc-express automation
```

#### Correcciones

```
fix(week03): resolve TypeScript configuration issue

- Fixed tsconfig.json compilation errors
- Updated import statements
- Added missing type definitions

Auto-committed by bc-express automation
```

#### Documentación

```
docs(readme): update installation instructions

- Clarified pnpm installation steps
- Added troubleshooting section
- Updated prerequisites list

Auto-committed by bc-express automation
```

#### Mantenimiento

```
chore(deps): update project dependencies

- Modified files: 3
- Added files: 1

Auto-committed by bc-express automation
```

## Ejemplos

### Escenario 1: Agregar Nueva Semana

```bash
# Crear nueva semana
mkdir semana-05
echo "# Week 5" > semana-05/README.md

# El auto-commit generará:
# feat(week05): add new week structure
```

### Escenario 2: Actualizar Documentación

```bash
# Modificar documentación
echo "New content" >> _docs/guides/setup.md

# El auto-commit generará:
# docs(guides): update documentation content
```

### Escenario 3: Corregir Código

```bash
# Corregir archivo TypeScript
sed -i 's/var/const/g' semana-02/src/server.ts

# El auto-commit generará:
# fix(week02): resolve code quality issues
```

### Escenario 4: Múltiples Cambios

```bash
# Cambios en múltiples archivos
touch semana-01/new-exercise.md
echo "updated" >> semana-02/README.md
echo "config" >> .eslintrc.js

# El auto-commit generará:
# feat(week01): add new features and components
#
# - Modified files: 2
# - Added files: 1
```

## Logging

### Ubicación del Log

```bash
# Log principal
_scripts/automation/auto-commit.log

# Log rotado (cuando excede 1MB)
_scripts/automation/auto-commit.log.old
```

### Formato del Log

```
[2025-08-19 10:30:00] [INFO] Starting auto-commit process for bc-express
[2025-08-19 10:30:01] [INFO] Changes detected, proceeding with auto-commit
[2025-08-19 10:30:02] [SUCCESS] Auto-commit successful: feat(week01): add new tutorial content
[2025-08-19 10:30:02] [INFO] Auto-commit process completed
```

### Monitoreo en Tiempo Real

```bash
# Ver logs en tiempo real
tail -f _scripts/automation/auto-commit.log

# Filtrar solo errores
tail -f _scripts/automation/auto-commit.log | grep ERROR

# Ver últimos commits automáticos
git log --oneline --grep="Auto-committed by bc-express"
```

## Troubleshooting

### Problemas Comunes

#### 1. Cron Job No Ejecuta

```bash
# Verificar que cron está corriendo
sudo service cron status

# Verificar sintaxis del crontab
crontab -l

# Ver logs del sistema
grep CRON /var/log/syslog
```

#### 2. Permisos Insuficientes

```bash
# Hacer script ejecutable
chmod +x _scripts/automation/auto-commit.sh

# Verificar permisos del directorio
ls -la _scripts/automation/
```

#### 3. Git No Configurado

```bash
# Configurar git user
git config --global user.name "bc-express automation"
git config --global user.email "automation@bc-express.local"
```

#### 4. Demasiados Commits

```bash
# Verificar frecuencia en cron
crontab -l

# Ajustar intervalo si es necesario
# Editar: */5 a */10 para cada 10 minutos
crontab -e
```

### Logs de Debug

```bash
# Habilitar modo debug en el script
export AUTO_COMMIT_LOG_LEVEL=DEBUG

# Ejecutar manualmente para debug
./_scripts/automation/auto-commit.sh --dry-run
```

### Deshabilitar Temporalmente

```bash
# Método 1: Remover cron job
./_scripts/automation/auto-commit.sh --remove-cron

# Método 2: Variable de entorno
export AUTO_COMMIT_ENABLED=false

# Método 3: Comentar línea en crontab
crontab -e
# Agregar # al inicio de la línea
```

## Seguridad

### Consideraciones

- ✅ **No auto-push**: Por defecto no hace push automático
- ✅ **Validación**: Verifica que está en un repo git válido
- ✅ **Logs rotativos**: Evita logs demasiado grandes
- ✅ **Configuración segura**: No expone credenciales

### Mejores Prácticas

1. **Revisar commits**: Revisar periódicamente los commits automáticos
2. **Backup**: Mantener respaldos antes de habilitar auto-push
3. **Testing**: Usar `--dry-run` antes de la implementación
4. **Monitoreo**: Revisar logs regularmente

## Integración con CI/CD

El sistema se integra con el pipeline de CI/CD existente:

```yaml
# En .github/workflows/ci.yml
- name: Validate auto-commits
  run: |
    # Verificar que los commits siguen conventional commits
    git log --oneline -10 --grep="Auto-committed by bc-express" --format="%s" | \
    grep -E "^(feat|fix|docs|style|refactor|test|chore|perf|ci|build)(\(.+\))?: .+"
```

---

## 📞 Soporte

### Recursos Adicionales

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [Git Best Practices](https://git-scm.com/book/en/v2)
- [Cron Job Tutorial](https://crontab.guru/)

### Contacto

- **GitHub Issues**: Para reportar bugs o mejoras
- **Discord**: Canal #automation para soporte en tiempo real
- **Documentation**: Este archivo y `_docs/automation/`

---

**Última actualización**: Agosto 2025  
**Versión**: 1.0.0  
**Mantenido por**: Equipo bc-express automation
