# Estructura del Proyecto - Bootcamp bc-express

Este documento describe la organización completa del proyecto Bootcamp bc-express, proporcionando una guía detallada para contributors, instructores y estudiantes.

## 📋 Tabla de Contenidos

- [Visión General](#visión-general)
- [Estructura de Directorios](#estructura-de-directorios)
- [Convenciones de Nomenclatura](#convenciones-de-nomenclatura)
- [Organización de Contenido](#organización-de-contenido)
- [Workflows y Procesos](#workflows-y-procesos)

## Visión General

El proyecto bc-express está diseñado como un bootcamp educativo opensource que enseña desarrollo de APIs REST con Express.js. La estructura está optimizada para:

- **Progresión pedagógica**: Contenido organizado en semanas con dificultad creciente
- **Mantenibilidad**: Separación clara de responsabilidades
- **Colaboración**: Facilita contribuciones de múltiples personas
- **Escalabilidad**: Permite agregar contenido sin romper la estructura existente

## Estructura de Directorios

```
bc-express/
├── 📄 README.md                      # Documentación principal del proyecto
├── 📄 LICENSE                        # Licencia MIT
├── 📄 CONTRIBUTING.md                 # Guía de contribución
├── 📄 CODE_OF_CONDUCT.md             # Código de conducta
├── 📄 CHANGELOG.md                   # Registro de versiones y cambios
├── 📄 ESTRUCTURA.md                  # Este archivo
├── 📄 .gitignore                     # Archivos ignorados por Git
├── 📄 .markdownlint.yml              # Configuración de linting Markdown
├── 📄 plan-trabajo-detallado.md      # Plan curricular completo
│
├── 📁 .github/                       # 🔧 Configuración GitHub
│   ├── 📄 .copilot-instructions.md   # Instrucciones para GitHub Copilot
│   ├── 📄 PULL_REQUEST_TEMPLATE.md   # Template para Pull Requests
│   ├── 📁 ISSUE_TEMPLATE/            # Templates para Issues
│   │   ├── 📄 bug_report.md          # Reporte de bugs
│   │   ├── 📄 feature_request.md     # Solicitud de características
│   │   ├── 📄 question.md            # Preguntas de la comunidad
│   │   └── 📄 config.yml             # Configuración de templates
│   └── 📁 workflows/                 # GitHub Actions
│       └── 📄 ci.yml                 # Pipeline CI/CD
│
├── 📁 .vscode/                       # 🎨 Configuración VS Code
│   ├── 📄 settings.json              # Configuraciones del workspace
│   ├── 📄 extensions.json            # Extensiones recomendadas
│   └── 📄 launch.json                # Configuración de debugging
│
├── 📁 assets/                        # 🎨 Recursos gráficos
│   ├── 📄 logo-bootcamp-express.svg  # Logo principal (SVG)
│   ├── 📄 logo-bootcamp-express.png  # Logo principal (PNG)
│   └── 📄 logo-preview.html          # Vista previa de logos
│
├── 📁 _docs/                         # 📚 Documentación técnica
│   ├── 📁 setup/                     # Guías de configuración
│   │   ├── 📄 environment-setup.md   # Setup del entorno de desarrollo
│   │   ├── 📄 git-github-strategy.md # Estrategias Git/GitHub
│   │   ├── 📄 entrega-guidelines.md  # Guías para entregas
│   │   └── 📄 automation-roadmap.md  # Roadmap de automatización
│   ├── 📁 guides/                    # Guías técnicas avanzadas
│   │   ├── 📄 security-best-practices.md    # Mejores prácticas de seguridad
│   │   ├── 📄 performance-optimization.md  # Optimización de rendimiento
│   │   ├── 📄 api-design-standards.md      # Estándares de diseño de APIs
│   │   ├── 📄 deployment-devops.md         # Deployment y DevOps
│   │   ├── 📄 architecture-patterns.md     # Patrones de arquitectura
│   │   ├── 📄 database-modeling.md         # Modelado de bases de datos
│   │   ├── 📄 gamification-strategy.md     # Sistema de gamificación
│   │   └── 📄 rubricas-evaluacion.md       # Rúbricas de evaluación
│   ├── 📁 api/                       # Documentación de APIs
│   ├── 📁 architecture/              # Diagramas y arquitectura
│   └── 📁 troubleshooting/           # Solución de problemas
│
├── 📁 _scripts/                      # 🔧 Scripts de automatización
│   ├── 📁 setup/                     # Scripts de configuración inicial
│   ├── 📁 testing/                   # Scripts de testing
│   ├── 📁 deployment/                # Scripts de deployment
│   └── 📁 utilities/                 # Utilidades generales
│       └── 📄 generate_week_gitkeeps.sh # Generador de .gitkeep
│
├── 📁 recursos-compartidos/          # 🗂️ Recursos del bootcamp
│   ├── 📁 configs/                   # Configuraciones compartidas
│   │   ├── 📄 tsconfig.base.json     # Configuración base TypeScript
│   │   ├── 📄 eslint.config.js       # Configuración ESLint
│   │   ├── 📄 prettier.config.js     # Configuración Prettier
│   │   └── 📄 docker-compose.base.yml # Docker Compose base
│   ├── 📁 templates/                 # Plantillas de código
│   │   ├── 📁 express-basic/         # Template básico Express.js
│   │   ├── 📁 express-typescript/    # Template Express + TypeScript
│   │   └── 📁 express-prisma/        # Template Express + Prisma
│   ├── 📁 databases/                 # Scripts y datos de BD
│   │   ├── 📁 migrations/            # Migraciones compartidas
│   │   └── 📁 seeds/                 # Datos de prueba
│   └── 📁 tools/                     # Herramientas del bootcamp
│       ├── 📄 project-validator.js   # Validador de estructura
│       └── 📄 dependency-checker.js  # Verificador de dependencias
│
├── 📁 semana-01/                     # 🎯 Semana 1: Fundamentos
│   ├── 📄 README.md                  # Objetivos y actividades semanales
│   ├── 📄 RUBRICA_SEMANA_1.md       # Rúbrica de evaluación
│   ├── 📁 teoria/                    # Conceptos teóricos
│   │   └── 📄 01-conceptos-fundamentales.md
│   ├── 📁 practica/                  # Tutoriales prácticos
│   │   ├── 📄 01-environment-setup.md
│   │   ├── 📄 02-hello-world-api.md
│   │   ├── 📄 03-nodejs-fundamentals.md
│   │   ├── 📄 04-express-basics.md
│   │   └── 📁 04-express-basics/     # Proyecto práctico
│   │       ├── 📄 package.json
│   │       ├── 📄 tsconfig.json
│   │       ├── 📄 server.ts
│   │       └── 📁 src/
│   ├── 📁 ejercicios/                # Ejercicios propuestos
│   │   ├── 📄 ejercicio-01.md
│   │   └── 📄 ejercicio-02.md
│   ├── 📁 proyecto/                  # Especificaciones del proyecto
│   │   ├── 📄 especificaciones.md
│   │   └── 📄 criterios-evaluacion.md
│   └── 📁 recursos/                  # Referencias y materiales
│       ├── 📄 enlaces-utiles.md
│       └── 📄 lecturas-complementarias.md
│
├── 📁 semana-02/ ... semana-11/      # 🎯 Semanas 2-11 (estructura similar)
│
└── 📁 proyecto-final/                # 🏆 Proyecto integrador
    ├── 📁 backend/                   # Backend Express.js
    ├── 📁 frontend/                  # Frontend React (opcional)
    ├── 📁 deployment/                # Configuración de deployment
    ├── 📁 docs/                      # Documentación del proyecto
    └── 📁 tests/                     # Testing integral
```

## Convenciones de Nomenclatura

### Archivos y Directorios

- **Directorios**: `kebab-case` (ej: `_docs`, `semana-01`, `recursos-compartidos`)
- **Archivos markdown**: `kebab-case.md` (ej: `environment-setup.md`)
- **Archivos código**: Según lenguaje
  - TypeScript/JavaScript: `camelCase.ts` o `kebab-case.ts`
  - Configuración: `nombre.config.js`

### Contenido Técnico

- **Variables, funciones**: `camelCase` (JavaScript/TypeScript)
- **Clases, interfaces**: `PascalCase`
- **Constantes**: `UPPER_SNAKE_CASE`
- **Endpoints**: `/kebab-case` (ej: `/api/user-profile`)
- **JSON keys**: `camelCase`

### Documentación

- **Títulos**: Español, descriptivos
- **Código**: Comentarios técnicos en inglés
- **Explicaciones**: Español claro y educativo

## Organización de Contenido

### Estructura Semanal Estándar

Cada `semana-XX/` sigue esta estructura consistente:

```
semana-XX/
├── README.md                 # Objetivos, actividades, tiempo estimado
├── RUBRICA_SEMANA_X.md      # Criterios de evaluación específicos
├── teoria/                  # 📖 Marco teórico (30-45 min)
├── practica/                # 💻 Tutoriales paso a paso (3-4 hrs)
├── ejercicios/              # 🏋️ Ejercicios individuales (1-2 hrs)
├── proyecto/                # 🎯 Proyecto semanal (integrador)
└── recursos/                # 📚 Material complementario
```

### Progresión Curricular

1. **Semanas 1-3**: Fundamentos (🟢 Beginner)
2. **Semanas 4-7**: Desarrollo intermedio (🟡 Intermediate)
3. **Semanas 8-10**: Conceptos avanzados (🟠 Advanced)
4. **Semana 11**: Proyecto integrador (🔴 Expert)

### Tiempo por Semana

- **Total**: 6 horas exactas (incluye break de 30 min)
- **Teoría**: 30-45 minutos
- **Práctica**: 3-4 horas
- **Ejercicios**: 1-2 horas
- **Break**: 30 minutos
- **Buffer**: 15-30 minutos

## Workflows y Procesos

### Desarrollo de Contenido

1. **Planificación**: Issue en GitHub con template de feature
2. **Desarrollo**: Rama `feature/semana-XX-topic`
3. **Review**: Pull Request con template completo
4. **Testing**: Validación automática de contenido
5. **Deploy**: Merge a `main` activa el deployment

### Versionado

- **Semantic Versioning**: `MAJOR.MINOR.PATCH`
- **MAJOR**: Cambios incompatibles en estructura
- **MINOR**: Nuevas semanas o funcionalidades
- **PATCH**: Correcciones y mejoras menores

### Quality Gates

#### Contenido

- [ ] Estructura semanal completa
- [ ] Tiempo total no excede 6 horas
- [ ] Progresión lógica de conceptos
- [ ] Código funcional y tested
- [ ] Documentación clara

#### Código

- [ ] TypeScript strict mode
- [ ] ESLint passing
- [ ] Tests con 80%+ coverage
- [ ] Dockerfile funcional
- [ ] Documentación JSDoc

#### Documentación

- [ ] Markdown lint passing
- [ ] Enlaces válidos
- [ ] Screenshots actualizados
- [ ] Ejemplos probados

### Automatización

#### GitHub Actions

- **CI/CD**: Testing automático de contenido
- **Quality**: Linting y validación
- **Security**: Scanning de vulnerabilidades
- **Deployment**: GitHub Pages (documentación)

#### Scripts Locales

- **Setup**: Configuración automática del entorno
- **Validation**: Verificación de estructura
- **Testing**: Ejecución de todos los ejemplos

## Escalabilidad

### Agregar Nueva Semana

1. Crear directorio `semana-XX/`
2. Copiar estructura desde template
3. Actualizar plan curricular
4. Agregar al workflow de CI/CD
5. Actualizar documentación

### Modificar Estructura

1. Crear RFC (Request for Comments) en Issues
2. Discusión con la comunidad
3. Implementación en rama experimental
4. Testing exhaustivo
5. Migración gradual

### Contribuciones Externas

1. Fork del repositorio
2. Seguir guías de CONTRIBUTING.md
3. Pull Request con template completo
4. Code review obligatorio
5. Testing automático antes de merge

---

## Mantenimiento

### Responsabilidades

- **Maintainers**: Arquitectura general, review de PRs críticos
- **Contributors**: Contenido específico, mejoras
- **Community**: Feedback, testing, documentación

### Ciclos de Release

- **Patch**: Semanal (correcciones menores)
- **Minor**: Mensual (nuevas características)
- **Major**: Semestral (cambios estructurales)

### Métricas de Calidad

- **Coverage**: >80% en código de ejemplo
- **Documentation**: 100% de APIs documentadas
- **Links**: <5% de enlaces rotos
- **Performance**: <3s tiempo de build

---

**Última actualización**: Agosto 2025  
**Versión**: 1.0.0  
**Próxima revisión**: Octubre 2025
