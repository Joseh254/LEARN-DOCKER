import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient()

export async function fetchProducts(request,response){
    try {
        const products = await prisma.product.findMany()
        return response.status(200).json({success:true,data:products})
    } catch (error) {
        console.log(error);
        return response.status(500).json({success:false,error:"internal server error!"})
        
    }
}