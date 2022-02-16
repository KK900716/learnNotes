```
    public void testJWT(){
        String signature="admin";
        JwtBuilder jwtBuilder= Jwts.builder();
        String jwtToken= String.valueOf(jwtBuilder
                //header
                .setHeaderParam("typ","JWT")
                .setHeaderParam("alg","HS256")
                //payload
                .claim("userName","123456")
                .setSubject("login")
                .setExpiration(new Date(System.currentTimeMillis()+1000*60*60*24))
                .setId(UUID.randomUUID().toString())
                //signature
                .signWith(SignatureAlgorithm.HS256,signature)
                .compact());
        System.out.println(jwtToken);
    }
    public void testParse(){
        String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyTmFtZSI6IjEyMzQ1NiIsInN1YiI6ImxvZ2luIiwiZXhwIjoxNjQ1MTA0NTc2LCJqdGkiOiJjMDM5MzRhMC05YTM3LTQ1ZTAtODkyNi0zMjI0M2MyZGIzY2YifQ.l_YR62DfGH9-nbSqy7yt87gB9PgrwFH8RucimCQm0hA";
        JwtParser jwtParser=Jwts.parser();
        Jws<Claims> claimsJws = jwtParser.setSigningKey(signature).parseClaimsJws(token);
        Claims claims=claimsJws.getBody();
        System.out.println(claims.get("userName"));
        System.out.println(claims.getId());
        System.out.println(claims.getSubject());
        System.out.println(claims.getExpiration());
    }


        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
            <version>0.9.1</version>
        </dependency>
        <dependency>
            <groupId>javax.xml.bind</groupId>
            <artifactId>jaxb-api</artifactId>
        </dependency>
        <dependency>
            <groupId>com.sun.xml.bind</groupId>
            <artifactId>jaxb-impl</artifactId>
            <version>2.3.0</version>
        </dependency>
        <dependency>
            <groupId>com.sun.xml.bind</groupId>
            <artifactId>jaxb-core</artifactId>
            <version>2.3.0</version>
        </dependency>
        <dependency>
            <groupId>javax.activation</groupId>
            <artifactId>activation</artifactId>
            <version>1.1.1</version>
        </dependency>
```