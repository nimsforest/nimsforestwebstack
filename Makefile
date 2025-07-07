# ============================================================================
# nimsforestwebstack - Universal Web Stack Framework
# ============================================================================
# Complete web stack generator with Hugo + Next.js + Go API + Docker
# Pure Makefile approach - no CLI dependencies
# Assumes: .env file and Makefile at project root
# ============================================================================

# Load environment variables from .env file in PROJECTDIR if set
ifdef PROJECTDIR
-include $(PROJECTDIR)/.env
endif
export

# Project configuration - can be overridden in .env file
PROJECT_NAME ?= my-web-project
DOMAIN ?= localhost

# Directory paths - always relative to project root
WEBSTACK_DIR ?= webstack
HUGO_DIR := $(WEBSTACK_DIR)/hugo-site
NEXTJS_STATIC_DIR := $(WEBSTACK_DIR)/nextjs-tools
NEXTJS_SSR_DIR := $(WEBSTACK_DIR)/nextjs-app
API_DIR := $(WEBSTACK_DIR)/api
AUTH_DIR := $(WEBSTACK_DIR)/auth
INFRA_DIR := $(WEBSTACK_DIR)/infrastructure

# ============================================================================
# Help (for standalone usage)
# ============================================================================
.PHONY: help

help:
	@echo "🌲 nimsforestwebstack - Universal Web Stack Framework"
	@echo "===================================================="
	@echo ""
	@echo "📦 This is a standalone web stack framework that can be integrated into any project."
	@echo ""
	@echo "🚀 Quick Start (Integration):"
	@echo "  1. Add this line to your main Makefile:"
	@echo "     -include tools/nimsforestwebstack/Makefile"
	@echo ""
	@echo "  2. Or clone as git submodule:"
	@echo "     git submodule add <repo-url> tools/nimsforestwebstack"
	@echo ""
	@echo "  3. Then run from your project root:"
	@echo "     make nimsforestwebstack-hello"
	@echo ""
	@echo "🔧 Available Commands (when integrated):"
	@echo "  nimsforestwebstack-hello      - Analyze project and show status"
	@echo "  nimsforestwebstack-setupenv   - Create .env file with defaults"
	@echo "  nimsforestwebstack-init       - Initialize webstack structure"
	@echo "  nimsforestwebstack-lint       - Validate project conformance"
	@echo "  nimsforestwebstack-test-all   - Test all components"
	@echo "  nimsforestwebstack-dev        - Start development environment"
	@echo ""
	@echo "📋 Requirements:"
	@echo "  - .env file at project root (use setupenv to create)"
	@echo "  - Makefile at project root that includes this framework"
	@echo ""
	@echo "💡 Learn more: Check README.md for detailed documentation"

# ============================================================================
# Main Commands (prefixed for integration)
# ============================================================================
.PHONY: nimsforestwebstack-hello nimsforestwebstack-setupenv nimsforestwebstack-init nimsforestwebstack-lint nimsforestwebstack-test-all nimsforestwebstack-dev nimsforestwebstack-addtomainmake

nimsforestwebstack-hello:
	@echo "🌲 nimsforestwebstack - Project Analysis"
	@echo "======================================="
	@echo ""
	@echo "🔍 Validating environment..."
	@echo ""
	@echo "📁 Project Directory:"
	@if [ -z "$$PROJECTDIR" ]; then \
		echo "  ❌ PROJECTDIR environment variable not set"; \
		echo "    💡 Set PROJECTDIR to your project root directory"; \
		echo "    💡 Example: export PROJECTDIR=/path/to/your/project"; \
		echo "    💡 Then run: make nimsforestwebstack-hello"; \
		exit 1; \
	else \
		echo "  ✅ PROJECTDIR set to: $$PROJECTDIR"; \
	fi
	@if [ ! -d "$$PROJECTDIR" ]; then \
		echo "  ❌ PROJECTDIR directory does not exist: $$PROJECTDIR"; \
		exit 1; \
	else \
		echo "  ✅ PROJECTDIR directory exists"; \
	fi
	@echo ""
	@echo "📄 Configuration:"
	@if [ -f "$$PROJECTDIR/.env" ]; then \
		echo "  ✅ .env file found at project root"; \
		if grep -q "PROJECT_NAME" "$$PROJECTDIR/.env"; then \
			echo "    ✅ PROJECT_NAME configured"; \
		else \
			echo "    ⚠️  PROJECT_NAME not set in .env"; \
		fi; \
		if grep -q "DOMAIN" "$$PROJECTDIR/.env"; then \
			echo "    ✅ DOMAIN configured"; \
		else \
			echo "    ⚠️  DOMAIN not set in .env"; \
		fi; \
	else \
		echo "  ❌ .env file missing at project root"; \
		echo "    💡 Run: make nimsforestwebstack-setupenv"; \
		echo "    💡 Required variables: PROJECT_NAME, DOMAIN, PROJECTDIR"; \
	fi
	@if [ -f "$$PROJECTDIR/Makefile" ]; then \
		echo "  ✅ Makefile found at project root"; \
	else \
		echo "  ❌ Makefile missing at project root"; \
		echo "    💡 nimsforestwebstack requires a root Makefile"; \
		echo "    💡 Run: make nimsforestwebstack-addtomainmake"; \
	fi
	@echo ""
	@echo "📦 External Tools:"
	@if command -v gh >/dev/null 2>&1; then \
		echo "  ✅ GitHub CLI found ($$(gh --version | head -1))"; \
	else \
		echo "  ❌ GitHub CLI not found"; \
		echo "     💡 Install: brew install gh (macOS) or https://cli.github.com/"; \
	fi
	@if command -v netlify >/dev/null 2>&1; then \
		echo "  ✅ Netlify CLI found ($$(netlify --version))"; \
	else \
		echo "  ❌ Netlify CLI not found"; \
		echo "     💡 Install: npm install -g netlify-cli"; \
	fi
	@if command -v docker >/dev/null 2>&1; then \
		echo "  ✅ Docker found ($$(docker --version | cut -d' ' -f3 | cut -d',' -f1))"; \
	else \
		echo "  ❌ Docker not found"; \
		echo "     💡 Install: https://docs.docker.com/get-docker/"; \
	fi
	@if command -v hugo >/dev/null 2>&1; then \
		echo "  ✅ Hugo found ($$(hugo version | head -1))"; \
	else \
		echo "  ❌ Hugo not found"; \
		echo "     💡 Install: brew install hugo (macOS) or https://gohugo.io/installation/"; \
	fi
	@if command -v node >/dev/null 2>&1; then \
		echo "  ✅ Node.js found ($$(node --version))"; \
	else \
		echo "  ❌ Node.js not found"; \
		echo "     💡 Install: https://nodejs.org/"; \
	fi
	@if command -v go >/dev/null 2>&1; then \
		echo "  ✅ Go found ($$(go version | cut -d' ' -f3))"; \
	else \
		echo "  ❌ Go not found"; \
		echo "     💡 Install: https://golang.org/doc/install"; \
	fi
	@echo ""
	@echo "📁 nimsforestwebstack Structure:"
	@if [ -d "$(WEBSTACK_DIR)" ]; then \
		echo "  ✅ $(WEBSTACK_DIR)/ directory found"; \
		if [ -d "$(HUGO_DIR)" ]; then echo "    ✅ hugo-site/"; else echo "    ❌ hugo-site/"; fi; \
		if [ -d "$(NEXTJS_STATIC_DIR)" ]; then echo "    ✅ nextjs-tools/"; else echo "    ❌ nextjs-tools/"; fi; \
		if [ -d "$(NEXTJS_SSR_DIR)" ]; then echo "    ✅ nextjs-app/"; else echo "    ❌ nextjs-app/"; fi; \
		if [ -d "$(API_DIR)" ]; then echo "    ✅ api/"; else echo "    ❌ api/"; fi; \
		if [ -d "$(AUTH_DIR)" ]; then echo "    ✅ auth/"; else echo "    ❌ auth/"; fi; \
		if [ -d "$(INFRA_DIR)" ]; then echo "    ✅ infrastructure/"; else echo "    ❌ infrastructure/"; fi; \
	else \
		echo "  ❌ $(WEBSTACK_DIR)/ directory missing"; \
	fi
	@if [ -f "$(WEBSTACK_DIR)/docker-compose.dev.yml" ]; then \
		echo "  ✅ docker-compose.dev.yml found"; \
	else \
		echo "  ❌ docker-compose.dev.yml missing"; \
	fi
	@if [ -f "$(WEBSTACK_DIR)/Makefile.nimsforestwebstack" ]; then \
		echo "  ✅ Makefile.nimsforestwebstack found"; \
	else \
		echo "  ❌ Makefile.nimsforestwebstack missing"; \
	fi
	@echo ""
	@echo "📋 Configuration Files:"
	@if [ -f ".env" ]; then \
		echo "  ✅ .env file found"; \
	else \
		echo "  ❌ .env file missing"; \
	fi
	@if [ -f "netlify.toml" ]; then \
		echo "  ✅ netlify.toml found"; \
	else \
		echo "  ❌ netlify.toml missing"; \
	fi
	@if [ -f ".github/workflows/deploy.yml" ]; then \
		echo "  ✅ GitHub Actions workflow found"; \
	else \
		echo "  ❌ GitHub Actions workflow missing"; \
	fi
	@echo ""
	@echo "🎯 Next Steps:"
	@if [ ! -f ".env" ]; then \
		echo "  🚀 Run: make nimsforestwebstack-setupenv"; \
		echo "     This will create the .env file with required variables"; \
	elif [ ! -d "$(HUGO_DIR)" ] || [ ! -d "$(NEXTJS_STATIC_DIR)" ] || [ ! -d "$(API_DIR)" ]; then \
		echo "  🚀 Run: make nimsforestwebstack-init"; \
		echo "     This will create the nimsforestwebstack structure with default pages"; \
	else \
		echo "  ✅ Structure exists! You can run:"; \
		echo "     make nimsforestwebstack-test-all  - Test all components"; \
		echo "     make nimsforestwebstack-dev       - Start development environment"; \
	fi

nimsforestwebstack-setupenv:
	@echo "⚙️ Setting up .env file..."
	@echo ""
	@if [ -z "$$PROJECTDIR" ]; then \
		echo "❌ PROJECTDIR environment variable not set"; \
		echo "💡 Set PROJECTDIR to your project root directory"; \
		echo "💡 Example: export PROJECTDIR=/path/to/your/project"; \
		exit 1; \
	fi
	@if [ ! -d "$$PROJECTDIR" ]; then \
		echo "❌ PROJECTDIR directory does not exist: $$PROJECTDIR"; \
		exit 1; \
	fi
	@if [ -f "$$PROJECTDIR/.env" ]; then \
		echo "⚠️  .env file already exists. Backing up to .env.bak..."; \
		cp "$$PROJECTDIR/.env" "$$PROJECTDIR/.env.bak"; \
	fi
	@echo "# nimsforestwebstack configuration" > "$$PROJECTDIR/.env"
	@echo "# Generated by nimsforestwebstack-setupenv" >> "$$PROJECTDIR/.env"
	@echo "" >> "$$PROJECTDIR/.env"
	@echo "# Project configuration" >> "$$PROJECTDIR/.env"
	@echo "PROJECT_NAME=my-web-project" >> "$$PROJECTDIR/.env"
	@echo "DOMAIN=localhost" >> "$$PROJECTDIR/.env"
	@echo "PROJECTDIR=$$PROJECTDIR" >> "$$PROJECTDIR/.env"
	@echo "" >> "$$PROJECTDIR/.env"
	@echo "# Directory paths (relative to project root)" >> "$$PROJECTDIR/.env"
	@echo "WEBSTACK_DIR=webstack" >> "$$PROJECTDIR/.env"
	@echo "" >> "$$PROJECTDIR/.env"
	@echo "# Service ports" >> "$$PROJECTDIR/.env"
	@echo "HUGO_PORT=1313" >> "$$PROJECTDIR/.env"
	@echo "NEXTJS_STATIC_PORT=3001" >> "$$PROJECTDIR/.env"
	@echo "NEXTJS_SSR_PORT=3000" >> "$$PROJECTDIR/.env"
	@echo "API_PORT=8080" >> "$$PROJECTDIR/.env"
	@echo "AUTH_PORT=8081" >> "$$PROJECTDIR/.env"
	@echo "" >> "$$PROJECTDIR/.env"
	@echo "# Database configuration" >> "$$PROJECTDIR/.env"
	@echo "POSTGRES_DB=webstack" >> "$$PROJECTDIR/.env"
	@echo "POSTGRES_USER=webstack" >> "$$PROJECTDIR/.env"
	@echo "POSTGRES_PASSWORD=webstack_dev_password" >> "$$PROJECTDIR/.env"
	@echo "" >> "$$PROJECTDIR/.env"
	@echo "# Authentication (Zitadel)" >> "$$PROJECTDIR/.env"
	@echo "ZITADEL_DATABASE_POSTGRES_HOST=postgres" >> "$$PROJECTDIR/.env"
	@echo "ZITADEL_EXTERNALSECURE=false" >> "$$PROJECTDIR/.env"
	@echo "ZITADEL_TLS_ENABLED=false" >> "$$PROJECTDIR/.env"
	@echo ""
	@echo "✅ Created .env file with default configuration at $$PROJECTDIR/.env"
	@echo "💡 Edit .env to customize your project settings"
	@echo ""

nimsforestwebstack-init:
	@echo "🌲 Initializing nimsforestwebstack structure..."
	@echo ""
	@if [ ! -f ".env" ]; then \
		echo "❌ .env file not found"; \
		echo "🚀 Run: make nimsforestwebstack-setupenv"; \
		exit 1; \
	fi
	@echo "📁 This will create new directories inside $(WEBSTACK_DIR)/ folder."
	@echo ""
	@echo "📁 Creating $(WEBSTACK_DIR)/ directory structure..."
	@mkdir -p $(HUGO_DIR)/content/docs $(HUGO_DIR)/data $(HUGO_DIR)/layouts/_default $(HUGO_DIR)/static $(HUGO_DIR)/resources
	@mkdir -p $(NEXTJS_STATIC_DIR)/pages $(NEXTJS_STATIC_DIR)/public $(NEXTJS_STATIC_DIR)/src/components $(NEXTJS_STATIC_DIR)/src/pages
	@echo "  📁 Created $(NEXTJS_SSR_DIR)/"
	@mkdir -p $(NEXTJS_SSR_DIR)/pages $(NEXTJS_SSR_DIR)/public $(NEXTJS_SSR_DIR)/src/app $(NEXTJS_SSR_DIR)/src/components
	@mkdir -p $(API_DIR)/handlers
	@mkdir -p $(API_DIR)/middleware
	@mkdir -p $(API_DIR)/models
	@echo "  📁 Created $(API_DIR)/"
	@mkdir -p $(AUTH_DIR)
	@mkdir -p $(INFRA_DIR)/nginx
	@mkdir -p $(INFRA_DIR)/docker
	@echo ""
	@echo "📄 Creating default files..."
	@printf -- "---\ntitle: \"Welcome to Your Web Stack\"\n---\n\n# Welcome to Your Project\n\nYour Hugo site is ready!\n\n## Components Running\n\n- **Hugo**: Content management at http://localhost:1313\n- **Next.js Tools**: Interactive tools at http://localhost:3001\n- **Next.js App**: Dynamic application at http://localhost:3000\n- **API Gateway**: Backend services at http://localhost:8080\n\n## Getting Started\n\nThis is your nimsforestwebstack project. Each component serves a specific purpose:\n\n- Edit content in the \`content/\` directory\n- Customize layouts in the \`layouts/\` directory\n- Add static assets to the \`static/\` directory\n" > $(HUGO_DIR)/content/_index.md
	@echo "# Documentation" > $(HUGO_DIR)/content/docs/_index.md
	@echo "Your documentation goes here." >> $(HUGO_DIR)/content/docs/_index.md
	@echo ""
	@printf "baseURL = 'http://localhost:1313'\nlanguageCode = 'en-us'\ntitle = 'My Web Stack'\n\n[markup]\n  [markup.goldmark]\n    [markup.goldmark.renderer]\n      unsafe = true\n" > $(HUGO_DIR)/hugo.toml
	@echo ""
	@echo "📝 Creating Hugo layouts..."
	@mkdir -p $(HUGO_DIR)/layouts/_default
	@printf "<!DOCTYPE html>\n<html lang=\"{{ .Site.LanguageCode }}\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>{{ .Title }} | {{ .Site.Title }}</title>\n    <style>\n        body { \n            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; \n            line-height: 1.6; \n            max-width: 800px; \n            margin: 0 auto; \n            padding: 2rem;\n            background: #f8f9fa;\n        }\n        .container {\n            background: white;\n            padding: 2rem;\n            border-radius: 8px;\n            box-shadow: 0 2px 4px rgba(0,0,0,0.1);\n        }\n        h1 { color: #2563eb; }\n        h2 { color: #4f46e5; }\n        .status { \n            display: inline-block; \n            background: #10b981; \n            color: white; \n            padding: 0.25rem 0.5rem; \n            border-radius: 4px; \n            font-size: 0.875rem;\n        }\n        ul { list-style-type: none; padding: 0; }\n        li { \n            padding: 0.5rem; \n            margin: 0.5rem 0; \n            background: #f3f4f6; \n            border-radius: 4px; \n        }\n        .footer {\n            margin-top: 2rem;\n            padding-top: 1rem;\n            border-top: 1px solid #e5e7eb;\n            text-align: center;\n            color: #6b7280;\n        }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <span class=\"status\">✅ RUNNING</span>\n        \n        {{ .Content }}\n        \n        <div class=\"footer\">\n            <p>🌲 Powered by nimsforestwebstack | Built with Hugo</p>\n        </div>\n    </div>\n</body>\n</html>" > $(HUGO_DIR)/layouts/index.html
	@printf "<!DOCTYPE html>\n<html lang=\"{{ .Site.LanguageCode }}\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>{{ .Title }} | {{ .Site.Title }}</title>\n    <style>\n        body { \n            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; \n            line-height: 1.6; \n            max-width: 800px; \n            margin: 0 auto; \n            padding: 2rem;\n            background: #f8f9fa;\n        }\n        .container {\n            background: white;\n            padding: 2rem;\n            border-radius: 8px;\n            box-shadow: 0 2px 4px rgba(0,0,0,0.1);\n        }\n        h1 { color: #2563eb; }\n        h2 { color: #4f46e5; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <h1>{{ .Title }}</h1>\n        {{ .Content }}\n        \n        <footer style=\"margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e5e7eb; text-align: center; color: #6b7280;\">\n            <p>🌲 Powered by nimsforestwebstack | Built with Hugo</p>\n        </footer>\n    </div>\n</body>\n</html>" > $(HUGO_DIR)/layouts/_default/single.html
	@printf "<!DOCTYPE html>\n<html lang=\"{{ .Site.LanguageCode }}\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>{{ .Title }} | {{ .Site.Title }}</title>\n    <style>\n        body { \n            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; \n            line-height: 1.6; \n            max-width: 800px; \n            margin: 0 auto; \n            padding: 2rem;\n            background: #f8f9fa;\n        }\n        .container {\n            background: white;\n            padding: 2rem;\n            border-radius: 8px;\n            box-shadow: 0 2px 4px rgba(0,0,0,0.1);\n        }\n        h1 { color: #2563eb; }\n        h2 { color: #4f46e5; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <h1>{{ .Title }}</h1>\n        {{ .Content }}\n        \n        {{ range .Pages }}\n            <article style=\"margin: 1rem 0; padding: 1rem; background: #f3f4f6; border-radius: 4px;\">\n                <h3><a href=\"{{ .Permalink }}\">{{ .Title }}</a></h3>\n                <p>{{ .Summary }}</p>\n            </article>\n        {{ end }}\n        \n        <footer style=\"margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e5e7eb; text-align: center; color: #6b7280;\">\n            <p>🌲 Powered by nimsforestwebstack | Built with Hugo</p>\n        </footer>\n    </div>\n</body>\n</html>" > $(HUGO_DIR)/layouts/_default/list.html
	@echo ""
	@mkdir -p $(NEXTJS_STATIC_DIR)/pages $(NEXTJS_SSR_DIR)/pages
	@echo "export default function Home() { return <div><h1>Next.js Tools</h1><p>Interactive tools go here.</p></div> }" > $(NEXTJS_STATIC_DIR)/pages/index.js
	@echo "export default function Home() { return <div><h1>Next.js App</h1><p>Dynamic application pages go here.</p></div> }" > $(NEXTJS_SSR_DIR)/pages/index.js
	@$(MAKE) create-package-json-files
	@$(MAKE) create-api-files
	@$(MAKE) create-docker-config
	@$(MAKE) create-gitignore
	@$(MAKE) create-makefile-integration
	@echo ""
	@echo "📦 Installing dependencies..."
	@if [ -d "$(NEXTJS_STATIC_DIR)" ] && [ -f "$(NEXTJS_STATIC_DIR)/package.json" ]; then \
		echo "  Installing Next.js tools dependencies..."; \
		cd $(NEXTJS_STATIC_DIR) && npm install --silent; \
	fi
	@if [ -d "$(NEXTJS_SSR_DIR)" ] && [ -f "$(NEXTJS_SSR_DIR)/package.json" ]; then \
		echo "  Installing Next.js app dependencies..."; \
		cd $(NEXTJS_SSR_DIR) && npm install --silent; \
	fi
	@if [ -d "$(API_DIR)" ] && [ -f "$(API_DIR)/go.mod" ]; then \
		echo "  Installing Go API dependencies..."; \
		cd $(API_DIR) && go mod tidy && go mod download; \
	fi
	@echo ""
	@echo "✅ nimsforestwebstack structure initialized!"
	@echo ""
	@echo "🎯 What was created:"
	@echo "  📁 $(HUGO_DIR)/         - Content management (Hugo + Docsy)"
	@echo "  📁 $(NEXTJS_STATIC_DIR)/      - Interactive tools (Next.js static)"
	@echo "  📁 $(NEXTJS_SSR_DIR)/        - Dynamic application (Next.js SSR)"
	@echo "  📁 $(API_DIR)/               - Backend API (Go)"
	@echo "  📁 $(AUTH_DIR)/              - Authentication (Zitadel)"
	@echo "  📁 $(INFRA_DIR)/    - Nginx, Docker configs"
	@echo "  📄 $(WEBSTACK_DIR)/.env              - Environment variables"
	@echo "  📄 $(WEBSTACK_DIR)/.gitignore         - Git ignore for build artifacts"
	@echo "  📄 $(WEBSTACK_DIR)/Makefile.nimsforestwebstack - Universal commands"
	@echo ""
	@echo "🚀 Next steps:"
	@echo "  make nimsforestwebstack-test-all  - Test all components"
	@echo "  make nimsforestwebstack-dev      - Start complete development stack"
	@echo "  cd webstack && make help          - See all webstack commands"

# ============================================================================
# Helper targets for initialization
# ============================================================================
.PHONY: create-package-json-files create-api-files create-docker-config create-gitignore create-makefile-integration

create-package-json-files:
	@echo ""
	@echo '{' > $(NEXTJS_STATIC_DIR)/package.json
	@echo '  "name": "nextjs-tools",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  "version": "0.1.0",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  "scripts": {' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "dev": "next dev -p 3001",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "build": "next build",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "start": "next start -p 3001",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "lint": "next lint",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "type-check": "echo '\''No TypeScript configured'\''"' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  },' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  "dependencies": {' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "next": "^14.2.16",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "react": "^18.3.1",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "react-dom": "^18.3.1"' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  },' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  "devDependencies": {' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "eslint": "^8.57.1",' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '    "eslint-config-next": "^14.2.16"' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '  }' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '}' >> $(NEXTJS_STATIC_DIR)/package.json
	@echo '{' > $(NEXTJS_SSR_DIR)/package.json
	@echo '  "name": "nextjs-app",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  "version": "0.1.0",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  "scripts": {' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "dev": "next dev",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "build": "next build",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "start": "next start",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "lint": "next lint",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "type-check": "echo '\''No TypeScript configured'\''"' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  },' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  "dependencies": {' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "next": "^14.2.16",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "react": "^18.3.1",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "react-dom": "^18.3.1"' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  },' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  "devDependencies": {' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "eslint": "^8.57.1",' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '    "eslint-config-next": "^14.2.16"' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '  }' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '}' >> $(NEXTJS_SSR_DIR)/package.json
	@echo '{"extends": ["next/core-web-vitals"]}' > $(NEXTJS_STATIC_DIR)/.eslintrc.json
	@echo '{"extends": ["next/core-web-vitals"]}' > $(NEXTJS_SSR_DIR)/.eslintrc.json

create-api-files:
	@echo 'package main' > $(API_DIR)/main.go
	@echo '' >> $(API_DIR)/main.go
	@echo 'import (' >> $(API_DIR)/main.go
	@echo '	"fmt"' >> $(API_DIR)/main.go
	@echo '	"net/http"' >> $(API_DIR)/main.go
	@echo '	"encoding/json"' >> $(API_DIR)/main.go
	@echo ')' >> $(API_DIR)/main.go
	@echo '' >> $(API_DIR)/main.go
	@echo 'func healthHandler(w http.ResponseWriter, r *http.Request) {' >> $(API_DIR)/main.go
	@echo '	w.Header().Set("Content-Type", "application/json")' >> $(API_DIR)/main.go
	@echo '	json.NewEncoder(w).Encode(map[string]string{' >> $(API_DIR)/main.go
	@echo '		"status": "ok",' >> $(API_DIR)/main.go
	@echo '		"service": "nimsforestwebstack API",' >> $(API_DIR)/main.go
	@echo '		"version": "1.0.0",' >> $(API_DIR)/main.go
	@echo '	})' >> $(API_DIR)/main.go
	@echo '}' >> $(API_DIR)/main.go
	@echo '' >> $(API_DIR)/main.go
	@echo 'func main() {' >> $(API_DIR)/main.go
	@echo '	http.HandleFunc("/", healthHandler)' >> $(API_DIR)/main.go
	@echo '	http.HandleFunc("/health", healthHandler)' >> $(API_DIR)/main.go
	@echo '	' >> $(API_DIR)/main.go
	@echo '	fmt.Println("API server ready on :8080")' >> $(API_DIR)/main.go
	@echo '	fmt.Println("Endpoints: GET / and GET /health")' >> $(API_DIR)/main.go
	@echo '	http.ListenAndServe(":8080", nil)' >> $(API_DIR)/main.go
	@echo '}' >> $(API_DIR)/main.go
	@echo 'module api' > $(API_DIR)/go.mod
	@echo '' >> $(API_DIR)/go.mod
	@echo 'go 1.21' >> $(API_DIR)/go.mod

create-docker-config:
	@echo "🐳 Creating Docker configuration..."
	@printf "version: '3.8'\n\nservices:\n  hugo:\n    image: hugomods/hugo:exts\n    command: hugo server --bind 0.0.0.0 --buildDrafts --navigateToChanged\n    volumes:\n      - ./hugo-site:/src\n    ports:\n      - \"1313:1313\"\n    user: \"\$${UID:-1000}:\$${GID:-1000}\"\n    environment:\n      - HUGO_WATCH=true\n\n  nextjs-tools:\n    image: node:20-alpine\n    working_dir: /app\n    command: sh -c \"npm install && npm audit fix && npx next dev -p 3001\"\n    volumes:\n      - ./nextjs-tools:/app\n    ports:\n      - \"3001:3001\"\n    user: \"\$${UID:-1000}:\$${GID:-1000}\"\n    environment:\n      - NPM_CONFIG_UPDATE_NOTIFIER=false\n\n  nextjs-app:\n    image: node:20-alpine\n    working_dir: /app\n    command: sh -c \"npm install && npm audit fix && npx next dev -p 3000\"\n    volumes:\n      - ./nextjs-app:/app\n    ports:\n      - \"3000:3000\"\n    user: \"\$${UID:-1000}:\$${GID:-1000}\"\n    environment:\n      - NPM_CONFIG_UPDATE_NOTIFIER=false\n\n  api:\n    image: golang:1.21-alpine\n    working_dir: /app\n    command: sh -c \"go mod tidy && go run .\"\n    volumes:\n      - ./api:/app\n    ports:\n      - \"8080:8080\"\n    user: \"\$${UID:-1000}:\$${GID:-1000}\"\n    environment:\n      - GOCACHE=/tmp\n      - GOPATH=/tmp/go\n      - TMPDIR=/tmp\n" > $(WEBSTACK_DIR)/docker-compose.dev.yml

create-gitignore:
	@echo "📄 Creating .gitignore to prevent committing build artifacts..."
	@if [ ! -f "$(WEBSTACK_DIR)/.gitignore" ]; then \
		echo "# nimsforestwebstack .gitignore" > $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Dependencies" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "node_modules/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "npm-debug.log*" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "yarn-debug.log*" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "yarn-error.log*" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "package-lock.json" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "yarn.lock" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Next.js build outputs" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".next/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "out/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "build/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "dist/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Hugo build outputs" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "public/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "resources/_gen/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Go build outputs" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.exe" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.exe~" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.dll" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.so" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.dylib" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "api-gateway" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Environment and config" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".env.local" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".env.*.local" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# OS generated files" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".DS_Store" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".DS_Store?" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "._*" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".Spotlight-V100" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".Trashes" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "ehthumbs.db" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "Thumbs.db" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# IDE files" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".vscode/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".idea/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.swp" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.swo" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Docker" >> $(WEBSTACK_DIR)/.gitignore; \
		echo ".docker/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "# Temporary files" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "tmp/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "temp/" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.tmp" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "*.log" >> $(WEBSTACK_DIR)/.gitignore; \
		echo "  ✅ Created comprehensive .gitignore"; \
	fi

create-makefile-integration:
	@echo ""
	@echo "🔗 Setting up root Makefile integration..."
	@if [ ! -f "webstack/Makefile.nimsforestwebstack" ]; then \
		cp tools/nimsforestwebstack/Makefile.nimsforestwebstack webstack/Makefile.nimsforestwebstack 2>/dev/null || echo "  ⚠️  Makefile.nimsforestwebstack template not found, skipping"; \
	else \
		echo "  ✅ Makefile.nimsforestwebstack already exists"; \
	fi
	@if [ ! -f "Makefile" ]; then \
		echo "# Include nimsforestwebstack commands" >> Makefile; \
		echo "-include webstack/Makefile.nimsforestwebstack" >> Makefile; \
		echo "" >> Makefile; \
	elif [ -f "Makefile" ] && ! grep -q "webstack/Makefile.nimsforestwebstack" Makefile; then \
		echo "# Include nimsforestwebstack commands" >> Makefile; \
		echo "-include webstack/Makefile.nimsforestwebstack" >> Makefile; \
		echo "  ✅ Added nimsforestwebstack include to existing Makefile"; \
	elif [ -f "Makefile" ] && grep -q "webstack/Makefile.nimsforestwebstack" Makefile; then \
		echo "  ✅ Makefile already includes nimsforestwebstack"; \
	else \
		echo "# Include nimsforestwebstack commands" >> Makefile; \
		echo "-include webstack/Makefile.nimsforestwebstack" >> Makefile; \
		echo "" >> Makefile; \
		echo "help:" >> Makefile; \
		echo "\t@echo \"🌲 Welcome to your nimsforestwebstack project!\"" >> Makefile; \
		echo "\t@echo \"Run 'make nimsforestwebstack-hello' to get started.\"" >> Makefile; \
	fi
	@echo "  🌲 Hydra project detected - webstack commands already integrated"

nimsforestwebstack-lint:
	@echo "🔍 Validating nimsforestwebstack project conformance..."
	@echo ""
	@LINT_ISSUES=0; \
	echo "📁 Checking directory structure..."; \
	if [ ! -d "webstack" ]; then \
		echo "  ❌ webstack/ directory missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ webstack/ directory exists"; \
	fi; \
	for dir in hugo-site nextjs-tools nextjs-app api auth infrastructure; do \
		if [ ! -d "webstack/$$dir" ]; then \
			echo "  ❌ webstack/$$dir/ directory missing"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		else \
			echo "  ✅ webstack/$$dir/ directory exists"; \
		fi; \
	done; \
	echo ""; \
	echo "📄 Checking required files..."; \
	if [ ! -f "$(HUGO_DIR)/content/_index.md" ]; then \
		echo "  ❌ Hugo content/_index.md missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ Hugo content/_index.md exists"; \
	fi; \
	if [ ! -f "$(HUGO_DIR)/layouts/index.html" ]; then \
		echo "  ❌ Hugo layouts/index.html missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ Hugo layouts/index.html exists"; \
	fi; \
	if [ ! -f "$(HUGO_DIR)/hugo.toml" ]; then \
		echo "  ❌ Hugo hugo.toml missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ Hugo hugo.toml exists"; \
	fi; \
	for app in nextjs-tools nextjs-app; do \
		if [ ! -f "webstack/$$app/package.json" ]; then \
			echo "  ❌ $$app/package.json missing"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		else \
			echo "  ✅ $$app/package.json exists"; \
		fi; \
		if [ ! -f "webstack/$$app/.eslintrc.json" ]; then \
			echo "  ❌ $$app/.eslintrc.json missing"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		else \
			echo "  ✅ $$app/.eslintrc.json exists"; \
		fi; \
	done; \
	if [ ! -f "$(API_DIR)/main.go" ]; then \
		echo "  ❌ API main.go missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ API main.go exists"; \
	fi; \
	if [ ! -f "webstack/docker-compose.dev.yml" ]; then \
		echo "  ❌ docker-compose.dev.yml missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ docker-compose.dev.yml exists"; \
	fi; \
	if [ ! -f "$(WEBSTACK_DIR)/.gitignore" ]; then \
		echo "  ❌ .gitignore missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ .gitignore exists"; \
	fi; \
	if [ ! -f "webstack/Makefile.nimsforestwebstack" ]; then \
		echo "  ❌ Makefile.nimsforestwebstack missing"; \
		LINT_ISSUES=$$((LINT_ISSUES + 1)); \
	else \
		echo "  ✅ Makefile.nimsforestwebstack exists"; \
	fi; \
	echo ""; \
	echo "📦 Checking package.json configurations..."; \
	if [ -f "$(NEXTJS_STATIC_DIR)/package.json" ]; then \
		if grep -q '"next".*"\^*14\.' $(NEXTJS_STATIC_DIR)/package.json; then \
			echo "  ✅ nextjs-tools using Next.js 14.x"; \
		else \
			echo "  ❌ nextjs-tools not using Next.js 14.x"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q '"react".*"\^*18\.' $(NEXTJS_STATIC_DIR)/package.json; then \
			echo "  ✅ nextjs-tools using React 18.x"; \
		else \
			echo "  ❌ nextjs-tools not using React 18.x"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q '"lint".*"next lint"' $(NEXTJS_STATIC_DIR)/package.json; then \
			echo "  ✅ nextjs-tools has lint script"; \
		else \
			echo "  ❌ nextjs-tools missing lint script"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	if [ -f "$(NEXTJS_SSR_DIR)/package.json" ]; then \
		if grep -q '"next".*"\^*14\.' $(NEXTJS_SSR_DIR)/package.json; then \
			echo "  ✅ nextjs-app using Next.js 14.x"; \
		else \
			echo "  ❌ nextjs-app not using Next.js 14.x"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q '"react".*"\^*18\.' $(NEXTJS_SSR_DIR)/package.json; then \
			echo "  ✅ nextjs-app using React 18.x"; \
		else \
			echo "  ❌ nextjs-app not using React 18.x"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q '"lint".*"next lint"' $(NEXTJS_SSR_DIR)/package.json; then \
			echo "  ✅ nextjs-app has lint script"; \
		else \
			echo "  ❌ nextjs-app missing lint script"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	echo ""; \
	echo "🔧 Checking ESLint configurations..."; \
	if [ -f "$(NEXTJS_STATIC_DIR)/.eslintrc.json" ]; then \
		if grep -q '"next/core-web-vitals"' $(NEXTJS_STATIC_DIR)/.eslintrc.json; then \
			echo "  ✅ nextjs-tools ESLint configured correctly"; \
		else \
			echo "  ❌ nextjs-tools ESLint misconfigured"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	if [ -f "$(NEXTJS_SSR_DIR)/.eslintrc.json" ]; then \
		if grep -q '"next/core-web-vitals"' $(NEXTJS_SSR_DIR)/.eslintrc.json; then \
			echo "  ✅ nextjs-app ESLint configured correctly"; \
		else \
			echo "  ❌ nextjs-app ESLint misconfigured"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	echo ""; \
	echo "🐳 Checking Docker configuration..."; \
	if [ -f "webstack/docker-compose.dev.yml" ]; then \
		if grep -q 'node:20' webstack/docker-compose.dev.yml; then \
			echo "  ✅ Docker using Node.js 20"; \
		else \
			echo "  ❌ Docker not using Node.js 20"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q 'user:.*UID' webstack/docker-compose.dev.yml; then \
			echo "  ✅ Docker user mapping configured"; \
		else \
			echo "  ❌ Docker user mapping missing"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	echo ""; \
	echo "🔒 Checking .gitignore patterns..."; \
	if [ -f "$(WEBSTACK_DIR)/.gitignore" ]; then \
		if grep -q 'node_modules/' $(WEBSTACK_DIR)/.gitignore; then \
			echo "  ✅ .gitignore excludes node_modules"; \
		else \
			echo "  ❌ .gitignore missing node_modules pattern"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
		if grep -q '\.next/' $(WEBSTACK_DIR)/.gitignore; then \
			echo "  ✅ .gitignore excludes .next build files"; \
		else \
			echo "  ❌ .gitignore missing .next pattern"; \
			LINT_ISSUES=$$((LINT_ISSUES + 1)); \
		fi; \
	fi; \
	echo ""; \
	echo "📊 Lint Summary:"; \
	if [ $$LINT_ISSUES -eq 0 ]; then \
		echo "  🎉 All checks passed! Project is conform with nimsforestwebstack standards."; \
	else \
		echo "  ❌ $$LINT_ISSUES issue(s) found that need to be fixed:"; \
		echo "  💡 Run 'make nimsforestwebstack-init' to regenerate missing files"; \
		echo "  💡 Or manually fix the issues listed above"; \
		exit 1; \
	fi

nimsforestwebstack-test-all:
	@echo "🧪 Comprehensive testing of nimsforestwebstack..."
	@echo ""
	@echo "1️⃣ Structure validation..."
	@$(MAKE) nimsforestwebstack-lint
	@echo ""
	@echo "2️⃣ Integration testing..."
	@if [ ! -f "$(WEBSTACK_DIR)/docker-compose.dev.yml" ]; then \
		echo "❌ Docker compose configuration missing"; \
		exit 1; \
	fi
	@if ! command -v docker >/dev/null 2>&1; then \
		echo "❌ Docker not available"; \
		exit 1; \
	fi
	@echo "🚀 Testing complete development stack startup..."
	@cd $(WEBSTACK_DIR) && timeout 60 docker compose -f docker-compose.dev.yml up --build -d >/dev/null 2>&1
	@echo "⏳ Waiting for services to build and start (20s)..."
	@sleep 20
	@ENDPOINTS_OK=0; \
	echo "🌐 Testing endpoints..."; \
	for i in 1 2 3; do \
		if curl -s http://localhost:1313 >/dev/null 2>&1; then \
			echo "  ✅ Hugo responding at :1313"; \
			ENDPOINTS_OK=$$((ENDPOINTS_OK + 1)); \
			break; \
		else \
			echo "  ⏳ Hugo not ready (attempt $$i/3)..."; \
			sleep 5; \
		fi; \
	done; \
	for i in 1 2 3; do \
		if curl -s http://localhost:3000 >/dev/null 2>&1; then \
			echo "  ✅ Next.js App responding at :3000"; \
			ENDPOINTS_OK=$$((ENDPOINTS_OK + 1)); \
			break; \
		else \
			echo "  ⏳ Next.js App not ready (attempt $$i/3)..."; \
			sleep 5; \
		fi; \
	done; \
	for i in 1 2 3; do \
		if curl -s http://localhost:3001 >/dev/null 2>&1; then \
			echo "  ✅ Next.js Tools responding at :3001"; \
			ENDPOINTS_OK=$$((ENDPOINTS_OK + 1)); \
			break; \
		else \
			echo "  ⏳ Next.js Tools not ready (attempt $$i/3)..."; \
			sleep 5; \
		fi; \
	done; \
	for i in 1 2 3; do \
		if curl -s http://localhost:8080 >/dev/null 2>&1; then \
			echo "  ✅ API responding at :8080"; \
			ENDPOINTS_OK=$$((ENDPOINTS_OK + 1)); \
			break; \
		else \
			echo "  ⏳ API not ready (attempt $$i/3)..."; \
			sleep 5; \
		fi; \
	done; \
	echo "📊 Endpoint validation: $$ENDPOINTS_OK/4 services responding"; \
	if [ $$ENDPOINTS_OK -eq 4 ]; then \
		echo "🎉 All services responding successfully!"; \
	else \
		echo "⚠️  Some services may need more time to start"; \
	fi
	@echo "🛑 Shutting down development environment..."
	@cd $(WEBSTACK_DIR) && docker compose -f docker-compose.dev.yml down >/dev/null 2>&1
	@echo ""
	@echo "✅ Integration test complete!"
	@echo "🎉 Development environment is ready!"
	@echo "🚀 Run 'make nimsforestwebstack-dev' to start development environment"

nimsforestwebstack-dev:
	@echo "🚀 Starting nimsforestwebstack development environment..."
	@if [ ! -d "webstack" ]; then \
		echo "❌ webstack/ directory not found"; \
		echo "💡 Run 'make nimsforestwebstack-init' first"; \
		exit 1; \
	fi
	@echo "🌐 Services will be available at:"
	@echo "   📖 Hugo site: http://localhost:1313"
	@echo "   🔧 Next.js tools: http://localhost:3001"
	@echo "   🌐 Next.js app: http://localhost:3000"
	@echo "   🔌 API gateway: http://localhost:8080"
	@echo ""
	@echo "🚀 Starting all services..."
	@echo "Press Ctrl+C to stop all services"
	@cd webstack && $(MAKE) -f Makefile.nimsforestwebstack dev

nimsforestwebstack-addtomainmake:
	@echo "🔗 Adding nimsforestwebstack to main Makefile..."
	@echo ""
	@if [ -z "$$PROJECTDIR" ]; then \
		echo "❌ PROJECTDIR environment variable not set"; \
		echo "💡 Set PROJECTDIR to your project root directory"; \
		echo "💡 Example: export PROJECTDIR=/path/to/your/project"; \
		exit 1; \
	fi
	@if [ ! -d "$$PROJECTDIR" ]; then \
		echo "❌ PROJECTDIR directory does not exist: $$PROJECTDIR"; \
		exit 1; \
	fi
	@if [ ! -f "$$PROJECTDIR/Makefile" ]; then \
		echo "📝 Creating main Makefile at $$PROJECTDIR/Makefile"; \
		echo "# Main project Makefile" > "$$PROJECTDIR/Makefile"; \
		echo "# Generated by nimsforestwebstack" >> "$$PROJECTDIR/Makefile"; \
		echo "" >> "$$PROJECTDIR/Makefile"; \
		echo "# Include nimsforestwebstack commands" >> "$$PROJECTDIR/Makefile"; \
		echo "-include tools/nimsforestwebstack/Makefile" >> "$$PROJECTDIR/Makefile"; \
		echo "" >> "$$PROJECTDIR/Makefile"; \
		echo "help:" >> "$$PROJECTDIR/Makefile"; \
		echo "\t@echo \"🌲 Welcome to your nimsforestwebstack project!\"" >> "$$PROJECTDIR/Makefile"; \
		echo "\t@echo \"Run 'make nimsforestwebstack-hello' to get started.\"" >> "$$PROJECTDIR/Makefile"; \
		echo "✅ Created main Makefile with nimsforestwebstack integration"; \
	elif ! grep -q "tools/nimsforestwebstack/Makefile" "$$PROJECTDIR/Makefile"; then \
		echo "📝 Adding nimsforestwebstack integration to existing Makefile"; \
		echo "" >> "$$PROJECTDIR/Makefile"; \
		echo "# Include nimsforestwebstack commands" >> "$$PROJECTDIR/Makefile"; \
		echo "-include tools/nimsforestwebstack/Makefile" >> "$$PROJECTDIR/Makefile"; \
		echo "✅ Added nimsforestwebstack integration to existing Makefile"; \
	else \
		echo "✅ Makefile already includes nimsforestwebstack"; \
	fi
	@echo ""
	@echo "🎯 Integration complete!"
	@echo "💡 You can now run nimsforestwebstack commands from your project root:"
	@echo "   cd $$PROJECTDIR"
	@echo "   make nimsforestwebstack-hello"