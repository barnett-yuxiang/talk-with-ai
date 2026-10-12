.PHONY: skills-check skills-update

# 调用官方项目级 check（已核验的 1.7.1/1.7.2 中等同 update）
skills-check:
	@echo "注意：上游 check 在 1.7.1/1.7.2 中也会更新文件，并非只读检查。"
	npx skills@latest check --project

# 更新当前项目的 skills（同步更新 skills-lock.json）
skills-update:
	npx skills@latest update --project
