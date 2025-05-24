FROM golang:1.22 AS base

WORKDIR /app

COPY go.mod .

RUN go mod download 

COPY . .

RUN go build -o /main .

# Expose 8080
# CMD ["./main"]


# FINAL STAGE  :: for more security and less image size, we'll use distroless image

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]