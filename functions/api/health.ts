/**
 * GET /api/health — liveness for uptime monitors.
 */
export const onRequestGet: PagesFunction = async () => {
  return Response.json({ ok: true, service: "orevrk-cloud" });
};
