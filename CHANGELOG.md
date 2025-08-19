# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere al [Versionado Semántico](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned

- Integración con GitHub Codespaces
- Plantillas de proyecto automatizadas
- Sistema de badges automatizado
- Integración con Discord bot

## [1.0.0] - 2025-08-19

### Added

- ✅ **Bootcamp completo**: 11 semanas de contenido estructurado
- ✅ **Stack tecnológico**: Express.js, TypeScript, Node.js, PostgreSQL
- ✅ **Documentación completa**: README, Contributing, Code of Conduct
- ✅ **Sistema de gamificación**: Badges, puntos, equipos colaborativos
- ✅ **Metodología SENA**: Integración con valores institucionales
- ✅ **pnpm exclusivo**: Gestor de paquetes oficial con justificación técnica
- ✅ **Templates GitHub**: Issues, PRs, workflows
- ✅ **Estructura de proyecto**: Organización clara y escalable
- ✅ **Rúbricas de evaluación**: Sistema completo de assessment
- ✅ **Scripts de automatización**: Setup, testing, deployment
- ✅ **Guías técnicas**: Security, performance, architecture
- ✅ **Contenido práctico**: Proyectos progresivos por semana
- ✅ **Docker integration**: Containerización desde día 1
- ✅ **CI/CD setup**: GitHub Actions workflows
- ✅ **Testing framework**: Jest y Supertest configurados

### Technical Stack

- **Backend**: Express.js 4.18+, TypeScript 5.0+, Node.js 22 LTS
- **Database**: PostgreSQL 15, Prisma ORM, Redis 7
- **Testing**: Jest, Supertest, Coverage reports
- **Tools**: Docker, Docker Compose, GitHub Actions
- **Frontend**: React 19, Vite, Tailwind CSS (cuando se requiera)
- **Package Manager**: pnpm (exclusive)

### Educational Features

- **Duration**: 11 semanas × 6 horas semanales
- **Methodology**: Bootcamp intensivo con enfoque práctico
- **Evaluation**: Sistema de rúbricas detalladas
- **Progression**: Proyectos que construyen sobre conocimientos previos
- **Collaboration**: Trabajo en equipos con rotación semanal
- **Quality**: Enfoque en mejores prácticas desde el inicio

### Documentation

- **README.md**: Documentación principal completa
- **CONTRIBUTING.md**: Guía detallada de contribución
- **CODE_OF_CONDUCT.md**: Código de conducta adaptado al contexto SENA
- **LICENSE**: MIT License para uso educativo
- **\_docs/**: Documentación técnica avanzada
- **Templates**: GitHub issue y PR templates

### Project Structure

```
bc-express/
├── 📁 semana-01/          # Fundamentos Express.js
├── 📁 semana-02/          # Node.js moderno
├── 📁 semana-03/          # Express.js intermedio
├── 📁 semana-04/          # Modelos y validación
├── 📁 semana-05/          # Base de datos
├── 📁 semana-06/          # CRUD completo
├── 📁 semana-07/          # Autenticación
├── 📁 semana-08/          # Testing y calidad
├── 📁 semana-09/          # Docker y containerización
├── 📁 semana-10/          # APIs avanzadas
├── 📁 semana-11/          # Proyecto final
├── 📁 _docs/              # Documentación técnica
├── 📁 _scripts/           # Scripts automatización
└── 📁 recursos-compartidos/ # Recursos del bootcamp
```

## [0.9.0] - 2025-08-15

### Added

- Migración completa de FastAPI a Express.js
- Actualización de stack tecnológico
- Nuevas convenciones de nomenclatura para TypeScript
- Documentación de pnpm como gestor exclusivo

### Changed

- **Framework**: FastAPI → Express.js
- **Language**: Python → TypeScript/Node.js
- **ORM**: SQLAlchemy → Prisma/TypeORM
- **Testing**: pytest → Jest/Supertest
- **Package Manager**: npm → pnpm (exclusive)

### Removed

- Todas las referencias a Python y FastAPI
- Configuraciones específicas de Python
- Dependencies de desarrollo Python

## [0.8.0] - 2025-08-10

### Added

- Sistema completo de gamificación
- Rúbricas de evaluación por semana
- Integración con valores SENA
- Templates de GitHub Issues y PRs

### Enhanced

- Estructura de documentación
- Guías de setup y configuración
- Metodología de enseñanza
- Flujos de trabajo Git/GitHub

## [0.5.0] - 2025-07-25

### Added

- Semanas 1-11 contenido base
- Estructura de proyecto inicial
- Documentación básica
- Scripts de automatización básicos

### Initial Features

- Estructura de bootcamp de 11 semanas
- Metodología de enseñanza definida
- Objetivos de aprendizaje claros
- Sistema de evaluación básico

---

## Tipos de Cambios

- **Added**: para nuevas funcionalidades
- **Changed**: para cambios en funcionalidades existentes
- **Deprecated**: para funcionalidades que serán removidas
- **Removed**: para funcionalidades removidas
- **Fixed**: para correcciones de bugs
- **Security**: para vulnerabilidades de seguridad

## Versioning Strategy

Este proyecto usa [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.y.z): Cambios incompatibles en el API o estructura del bootcamp
- **MINOR** (x.Y.z): Nuevas funcionalidades compatibles hacia atrás
- **PATCH** (x.y.Z): Correcciones de bugs y mejoras menores

## Release Process

1. **Development**: Cambios en ramas feature/\*
2. **Testing**: Validación de contenido y código
3. **Documentation**: Actualización de documentación
4. **Review**: Code review y approval
5. **Release**: Tag y publicación
6. **Communication**: Notificación a la comunidad

---

**Mantenido por**: Equipo bc-express  
**Última actualización**: 2025-08-19  
**Próxima release**: 1.1.0 (estimada para octubre 2025)
