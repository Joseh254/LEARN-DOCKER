import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient()

export async function publishProduct(request,response){
    try {
        const {name,price} = request.body
        const product = await prisma.product.create({
          data:{  name:name,
            price:price}
        })
        return response.status(201).json({success:true,data:product})
    } catch (error) {
        console.log(error);
       return response.status(500).json({ success: false, error: "Internal server error" });
        
    }
}