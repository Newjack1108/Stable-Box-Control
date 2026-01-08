-- Business Logic Calculation System Migration
-- Adds annual turnover, base box price, and gross margin percentage fields
-- Enables automatic calculation of contribution targets and box targets

-- Add new columns to box_control_settings table
ALTER TABLE box_control_settings 
ADD COLUMN IF NOT EXISTS annual_turnover NUMERIC DEFAULT NULL,
ADD COLUMN IF NOT EXISTS base_box_price NUMERIC DEFAULT NULL,
ADD COLUMN IF NOT EXISTS gross_margin_pct NUMERIC NOT NULL DEFAULT 0.35;

-- Migrate existing data: Calculate base_box_price from contribution_per_box if possible
-- If contribution_per_box exists and gross_margin_pct is 0.35, reverse calculate base_box_price
-- Formula: contribution_per_box = (base_box_price × (1 + install_pct + extras_pct)) × gross_margin_pct
-- So: base_box_price = contribution_per_box / (gross_margin_pct × (1 + install_pct + extras_pct))
UPDATE box_control_settings
SET base_box_price = CASE 
    WHEN contribution_per_box > 0 AND gross_margin_pct > 0 AND (target_install_pct + target_extras_pct) >= 0 THEN
        contribution_per_box / (gross_margin_pct * (1 + target_install_pct + target_extras_pct))
    ELSE NULL
END
WHERE base_box_price IS NULL;

-- Calculate annual_turnover from monthly_contribution_target if it exists
-- Formula: annual_turnover = (monthly_contribution_target × 12) / gross_margin_pct
UPDATE box_control_settings
SET annual_turnover = CASE
    WHEN monthly_contribution_target > 0 AND gross_margin_pct > 0 THEN
        (monthly_contribution_target * 12) / gross_margin_pct
    ELSE NULL
END
WHERE annual_turnover IS NULL;

-- Ensure gross_margin_pct is set to 0.35 if it's still NULL (shouldn't happen with DEFAULT, but just in case)
UPDATE box_control_settings
SET gross_margin_pct = 0.35
WHERE gross_margin_pct IS NULL;
