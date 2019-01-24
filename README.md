# tnnl

This project is under development.
Unless you are explicitly asked to, do not use it for now!

With tnnl you can make IoT devices that are behind a private network, accessible from the internet.

## Usage as an application

tnnl can be used as an application that makes other applications accessible from the internet.

### Rules

You can provide your own rules using the environment variable `RULE` in the format: `RULE="$IN_HOST:$IN_PORT-$OUT_HOST:$OUT_PORT"`.
Multiple rules can be seperated by `,`.
The rules are evaluated in the order they are provided and the first matching rule will be used.
If no rule is matching the connection is rejected.

For the `$IN_HOST` there are two special values.
1. An empty string is the default host which will only match requests to the default host. Requests to the default host will be redirected to `localhost` if not specified.
2. `*` which is a wildcard that allows access to all devices *(unsupported for now, tnnl requests will only be sent to the default host for now)*.

Here are a few example rules:

|Rule|Description|
|---|---|
|`:*-*:*`|Unrestricted access to all ports on localhost|
|`:80-*:*`|Allow access to port 80|
|`:80-*:4000`|Allow access to port 80 but forward it to port 4000|
|`:*-192.168.1.1:*`|Allow access to all ports on `192.168.1.1`|
|`:80-192.168.1.1:*`|Allow access to port 80 on `192.168.1.1`|
|`:80-192.168.1.1:4000`|Allow access to port 80 on `192.168.1.1` but forward it to port 4000|
|`:80-*:*,:22-*:*`|Allow access to port 80 and port 22|

### Run

```
#if you don't have a token, you should not try it for now.
docker run -d --restart always -e TOKEN="********************" -e RULE=":80-$IP_OF_THE_DEVICE:$HTTP_PORT_OF_THE_DEVICE" --name "my-first-tnnl" weberlars/tnnl
```

## Usage as a library

tnnl can also be embedded in you nodejs application.
Please have a look at the [npm package](https://www.npmjs.com/package/tnnl).
