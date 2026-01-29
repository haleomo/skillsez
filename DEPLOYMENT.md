Setting Index.html to have the correct environment.

Using sed (Linux/Mac):

# In your CI/CD deployment script
    sed -i "s/window.ENVIRONMENT = 'dev'/window.ENVIRONMENT = 'prod'/" lib/index.html

Absolutely! I can help you set up GitHub Actions for CI/CD. For your Skills Ez application, we could create workflows to:

Automated Deployment - Deploy to your server when you push to main/production branches
Environment Switching - Automatically set window.ENVIRONMENT to 'prod' during deployment
API Server Deployment - Deploy the Dart Frog API server
Database Migrations - Run any SQL migrations if needed
Build & Test - Run tests for the API and shared packages
Multiple Environments - Different workflows for staging and production
We could set up workflows for:

Web App: Copy files to your server via SSH/SCP or deploy to a hosting service
API: Deploy the Dart Frog server to your production environment
Database: Run migrations automatically
Would you like me to create a GitHub Actions workflow? If so, let me know:

How you want to deploy (SSH/SCP to your server, Docker, cloud hosting, etc.)?
Do you need separate staging and production environments?
Should it deploy on every push to main, or only on tagged releases?
I can create the .github/workflows/ configuration files whenever you're ready!
