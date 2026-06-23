import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  experimental: {
    // Suppress CSS preload warnings caused by Next.js CSS chunking
    optimizeCss: false,
  },
  // Reduce unnecessary CSS chunk preloading
  webpack(config, { isServer }) {
    if (!isServer) {
      // Disable prefetching of CSS chunks that aren't immediately needed
      config.optimization = {
        ...config.optimization,
        splitChunks: {
          ...(config.optimization?.splitChunks as object || {}),
          cacheGroups: {
            ...((config.optimization?.splitChunks as Record<string, unknown>)?.cacheGroups as Record<string, unknown> || {}),
          },
        },
      };
    }
    return config;
  },
};

export default nextConfig;
