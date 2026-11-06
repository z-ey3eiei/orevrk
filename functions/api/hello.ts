/**
 * GET /api/hello — simple JSON for smoke tests and demos.
 */
export const onRequestGet: PagesFunction = async () => {
  return Response.json({
    ok: true,
    message: "Hello from orevrk.cloud (Cloudflare Pages Functions)",
  });
};
