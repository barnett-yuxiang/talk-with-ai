# 个人知识库选型

- 日期：2026-07-24
- 结论：数据源为自维护 markdown 文件；本地默认用 LanceDB（嵌入式、免运维，支持 BM25 + 向量混合检索）；需要多设备/Web 访问时再考虑 Supabase pgvector 或 Qdrant Cloud。
- Embedding：内容以中文为主，首选 Gemini `gemini-embedding-001` 或本地免费的 BGE-M3；OpenAI `text-embedding-3-small` 胜在便宜。注意换 embedding 模型需要全量重建索引，因此入库时要记录每个 chunk 的源文件 hash 与模型版本。
- Pipeline：md 按标题层级分块（保留标题路径作为上下文）→ embedding → LanceDB，用文件 hash 做增量更新。
- 取舍：个人知识库规模（几千到几万 chunk）远达不到需要托管向量数据库的量级，先本地跑通、调好分块与检索质量，换存储后端是廉价重构。
