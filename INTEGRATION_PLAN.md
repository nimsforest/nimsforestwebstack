# 🌲 nimsforestwebstack Integration Plan

## Current Status: ✅ Phase 1 Complete

The web stack generator has been successfully isolated into `/tools/nimsforestwebstack/` within the Hydra project.

## Directory Structure

```
hydra/
├── tools/
│   └── nimsforestwebstack/           # 🌲 Web stack generator
│       ├── cmd/nimsforestwebstack/   # CLI tool
│       ├── templates/                # Project templates
│       ├── Makefile.webstack         # Universal commands
│       └── README.md
├── Makefile                          # Hydra main (integrates webstack)
├── Makefile.deployment               # Universal deployment
└── ui/website/                       # Current Hydra website
```

## Integration Commands Available

```bash
# In Hydra project root:
make install-webstack    # Install the CLI
make generate-project    # Create new project
make webstack-help       # Show help

# Direct CLI usage:
nimsforestwebstack --interactive
nimsforestwebstack webapp myproject --domain=myproject.com
```

## Phase 2: Template Creation

### Next Steps:

1. **Create Hugo + Docsy template**
   - Include `/docs` folder support by default
   - Hugo Modules configuration
   - Docsy theme setup

2. **Create Next.js templates**
   - Static tools template (calculators)
   - SSR app template (authentication)

3. **Create Go API Gateway template**
   - Zitadel integration
   - Standard endpoints
   - Middleware setup

4. **Create Infrastructure templates**
   - Nginx configuration
   - Docker compose files
   - GitHub Actions workflows

## Phase 3: Extract from Hydra

### Migration Plan:

1. **Move to separate repository**
   ```bash
   # Create new repo
   mkdir ../nimsforestwebstack
   cp -r tools/nimsforestwebstack/* ../nimsforestwebstack/
   
   # Update Hydra to use external version
   # Remove tools/nimsforestwebstack
   # Update Makefile to install from GitHub
   ```

2. **Package for distribution**
   - GitHub releases with binaries
   - Documentation website
   - Example projects

## Phase 4: Hydra Migration

### Migrate current Hydra to use generated structure:

1. **Generate new Hydra structure**
   ```bash
   nimsforestwebstack webapp hydra-hardware --domain=hydrahardware.io
   ```

2. **Migrate existing content**
   - Copy ui/website content to new structure
   - Update configuration
   - Test deployment

3. **Switch to new structure**
   - Backup current
   - Replace with generated
   - Update CI/CD

## Benefits

1. **Reusable**: Other projects can use the same stack
2. **Maintainable**: All projects benefit from improvements
3. **Opinionated**: Best practices baked in
4. **Complete**: Hugo + Next.js + API + Auth + Deploy

## Usage Examples

```bash
# Create a SaaS platform
nimsforestwebstack saas myplatform --domain=myplatform.com

# Create documentation site
nimsforestwebstack docs companydocs --domain=docs.company.com

# Create API-only service
nimsforestwebstack api myapi --domain=api.company.com
```

## Integration with docs/ folder

The Hugo template will automatically:
- Set up Docsy theme
- Configure Hugo Modules
- Map `/docs` folder to navigation
- Include search functionality
- Add edit-on-GitHub links

This makes any project with a `/docs` folder immediately have a beautiful documentation site!