Práctica de Ciberseguridad: IaC, Contenedores y API Segura
Este repositorio contiene la implementación práctica de múltiples controles de ciberseguridad divididos en tres fases principales: Infraestructura como Código (IaC), Seguridad de Contenedores y Desarrollo Seguro de APIs.
🚀 Fases del Proyecto
Fase 1: Infraestructura S3 segura con LocalStack y Terraform
Se aprovisionó un bucket S3 emulado localmente utilizando LocalStack. Mediante Terraform, se aplicaron controles de seguridad estrictos:
Cifrado del lado del servidor (SSE-S3 con AES-256).
Bloqueo de acceso público (Public Access Block) activando los 4 candados de seguridad.
Verificación del estado de seguridad utilizando AWS CLI local.
Fase 2: Seguridad de Contenedores con Trivy
Análisis y mitigación de vulnerabilidades en imágenes de Docker:
Escaneo de una imagen base obsoleta (node:14) utilizando Trivy, detectando múltiples vulnerabilidades críticas.
Actualización y escaneo de mitigación utilizando una versión segura (node:18).
Fase 3: Autenticación Segura (JWT) y Análisis DAST
Desarrollo de una API protegida y escaneo de vulnerabilidades:
Implementación de un servidor en Node.js y Express.
Middleware de autenticación utilizando JSON Web Tokens (JWT) para proteger endpoints sensibles (/api/admin).
Escaneo dinámico de la API (DAST) utilizando OWASP ZAP en contenedores.
🗺️ Diagrama de Arquitectura Segura
A continuación se muestra el flujo de datos y los componentes implementados en esta práctica:
```mermaid
graph TD
    %% Definición de Estilos
    classDef client fill:#3498db,stroke:#2980b9,stroke-width:2px,color:#fff;
    classDef auth fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:#fff;
    classDef api fill:#2ecc71,stroke:#27ae60,stroke-width:2px,color:#fff;
    classDef aws fill:#e67e22,stroke:#d35400,stroke-width:2px,color:#fff;


    %% Componentes
    Client([Usuario / Cliente web]) ::: client
    
    subgraph "Contenedor Node.js"
        JWT[Módulo de Autenticación JWT] ::: auth
        API[API Express Backend] ::: api
    end


    subgraph "Contenedor LocalStack"
        S3[(Amazon S3 Seguro\nAES-256 + Block Public)] ::: aws
    end


    %% Flujo de datos
    Client -- "1. Solicita Token" --> JWT
    JWT -- "2. Retorna Token firmado" --> Client
    Client -- "3. Petición + Header Authorization: Bearer" --> API
    API -- "4. Valida Token" --> JWT
    API -- "5. Acceso a recursos seguros" --> S3
```

🛠️ Requisitos
Docker y Docker Compose
Terraform
AWS CLI
Node.js y npm
⚙️ Ejecución
Para levantar la infraestructura local simulada:
Configurar el token en el archivo .env: LOCALSTACK_AUTH_TOKEN=tu_token
Levantar contenedor: docker compose up -d
Aplicar infraestructura: terraform init, terraform plan, terraform apply
