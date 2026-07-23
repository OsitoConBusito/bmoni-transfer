import { composeDependencies } from "./infrastructure/composition-root.js";
import { createApp } from "./infrastructure/http/app.js";
import { loadConfig } from "./shared/config.js";
import { logger } from "./shared/logger.js";

const config = loadConfig();
const deps = composeDependencies(config);
const app = createApp(config, deps);

app.listen(config.PORT, () => {
  logger.info({ port: config.PORT, rateProvider: config.RATE_PROVIDER }, "bmoni backend listening");
});
