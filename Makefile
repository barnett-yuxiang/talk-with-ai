.PHONY: skills-check skills-update

# 检查 skills 是否有上游更新
skills-check:
	npx skills@latest check

# 更新 skills 到最新版本（同步更新 skills-lock.json）
skills-update:
	npx skills@latest update
