# System prompt / CLAUDE.md 精简原则

- 日期：2026-07-26
- 来源：Anthropic 的 Thariq（@trq212）推文及评论区讨论，https://x.com/trq212/status/2080710971228918066
- 结论：模型越强，需要的指令越少。CLAUDE.md 和 system prompt 只写模型自己推不出来的约定（语言偏好、仓库定位、工作流规则），不写防御性指令；新增一条指令前先问"当前模型是否本来就会这么做"。

## 背景事实

- Anthropic 为 frontier 模型（Opus 4.8 / Fable 5）削减了 Claude Code system prompt：宣传口径 80%（memory 关闭时 2,686 → 514 词），算上按需加载的 memory 规则实际约 70%（2,686 → 830 词）。
- 分层策略：较弱模型（Sonnet 5 / Haiku 4.5）仍用完整的 2,094 词 prompt，保留 "don't add abstractions"、"don't write comments" 等全部规则。精简只对 frontier 模型生效。
- Memory 规则改为按需加载（开启 memory 才注入），而非常驻 context——"动态加载"本身也是一种精简手段。

## 启示与取舍

- Prompt 膨胀多为"疤痕组织"（scar tissue）：过去每次失败加一段，模型升级后从未清理。"Prompt debt is the new tech debt."
- 如果 CLAUDE.md 一直在变长，说明是在为一个比实际所用更弱的模型写指令。
- Claude Code 的 `/doctor` 命令可辅助清理 CLAUDE.md 冗余。
- 开放问题（推文未答）：结论能否泛化到其他 frontier 模型（如 GPT-5.6）；Anthropic 的削减是凭直觉还是有 replay evals 验证。

## 对本仓库的应用

- 本仓库 CLAUDE.md（2026-07-26 审视）已符合该原则：内容全部是不可推导的约定（中文回复、术语保英文、scratch 一次性 demo、memory 沉淀规则、不主动 commit），无需精简。
- 后续维护基线：定期用该原则审视 CLAUDE.md，宁可删不加；工具类信息（如本机装了什么 CLI）不进 CLAUDE.md，现场 `which` 即可发现。
