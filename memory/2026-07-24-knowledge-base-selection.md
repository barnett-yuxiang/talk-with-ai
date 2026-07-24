# 个人知识库选型

- 日期：2026-07-24
- 结论：数据源为自维护 markdown 文件；本地默认用 LanceDB（嵌入式、免运维，支持 BM25 + 向量混合检索）；需要多设备/Web 访问时再考虑 Supabase pgvector 或 Qdrant Cloud。
- Embedding：内容以中文为主，首选 Gemini `gemini-embedding-001` 或本地免费的 BGE-M3；OpenAI `text-embedding-3-small` 胜在便宜。注意换 embedding 模型需要全量重建索引，因此入库时要记录每个 chunk 的源文件 hash 与模型版本。
- Pipeline：md 按标题层级分块（保留标题路径作为上下文）→ embedding → LanceDB，用文件 hash 做增量更新。
- 取舍：个人知识库规模（几千到几万 chunk）远达不到需要托管向量数据库的量级，先本地跑通、调好分块与检索质量，换存储后端是廉价重构。

## 本地验证记录（2026-07-24，M3 / 24GB Mac）

方案已通过 demo 跑通（demo 按 scratch 规则删除，后续实施在另一个项目进行）：

- 技术栈：Python venv + sentence-transformers + LanceDB（`pip install` 即完成安装，embedded 库形态，无服务进程，数据就是本地目录）。
- demo 用 `bge-small-zh-v1.5`（~100MB）快速验证可行；正式使用换 BGE-M3。注意 bge-*-zh-v1.5 系列 query 侧需加检索指令前缀（"为这个句子生成表示以用于检索相关文章："），BGE-M3 不需要。
- hybrid 检索验证有效：vector search + BM25（LanceDB 原生 FTS）各取 top 10，RRF 融合。精确英文术语（如 "worktree"）被双路同时命中、以约两倍 score 排第一。
- 中文受 FTS 默认 tokenizer 限制，中文语义召回主要靠 vector，BM25 补英文术语——中文场景这个分工是合理的。
- API 备忘：LanceDB 0.25+ 建全文索引用 `table.create_index("text", config=FTS())`，`create_fts_index` 已弃用。
- 增量更新：sha256 manifest；文件变更时先 `table.delete(path=...)` 再 add 新 chunk，文件删除同步清理。
- 云方案（Supabase pgvector）的额外坑：HNSW 对 `vector` 类型约 2000 维上限（3072 维模型需 MRL 截断或用 `halfvec`）；Supabase 装不了中文分词扩展，中文 hybrid search 受限；free tier 闲置约一周暂停项目。中文全文检索是刚需时 Qdrant Cloud 更对口。
