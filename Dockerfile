# build phase 
# FROM <IMAGE> as <tag> 
FROM node:alpine as builder 

WORKDIR /app
COPY package.json .
RUN npm install 
COPY . .

#we do not need to create a volume mapping since this is production and enougth said
# but seriously, we should track change and push them in production constanly

RUN npm run build

# the output is the build folder 

# so this  is goign to be in the CWD 


#### run phase

FROM nginx 

# from here we change the base image and also terminating the previous block

COPY --from=builder /app/build /usr/share/nginx/html

# the  dont need to specify the start up of the nginx 
# since this is the default file
