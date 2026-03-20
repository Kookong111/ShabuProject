# 1. ใช้ Maven ในการ Build โปรเจกต์ให้กลายเป็นไฟล์ .war
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# 2. นำไฟล์ .war ที่ได้ ไปใส่ใน Tomcat Server
FROM tomcat:9.0-jdk17
# ลบหน้าเว็บเริ่มต้นของ Tomcat ทิ้ง
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# เอาไฟล์ .war ของเรามาใส่แทน และตั้งชื่อเป็น ROOT.war เพื่อให้รันที่หน้าแรก (/)
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# เปิดพอร์ต 8080
EXPOSE 8080
CMD ["catalina.sh", "run"]
