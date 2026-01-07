# GitHub + Railway Deployment Guide

Complete step-by-step guide to deploy Box Control Dashboard to Railway using GitHub.

## Prerequisites

- ✅ GitHub account
- ✅ Railway account (sign up at [railway.app](https://railway.app))
- ✅ Your code is ready to deploy

## Step 1: Push Code to GitHub

### If you haven't initialized Git yet:

```bash
# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Box Control Dashboard"

# Add your GitHub repository as remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### If you already have a GitHub repo:

```bash
# Make sure all changes are committed
git add .
git commit -m "Ready for Railway deployment"

# Push to GitHub
git push origin main
```

## Step 2: Create Railway Project

1. **Go to Railway**: Visit [railway.app](https://railway.app) and sign in

2. **Create New Project**:
   - Click **"New Project"** button
   - Select **"Deploy from GitHub repo"**
   - Authorize Railway to access your GitHub account (if first time)
   - Select your repository: `YOUR_USERNAME/YOUR_REPO_NAME`

3. **Configure Root Directory** (if needed):
   - If your code is in a subdirectory, go to **Settings** → **Root Directory**
   - Set it to: `box-control-dashboard` (if applicable)
   - If your code is at the root, leave this empty

## Step 3: Add PostgreSQL Database

1. In your Railway project, click **"New"** button
2. Select **"Database"** → **"Add PostgreSQL"**
3. Railway will automatically create a PostgreSQL database
4. The `DATABASE_URL` will be automatically available

## Step 4: Configure Environment Variables

1. In your Railway project, click on your **service** (the one with your app name)

2. Go to the **"Variables"** tab

3. **Reference the Database**:
   - Click **"New Variable"** → **"Reference Variable"**
   - Select your **PostgreSQL** service
   - Select **`DATABASE_URL`** from the dropdown
   - Click **"Add"**

4. **Add Required Variables**:

   Click **"New Variable"** for each:

   | Variable Name | Value | How to Get |
   |--------------|-------|------------|
   | `APP_PASSCODE` | `your-secure-passcode-here` | Choose a strong passcode |
   | `SESSION_SECRET` | Random string | Generate with: `openssl rand -hex 32` |
   | `NODE_ENV` | `production` | Set to production |

   **To generate SESSION_SECRET:**
   ```bash
   # On Mac/Linux:
   openssl rand -hex 32
   
   # On Windows (PowerShell):
   -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 64 | % {[char]$_})
   # Or use an online generator: https://randomkeygen.com/
   ```

5. **Do NOT set `PORT`** - Railway sets this automatically

## Step 5: Deploy

Railway will automatically:
- ✅ Detect your Node.js project
- ✅ Run `npm install`
- ✅ Run `npm start` (from your package.json)
- ✅ Initialize the database schema on first run

**Monitor the deployment:**
1. Go to the **"Deployments"** tab to see build progress
2. Go to the **"Logs"** tab to see real-time logs
3. Look for:
   - ✅ `Database initialized`
   - ✅ `Box Control Dashboard running on port XXXX`

## Step 6: Get Your Public URL

1. Go to your service **"Settings"** tab
2. Scroll to **"Domains"** section
3. Railway provides a default domain like: `box-control-dashboard-production.up.railway.app`
4. Click the domain to copy it
5. (Optional) Add a custom domain if you have one

## Step 7: Test Your Deployment

1. Visit your Railway URL
2. You should see the **login page**
3. Enter your `APP_PASSCODE`
4. You should see the **Dashboard**

## Step 8: Enable Auto-Deploy (Already Enabled by Default)

Railway automatically deploys when you push to your connected branch:
- ✅ Push to `main` branch → Auto-deploys
- ✅ Push to `master` branch → Auto-deploys

To change the branch:
1. Go to **Settings** → **Source**
2. Select your branch
3. Railway will redeploy

## Continuous Deployment Workflow

Once set up, your workflow is simple:

```bash
# Make changes to your code
# ... edit files ...

# Commit changes
git add .
git commit -m "Your commit message"

# Push to GitHub
git push origin main

# Railway automatically detects the push and redeploys!
# Check Railway dashboard to see deployment progress
```

## Environment Variables Summary

| Variable | Source | Required | Notes |
|----------|--------|----------|-------|
| `DATABASE_URL` | Reference from PostgreSQL | ✅ Yes | Auto-set when you reference the database |
| `APP_PASSCODE` | Manual entry | ✅ Yes | Your secure passcode |
| `SESSION_SECRET` | Manual entry | ✅ Yes | Random secret string |
| `NODE_ENV` | Manual entry | Recommended | Set to `production` |
| `PORT` | Auto-set by Railway | No | Don't override |

## Troubleshooting

### Build Fails

**Error: "No such file or directory"**
- ✅ Check Root Directory setting (should be empty or `box-control-dashboard`)
- ✅ Verify all files are committed and pushed to GitHub
- ✅ Check that `package.json` is in the root directory

**Error: "npm install failed"**
- ✅ Check Railway logs for specific error
- ✅ Verify `package.json` has correct dependencies
- ✅ Check Node.js version (should be >= 20.0.0)

### App Won't Start

**Error: "Database connection failed"**
- ✅ Verify `DATABASE_URL` is correctly referenced
- ✅ Check PostgreSQL service is running (green status)
- ✅ Check logs for connection errors

**Error: "Port already in use"**
- ✅ Don't set `PORT` variable - Railway handles this
- ✅ Remove `PORT` from environment variables if you added it

### Authentication Not Working

- ✅ Verify `APP_PASSCODE` is set in Variables
- ✅ Verify `SESSION_SECRET` is set
- ✅ Clear browser cookies and try again
- ✅ Check logs for session errors

### Can't Access the App

- ✅ Check service status (should be green)
- ✅ Verify deployment completed successfully
- ✅ Check the **Domains** section for your URL
- ✅ Check logs for any startup errors

### Database Tables Not Created

- ✅ Check logs for "Database initialized" message
- ✅ Verify `DATABASE_URL` has proper permissions
- ✅ The schema initializes automatically on first server start
- ✅ Check logs for any database errors

## Quick Checklist

Before deploying:
- [ ] Code is pushed to GitHub
- [ ] Railway project created
- [ ] PostgreSQL database added
- [ ] `DATABASE_URL` referenced from PostgreSQL
- [ ] `APP_PASSCODE` set
- [ ] `SESSION_SECRET` set (random string)
- [ ] `NODE_ENV` set to `production`
- [ ] Root Directory configured (if needed)

After deployment:
- [ ] Build completed successfully
- [ ] Service shows green status
- [ ] Can access login page at Railway URL
- [ ] Can log in with passcode
- [ ] Dashboard loads correctly
- [ ] Database tables created (check logs)

## Next Steps

Once deployed:
1. ✅ Test all features (dashboard, sales, production)
2. ✅ Set up a custom domain (optional)
3. ✅ Configure monitoring/alerts (optional)
4. ✅ Set up backups for database (Railway handles this)

## Support

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- Check logs in Railway dashboard for detailed error messages

---

**You're all set!** Your Box Control Dashboard is now live on Railway with automatic deployments from GitHub. 🚀

