#베이스 이미지 명시
FROM node:alpine as builder

WORKDIR "/usr/src/app"

#package.json 내용이 안바뀌면 npm install 이 안돌도록 
COPY package.json ./

#추가적으로 필요한 파일들을 다운로드
RUN npm install

#package.json 카피하기
COPY ./ ./

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html