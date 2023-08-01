VERSION 0.7

hello:
    FROM earthly/dind:alpine
    WITH DOCKER --pull hello-world
        RUN docker run hello-world
    END
