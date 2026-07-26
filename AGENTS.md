# AGENTS.md

本文件为所有 AI coding agent（Claude Code、Codex、OpenCode 等）提供本仓库的工作指引。

## 沟通约定

- 用中文回复用户。
- 专业术语保持英文原文（如 embedding、chunking、vector store、hybrid search），不强行翻译。

## 仓库定位

这不是一个产品代码库，而是用户与 AI agent 的协作对话工作区。话题不限：讨论技术方案、写 demo 验证想法、评估选型等。

三条核心规则：

1. **Demo 是一次性的**：演示代码写到 `scratch/`（已 gitignore），给用户看完即弃，不提交、不长期维护。
2. **有价值的结论要沉淀为 memory**：讨论得出的可靠结论（选型决定、方案设计、踩坑经验）写入本仓库的 memory 系统，参考 OpenClaw 的 markdown 记忆管理方式。
3. **外部素材放 `data/`**（已 gitignore）：下载的文章、视频、音频、CSV 等原始素材统一放这里，供讨论和 demo 使用；不提交到 git。

## Memory 系统

- `MEMORY.md`：记忆索引，每条一行，格式 `- [标题](memory/文件名.md) — 一句话结论`。**会话开始处理正事前先读它**，了解已有共识。
- `memory/`：一条记忆一个文件，命名 `YYYY-MM-DD-<主题>.md`，内容包含结论、背景与取舍理由。
- 写入时机：用户明确说"记下来 / 做个 memory"，或一次讨论得出明确结论时主动提议写入。
- 更新优先于新增：同一话题已有记忆文件时更新原文件而不是另开新文件；结论被推翻时修改或删除旧记忆，并同步维护 `MEMORY.md` 索引。

## 常规操作

- 不主动 commit / push，除非用户要求。
- 仓库内没有构建/测试体系，也不需要——demo 各自独立运行即可。

## Agent skills

### Issue tracker

Issues 在本仓库的 GitHub Issues（`gh` CLI 读写）。见 `docs/agents/issue-tracker.md`。

### Triage labels

五个 canonical triage 角色用默认 label 名。见 `docs/agents/triage-labels.md`。

### Domain docs

Single-context 布局：根目录 `CONTEXT.md` + `docs/adr/`（按需懒创建）。见 `docs/agents/domain.md`。
