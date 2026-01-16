# Deploy Minimal Mistakes Theme to GitHub Pages
# Run this script to push your changes

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deploying Minimal Mistakes Theme" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in a git repository
if (-not (Test-Path .git)) {
    Write-Host "Error: Not a git repository!" -ForegroundColor Red
    Write-Host "Please run this script from your repository root." -ForegroundColor Yellow
    exit 1
}

Write-Host "Step 1: Checking repository status..." -ForegroundColor Yellow
git status --short

Write-Host ""
Write-Host "Step 2: Staging all changes..." -ForegroundColor Yellow
git add .

Write-Host ""
Write-Host "Step 3: Committing changes..." -ForegroundColor Yellow
$commitMessage = "Migrate to Minimal Mistakes theme - Professional portfolio upgrade"
git commit -m $commitMessage

Write-Host ""
Write-Host "Step 4: Pushing to GitHub..." -ForegroundColor Yellow
git push origin master

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Deployment Complete! ✅" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your site is being built by GitHub Pages..." -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 Check build status:" -ForegroundColor White
Write-Host "   https://github.com/hoaln/hoaln.github.io/actions" -ForegroundColor Blue
Write-Host ""
Write-Host "🌐 View your site (in ~2-5 minutes):" -ForegroundColor White
Write-Host "   https://hoaln.github.io" -ForegroundColor Blue
Write-Host ""
Write-Host "📖 Read MIGRATION-GUIDE.md for customization tips!" -ForegroundColor Yellow
