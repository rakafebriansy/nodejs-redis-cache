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

// Fix n+1
const findAll = async () => {
    // using select in
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

    return parents;
}

export default {
    findAll
}