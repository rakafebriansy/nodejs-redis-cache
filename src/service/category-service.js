import Redis from "ioredis";
import { prismaClient } from "../application/database.js"

// // No optimization
// const findAll = async () => {
//     // get all parents
//     const parents = await prismaClient.category.findMany({
//         where: {
//             parent_id: null
//         },
//         select: {
//             id: true,
//             name: true
//         }
//     });

//     // iterate through all parents, then add their children
//     for (let parent of parents) {
//         parent.children = await prismaClient.category.findMany({
//             where: {
//                 parent_id: parent.id
//             },
//             select: {
//                 id: true,
//                 name: true
//             }
//         });
//     }

//     return parents;
// }

// // Fix n+1
// const findAll = async () => {
//     // using select in
//     const parents = await prismaClient.category.findMany({
//         where: {
//             parent_id: null
//         },
//         select: {
//             id: true,
//             name: true,
//             children: true


//         }
//     });

//     return parents;
// }

// Caching
const redis = new Redis({
    host: 'localhost',
    port: 6379,
    db: 0
});

const findAll = async () => {
    // are the data in redis 
    const json = await redis.get('categories');

    // if true, just return the data
    if (json) return JSON.parse(json);

    // if false, lets get the data from database, then store inside redis
    const parents = await prismaClient.category.findMany({
        where: {
            parent_id: null
        },
        select: {
            id: true,
            name: true,
            children: true


        }
    });

    await redis.setex('categories', 60 * 60, JSON.stringify(parents));

    return parents;
}

export default {
    findAll
}