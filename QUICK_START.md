# Quick Start: Deploy to Railway via GitHub

## 🚀 Fast Track (5 minutes)

### 1. Commit & Push to GitHub

```bash
# Add all files
git add .

# Commit
git commit -m "Ready for Railway deployment"

# Push to GitHub
git push origin main
```

### 2. Deploy on Railway

1. **Go to Railway**: https://railway.app
2. **New Project** → **Deploy from GitHub repo**
3. **Select your repo**: `Newjack1108/Stable-Box-Control`
4. **Add PostgreSQL**: Click "New" → "Database" → "Add PostgreSQL"
5. **Set Environment Variables**:
   - Click your service → "Variables" tab
   - Reference `DATABASE_URL` from PostgreSQL service
   - Add `APP_PASSCODE` = your secure passcode
   - Add `SESSION_SECRET` = generate with: `openssl rand -hex 32`
   - Add `NODE_ENV` = `production`
6. **Wait for deployment** (check Deployments tab)
7. **Get your URL** from Settings → Domains

### 3. Test

Visit your Railway URL and log in with your `APP_PASSCODE`.

---

## 📋 Detailed Guide

See `GITHUB_RAILWAY_DEPLOY.md` for complete step-by-step instructions.

---

## ✅ Pre-Deployment Checklist

- [x] `.gitignore` created
- [x] `railway.json` configured
- [x] `package.json` has start script
- [x] GitHub remote configured
- [ ] All files committed and pushed
- [ ] Railway project created
- [ ] Environment variables set

---

**Ready to deploy?** Run the git commands above, then follow the Railway steps!

