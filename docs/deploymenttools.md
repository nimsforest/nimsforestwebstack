# Universal Next.js/React Deployment Tooling

A reusable deployment solution for Next.js and React projects with GitHub Actions and Netlify integration.

## 🚀 Features

- **Universal Compatibility**: Works with any Next.js or React project
- **GitHub Actions Integration**: Automated CI/CD workflows
- **Netlify Deployment**: Production and preview deployments
- **Secrets Management**: Secure handling of deployment credentials
- **Comprehensive Validation**: Built-in setup verification
- **Cross-Platform Support**: Works on Linux, macOS, and Windows

## 📦 What's Included

- `Makefile.deployment` - Universal deployment commands
- GitHub Actions workflow template
- Netlify configuration template
- Comprehensive documentation
- Setup validation tools

## 🎯 Quick Start

### 1. Copy the deployment tooling to your project

```bash
# Copy the deployment Makefile
curl -o Makefile.deployment https://raw.githubusercontent.com/nimsforest/nimsforestwebstack/main/Makefile.deployment

# Or download manually and place in your project root
```

### 2. Run the complete setup

```bash
# Run the full deployment setup
make -f Makefile.deployment setup-githubactions-netlifydeployment

# Or run individual setup steps
make -f Makefile.deployment setup-githubcli
make -f Makefile.deployment setup-netlify
```

### 3. Configure your project

```bash
# Authenticate with services
netlify login
gh auth login

# Link your project to Netlify
netlify link

# Set up GitHub secrets
make -f Makefile.deployment setup-github-secrets

# GitHub workflow is created automatically during setup
```

### 4. Deploy your project

```bash
# Deploy to production
make -f Makefile.deployment deploy-website

# Create preview deployment
make -f Makefile.deployment deploy-preview
```

## 🌲 nimsforestwebstack Integration

This deployment tooling is **built into nimsforestwebstack** and works seamlessly with the web stack framework.

### Using with nimsforestwebstack

If you're using nimsforestwebstack, deployment is already configured:

```bash
# Initialize your web stack project
make nimsforestwebstack-init

# The deployment tooling is automatically included
make deployment-help                    # Show deployment commands
make validate-deployment-setup          # Check deployment readiness
make setup-githubactions-netlifydeployment  # Set up automated deployment
```

### Commands Available in nimsforestwebstack

When using nimsforestwebstack, you get these additional integrated commands:

```bash
make nimsforestwebstack-help            # Shows deployment commands section
make deploy-website                     # Deploy your web stack to production
make deploy-preview                     # Create preview deployment
```

The deployment system understands your web stack structure and will deploy:
- **Hugo site** (content management)
- **Next.js tools** (interactive tools)
- **Next.js app** (dynamic application)
- **Static assets** and **API documentation**

## 🔧 Integration Options

### Option 1: Include in existing Makefile

Add this line to your existing Makefile:

```makefile
include Makefile.deployment
```

Then use the commands directly:

```bash
make setup-githubactions-netlifydeployment
make deploy-website
```

### Option 2: Use as standalone file

```bash
make -f Makefile.deployment deployment-help
make -f Makefile.deployment deploy-website
```

### Option 3: Custom configuration

Set variables in your main Makefile:

```makefile
# Custom configuration
WEBSITE_DIR = ./frontend
BUILD_COMMAND = npm run build:production
INSTALL_COMMAND = npm install --production
TEST_COMMAND = npm run test && npm run lint

include Makefile.deployment
```

## 📋 Available Commands

### Setup Commands

| Command | Description |
|---------|-------------|
| `setup-githubcli` | Install and authenticate GitHub CLI |
| `setup-githubcli-ssh` | Authenticate GitHub CLI with SSH |
| `setup-netlify` | Install and setup Netlify CLI |
| `setup-github-secrets` | Configure GitHub repository secrets |
| `setup-githubactions-netlifydeployment` | Complete deployment setup |

### Deployment Commands

| Command | Description |
|---------|-------------|
| `deploy-website` | Deploy to Netlify production |
| `deploy-preview` | Create Netlify preview deployment |
| `test-build` | Test build locally before deployment |

### Validation Commands

| Command | Description |
|---------|-------------|
| `validate-deployment-setup` | Validate complete deployment setup |
| `check-github-secrets` | Check GitHub repository secrets |
| `deploy-status` | Check deployment status |

### Helper Commands

| Command | Description |
|---------|-------------|
| `deployment-help` | Show deployment help |

## ⚙️ Configuration

### Environment Variables

You can customize the deployment behavior with these variables:

```bash
# Project configuration
export WEBSITE_DIR="./src"              # Directory containing your app
export BUILD_COMMAND="npm run build"    # Build command
export INSTALL_COMMAND="npm ci"         # Install command
export TEST_COMMAND="npm run test"      # Test command

# Netlify configuration
export NETLIFY_SITE_ID="your-site-id"   # Netlify site ID
export NETLIFY_AUTH_TOKEN="your-token"  # Netlify auth token
```

### netlify.toml Configuration

The tooling expects a `netlify.toml` file in your project root:

```toml
[build]
  base = "."
  command = "npm ci && npm run build"
  publish = ".next"

[build.environment]
  NODE_VERSION = "20"
  NEXT_TELEMETRY_DISABLED = "1"

[[plugins]]
  package = "@netlify/plugin-nextjs"

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "origin-when-cross-origin"
```

## 🔐 Security

### GitHub Secrets

The tooling automatically configures these GitHub secrets:

- `NETLIFY_AUTH_TOKEN` - Your Netlify personal access token
- `NETLIFY_SITE_ID` - Your Netlify site ID

### Best Practices

1. **Never commit secrets** - The tooling handles secrets securely
2. **Use environment variables** - For sensitive configuration
3. **Validate setup** - Always run `validate-deployment-setup`
4. **Test locally** - Use `test-build` before deploying

## 🚦 GitHub Actions Workflow

The tooling creates a GitHub Actions workflow that:

- Triggers on pushes to main branch
- Triggers on pull requests for preview deployments
- Runs tests and builds the project
- Deploys to Netlify automatically
- Comments on PRs with preview URLs

### Workflow Structure

```yaml
name: Deploy to Netlify

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '20'
        cache: 'npm'
    - name: Install dependencies
      run: npm ci
    - name: Build project
      run: npm run build
    - name: Deploy to Netlify
      uses: nwtgck/actions-netlify@v3.0
      with:
        publish-dir: './.next'
        production-branch: main
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
```

## 🔍 Troubleshooting

### Common Issues

**GitHub CLI not authenticated**
```bash
gh auth login
```

**Netlify not linked**
```bash
netlify login
netlify link
```

**Missing GitHub secrets**
```bash
make -f Makefile.deployment setup-github-secrets
```

**Build failing**
```bash
# Test locally first
make -f Makefile.deployment test-build

# Check configuration
make -f Makefile.deployment validate-deployment-setup
```

### Validation

Always run validation after setup:

```bash
make -f Makefile.deployment validate-deployment-setup
```

This will check:
- ✅ Node.js and npm installation
- ✅ Project structure and configuration
- ✅ GitHub CLI authentication
- ✅ Netlify CLI and project linking
- ✅ GitHub repository secrets
- ✅ GitHub Actions workflow

## 📊 Project Structure

```
your-project/
├── Makefile.deployment     # Universal deployment commands
├── netlify.toml            # Netlify configuration
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions workflow
├── package.json            # Your project dependencies
└── src/                    # Your project source code
```

## 🔄 Workflow Examples

### Initial Setup
```bash
# 1. Copy deployment tooling
curl -o Makefile.deployment https://raw.githubusercontent.com/nimsforest/nimsforestwebstack/main/Makefile.deployment

# 2. Run setup
make -f Makefile.deployment setup-githubactions-netlifydeployment

# 3. Authenticate with services
netlify login
gh auth login

# 4. Link to Netlify
netlify link

# 5. Configure secrets
make -f Makefile.deployment setup-github-secrets

# 6. Validate setup
make -f Makefile.deployment validate-deployment-setup
```

### Daily Development
```bash
# Test build locally
make -f Makefile.deployment test-build

# Deploy to preview
make -f Makefile.deployment deploy-preview

# Deploy to production
make -f Makefile.deployment deploy-website
```

### CI/CD Automation
```bash
# Check deployment status
make -f Makefile.deployment deploy-status

# Verify secrets
make -f Makefile.deployment check-github-secrets
```

## 🤝 Contributing

This deployment tooling is designed to be universal and reusable. To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with different project types
5. Submit a pull request

## 📄 License

This deployment tooling is provided under the MIT License. See LICENSE file for details.

## 🆘 Support

For issues and questions:

1. Check the troubleshooting section
2. Run `make -f Makefile.deployment validate-deployment-setup`
3. Open an issue in the repository
4. Provide the output of the validation command

## 🎯 Supported Project Types

- ✅ Next.js applications
- ✅ React applications (Create React App)
- ✅ React applications (Vite)
- ✅ Static sites with Node.js build process
- ✅ Any project with npm/yarn package.json

## 📈 Roadmap

- [ ] Support for more deployment targets (Vercel, AWS, etc.)
- [ ] Docker-based deployments
- [ ] Multi-environment support
- [ ] Automated testing integration
- [ ] Performance monitoring integration
- [ ] Rollback capabilities