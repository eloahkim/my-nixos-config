import { createServer } from "node:http";
import { readFile } from "node:fs/promises";
import { extname, join, sep } from "node:path";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL(".", import.meta.url));
const roots = [join(root, "dist"), join(root, "src")];

const types = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".map": "application/json; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".svg": "image/svg+xml",
  ".png": "image/png",
  ".ico": "image/x-icon",
};

async function readAsset(path) {
  for (const base of roots) {
    const file = join(base, path);
    if (file !== base && !file.startsWith(base + sep)) {
      continue;
    }
    try {
      return { file, body: await readFile(file) };
    } catch {
      // Tenta o próximo diretório.
    }
  }
  return null;
}

const server = createServer(async (request, response) => {
  const url = new URL(request.url ?? "/", "http://localhost");
  const path = url.pathname === "/" ? "/index.html" : url.pathname;
  const asset = await readAsset(path);

  if (!asset) {
    response.writeHead(404, { "content-type": "text/plain; charset=utf-8" });
    response.end("not found");
    return;
  }

  response.writeHead(200, {
    "content-type": types[extname(asset.file)] ?? "application/octet-stream",
    "cache-control": "no-store",
  });
  response.end(asset.body);
});

const port = Number(process.env.PORT ?? 8080);
server.listen(port, "127.0.0.1", () => {
  console.log(`http://127.0.0.1:${port}`);
});
