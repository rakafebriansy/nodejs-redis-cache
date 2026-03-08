import { PrismaClient } from "@prisma/client";
import { logger } from "./logging.js";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";
import 'dotenv/config'

const adapter = new PrismaMariaDb({
    host: "127.0.0.1",
    port: 3306,
    user: "root",
    password: "", // Biarkan kosong untuk Laragon
    database: "nodejs_redis_cache",
    connectionLimit: 5,
    // Ini adalah fitur logger tambahan untuk mengintip masalah aslinya
    logger: {
        network: (info) => {
            console.log("=== PRISMA ADAPTER NETWORK ===", info);
        },
        query: (info) => {
            console.log("=== PRISMA ADAPTER QUERY ===", info);
        },
        error: (error) => {
            console.error("=== PRISMA ADAPTER ERROR ===", error);
        },
        warning: (info) => {
            console.warn("=== PRISMA ADAPTER WARNING ===", info);
        },
    }
});

export const prismaClient = new PrismaClient({
    adapter,
    log: [
        {
            emit: 'event',
            level: 'query',
        },
        {
            emit: 'event',
            level: 'error',
        },
        {
            emit: 'event',
            level: 'info',
        },
        {
            emit: 'event',
            level: 'warn',
        },
    ],
});

prismaClient.$on('error', (e) => {
    logger.error(e);
});

prismaClient.$on('warn', (e) => {
    logger.warn(e);
});

prismaClient.$on('info', (e) => {
    logger.info(e);
});

prismaClient.$on('query', (e) => {
    logger.info(e);
});
