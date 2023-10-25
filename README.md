# stylish-shop
```
 npx sequelize-cli model:generate --name product --attributes name:string,price:integer,description:string,stock:integer,image:string
-----------------------------------------------------------------------------------------
 npx sequelize-cli model:generate --name brand --attributes name:string,image:string

 npx sequelize-cli model:generate --name category --attributes name:string

 npx sequelize-cli model:generate --name brandproduct --attributes products_id:integer, brands_id:integer

 npx sequelize-cli model:generate --name categoryproduct --attributes products_id:integer,categories_id:integer

npx sequelize-cli model:generate --name user --attributes uid:string,name:string,email:string,password:string,image:string,address:string,role:enum,gender:enum,birthday:date,phone_number:string

npx sequelize-cli model:generate --name transaction --attributes user_id:integer,product_id:integer,status:enum

npx sequelize-cli model:generate --name courier --attributes name:string,price:integer

npx sequelize-cli model:generate --name review --attributes user_id:integer,products_id:integer,review:string



```