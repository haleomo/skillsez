Setting Index.html to have the correct environment.

Using sed (Linux/Mac):

# In your CI/CD deployment scriptsed -i "s/window.ENVIRONMENT = 'dev'/window.ENVIRONMENT = 'prod'/" lib/index.html
Using PowerShell (Windows):

(Get-Content lib/index.html) -replace "window.ENVIRONMENT = 'dev'", "window.ENVIRONMENT = 'prod'" | Set-Content lib/index.html
Or using environment variables in your CI/CD:

# Set environment based on branch/environmentif [ "$CI_ENVIRONMENT" = "production" ]; then  sed -i "s/window.ENVIRONMENT = 'dev'/window.ENVIRONMENT = 'prod'/" lib/index.htmlfi
This way, your local development will always use 'dev' (localhost), and your CI/CD can automatically switch it to 'prod' when deploying to your server!