# 🌲 nimsforestwebstack

Universal Web Stack Framework - Complete web stack generator using pure Makefile approach.

## 🚀 Getting Started

### Quick Start (5 minutes)

1. **Add to your project:**
   ```bash
   # Option A: Clone as git submodule (recommended)
   git submodule add <repo-url> tools/nimsforestwebstack
   
   # Option B: Clone directly
   git clone <repo-url> tools/nimsforestwebstack
   ```

2. **Integrate with your project:**
   Add this line to your main `Makefile`:
   ```makefile
   -include tools/nimsforestwebstack/Makefile
   ```

3. **Initialize your web stack:**
   ```bash
   # Create .env file with defaults
   make nimsforestwebstack-setupenv
   
   # Analyze your project
   make nimsforestwebstack-hello
   
   # Initialize the web stack structure
   make nimsforestwebstack-init
   
   # Test all components
   make nimsforestwebstack-test-all
   ```

4. **Start developing:**
   ```bash
   # Start all services in development mode
   make nimsforestwebstack-dev
   ```

Your web stack will be available at:
- **Hugo Site**: http://localhost:1313 (Content management)
- **Next.js Tools**: http://localhost:3001 (Interactive tools)
- **Next.js App**: http://localhost:3000 (Dynamic application)
- **API Gateway**: http://localhost:8080 (Backend services)

## 🏗️ What You Get

nimsforestwebstack creates a complete, production-ready web stack:

```
your-project/
├── .env                              # Environment configuration
├── Makefile                          # Your main Makefile (includes nimsforestwebstack)
└── webstack/                         # Generated web stack
    ├── hugo-site/                    # Content management (Hugo)
    ├── nextjs-tools/                 # Interactive tools (Next.js static)
    ├── nextjs-app/                   # Dynamic application (Next.js SSR)
    ├── api/                          # Backend API (Go)
    ├── auth/                         # Authentication (Zitadel)
    ├── infrastructure/               # Nginx, Docker configs
    ├── docker-compose.dev.yml        # Development environment
    ├── .gitignore                    # Build artifacts exclusion
    └── Makefile.nimsforestwebstack   # Web stack commands
```

## 📦 Components

| Component | Technology | Purpose | Port |
|-----------|------------|---------|------|
| **Content Management** | Hugo + Docsy | Static site, documentation, marketing pages | 1313 |
| **Interactive Tools** | Next.js (Static) | Calculators, forms, interactive components | 3001 |
| **Dynamic Application** | Next.js (SSR) | User dashboard, dynamic pages, SPA | 3000 |
| **API Gateway** | Go | Backend services, data processing, integrations | 8080 |
| **Authentication** | Zitadel | User management, SSO, security | 8081 |
| **Infrastructure** | Nginx + Docker | Load balancing, SSL, containerization | - |

## 🔧 Available Commands

### Core Commands
```bash
make nimsforestwebstack-hello        # Analyze project and show status
make nimsforestwebstack-setupenv     # Create .env file with defaults
make nimsforestwebstack-init         # Initialize webstack structure
make nimsforestwebstack-lint         # Validate project conformance
make nimsforestwebstack-test-all     # Test all components
make nimsforestwebstack-dev          # Start development environment
```

### From webstack directory
```bash
cd webstack && make help             # Show all webstack commands
cd webstack && make dev              # Start all services
cd webstack && make build-all        # Build for production
cd webstack && make test-all         # Run all tests
```

## ⚙️ Configuration

### Environment Variables (.env)
```bash
# Project configuration
PROJECT_NAME=my-web-project
DOMAIN=localhost

# Directory paths
WEBSTACK_DIR=webstack

# Service ports
HUGO_PORT=1313
NEXTJS_STATIC_PORT=3001
NEXTJS_SSR_PORT=3000
API_PORT=8080
AUTH_PORT=8081

# Database
POSTGRES_DB=webstack
POSTGRES_USER=webstack
POSTGRES_PASSWORD=webstack_dev_password
```

### Customization
- **Project name**: Edit `PROJECT_NAME` in `.env`
- **Domain**: Edit `DOMAIN` in `.env` for production
- **Ports**: Modify port variables to avoid conflicts
- **Directory structure**: Change `WEBSTACK_DIR` if needed

## 🛠️ Development Workflow

### 1. Content Management (Hugo)
```bash
cd webstack/hugo-site
hugo server --buildDrafts
# Edit content in content/
# Customize layouts in layouts/
```

### 2. Interactive Tools (Next.js Static)
```bash
cd webstack/nextjs-tools
npm run dev
# Build calculators, forms, interactive components
# Export as static files
```

### 3. Dynamic Application (Next.js SSR)
```bash
cd webstack/nextjs-app
npm run dev
# Build user dashboard, dynamic pages
# Server-side rendering for SEO
```

### 4. Backend API (Go)
```bash
cd webstack/api
go run .
# Implement business logic
# Connect to databases
# Handle authentication
```

## 🧪 Testing

### Individual Components
```bash
make nimsforestwebstack-test-all     # Test all components
cd webstack && make test-hugo        # Test Hugo site
cd webstack && make test-nextjs      # Test Next.js applications
cd webstack && make test-api         # Test API gateway
```

### Validation
```bash
make nimsforestwebstack-lint         # Validate project structure
# Checks:
# - Directory structure (6 directories)
# - Required files (10+ files)
# - Package.json configurations (Next.js 14.x, React 18.x)
# - ESLint configurations
# - Docker setup
# - .gitignore patterns
```

## 🚀 Deployment

### Build for Production
```bash
cd webstack && make build-all        # Build all components
cd webstack && make deploy-all       # Deploy complete stack
```

### Docker Deployment
```bash
cd webstack
docker-compose -f docker-compose.dev.yml up --build
```

## 📋 Requirements

### System Requirements
- **Make** - Build automation (available on all Unix systems)
- **Docker** - Containerization
- **Node.js 20+** - JavaScript runtime
- **Go 1.21+** - Backend services
- **Hugo** - Static site generator

### Project Requirements
- **Root Makefile** - Must include nimsforestwebstack
- **Root .env file** - Environment configuration
- **Git repository** - Version control (recommended)

## 🎯 Use Cases

### Perfect for:
- **SaaS Applications** - Complete stack with auth, API, and frontend
- **Documentation Sites** - Hugo for docs + interactive tools
- **Marketing + Product** - Static marketing site + dynamic app
- **Startup MVPs** - Rapid prototyping with production-ready structure
- **Enterprise Portals** - Content management + user dashboard

### Architecture Benefits:
- **Separation of Concerns** - Each component has a specific purpose
- **Technology Flexibility** - Mix static and dynamic as needed
- **Scalable** - Components can be deployed independently
- **SEO Optimized** - Static content + SSR for dynamic pages
- **Developer Friendly** - Hot reload, testing, linting built-in

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make changes and test: `make nimsforestwebstack-test-all`
4. Commit changes: `git commit -m "Add feature"`
5. Push and create PR: `git push origin feature-name`

## 📄 License

MIT License - see LICENSE file for details.

## 🔗 Links

- **Documentation**: [Full documentation](docs/)
- **Examples**: [Example projects](examples/)
- **Templates**: [Project templates](templates/)
- **Issues**: [Report bugs](issues/)