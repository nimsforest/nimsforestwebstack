# 🌲 nimsforestwebstack

Universal Web Stack Framework - Complete web stack generator using pure Makefile approach.

## 🚀 Getting Started

### Quick Start (5 minutes)

1. **Add to your project:**
   ```bash
   # Option A: Add as git submodule (recommended)
   git submodule add git@github.com:nimsforest/nimsforestwebstack.git tools/nimsforestwebstack
   
   # Option B: Clone directly
   git clone git@github.com:nimsforest/nimsforestwebstack.git tools/nimsforestwebstack
   ```

2. **Set up environment and integrate:**
   ```bash
   # Set your project root directory (REQUIRED)
   export PROJECTDIR=/path/to/your/project
   
   # Navigate to the framework
   cd tools/nimsforestwebstack
   
   # Add integration to your main Makefile
   make nimsforestwebstack-addtomainmake
   
   # Create .env file with defaults at project root
   make nimsforestwebstack-setupenv
   ```

3. **Initialize your web stack:**
   ```bash
   # Analyze your project (validates PROJECTDIR and .env)
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
    └── .gitignore                    # Build artifacts exclusion
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
**Note: All commands require `PROJECTDIR` environment variable to be set and must be run from `tools/nimsforestwebstack/`**

```bash
export PROJECTDIR=/path/to/your/project
cd tools/nimsforestwebstack

make nimsforestwebstack-hello        # Analyze project and show status
make nimsforestwebstack-setupenv     # Create .env file with defaults
make nimsforestwebstack-init         # Initialize webstack structure
make nimsforestwebstack-lint         # Validate project conformance
make nimsforestwebstack-test-all     # Test all components
make nimsforestwebstack-dev          # Start development environment
make nimsforestwebstack-clean        # Clean all build artifacts
make nimsforestwebstack-kill-servers # Stop all development servers
```

### Build and Deploy Commands
```bash
make build-all                       # Build for production
make test-all                        # Run all tests  
make deploy-all                      # Deploy complete stack
```

## ⚙️ Configuration

### Environment Variables (.env)
```bash
# Project configuration
PROJECT_NAME=my-web-project
DOMAIN=localhost
PROJECTDIR=/path/to/your/project

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
- **Project directory**: Set `PROJECTDIR` environment variable to your project root
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

nimsforestwebstack includes comprehensive deployment automation with GitHub Actions and Netlify integration.

### Quick Deployment Setup
```bash
# Set up automated deployment
make setup-githubactions-netlifydeployment

# Deploy to production
make deploy-website

# Create preview deployment
make deploy-preview
```

### Build for Production
```bash
make build-all                       # Build all components
make deploy-all                      # Deploy complete stack
```

### Docker Deployment
```bash
cd webstack
docker-compose -f docker-compose.dev.yml up --build
```

### 🛠️ Development Utilities
```bash
# Clean all build artifacts
make nimsforestwebstack-clean        # Removes .next, build, dist, Docker volumes

# Stop all running servers 
make nimsforestwebstack-kill-servers # Kills processes and frees ports 1313, 3000, 3001, 8080, 8081
```

### 📖 Complete Deployment Guide
For detailed deployment setup, configuration, and troubleshooting, see:
**[Deployment Tooling Documentation](docs/deploymenttools.md)**

Features:
- ✅ GitHub Actions CI/CD
- ✅ Netlify production + preview deployments  
- ✅ Automated secrets management
- ✅ Multi-project support
- ✅ Comprehensive validation

## 📋 Requirements

### System Requirements
- **Make** - Build automation (available on all Unix systems)
- **Docker** - Containerization
- **Node.js 20+** - JavaScript runtime
- **Go 1.21+** - Backend services
- **Hugo** - Static site generator

### Project Requirements
- **PROJECTDIR environment variable** - Must point to your project root
- **Root Makefile** - Must include nimsforestwebstack
- **Root .env file** - Environment configuration (created automatically)
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

## 🔧 Troubleshooting

### Common Issues

**"PROJECTDIR environment variable not set"**
```bash
# Solution: Set PROJECTDIR to your project root
export PROJECTDIR=/path/to/your/project
cd tools/nimsforestwebstack
make nimsforestwebstack-hello
```

**"PROJECTDIR directory does not exist"**
```bash
# Solution: Ensure the path exists and is correct
ls -la $PROJECTDIR  # Check if directory exists
export PROJECTDIR=/correct/path/to/your/project
```

**Commands not working from project root**
```bash
# All commands must be run from tools/nimsforestwebstack/
cd tools/nimsforestwebstack
make nimsforestwebstack-hello
```

## 🔗 Links

- **Documentation**: [Full documentation](docs/)
- **Examples**: [Example projects](examples/)
- **Templates**: [Project templates](templates/)
- **Issues**: [Report bugs](issues/)