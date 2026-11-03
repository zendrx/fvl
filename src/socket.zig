const std = @import("std");
const httpz = @import("httpz");
const file = @import("file.zig");
const Io = std.Io;
const Alloc = std.mem.Allocator;

const AppContext = struct {
    io: Io,
    alloc: Alloc,
};

pub fn server(io: Io, alloc: Alloc) !void {
    const app = AppContext{ .io = io, .alloc = alloc };
    var servers = try httpz.Server(AppContext).init(io, alloc, .{
        .address = .localhost(8080),
    }, app);
    defer servers.deinit();
    var router = try servers.router(.{});
    router.get("/check/:id", checkId, .{});
    router.get("/content/:id", getCont, .{});
    router.post("/create", createf, .{});
    router.get("/delete/:id", delete, .{});

    std.log.info("httpz server starting on http://127.0.0.1:8080...", .{});
    try servers.listen();
}

fn checkId(env: AppContext, req: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("recceived id check req...\n", .{});
    const id = req.param("id") orelse "unknown";
    const result = try file.check(id, env.io);
    if (result == true) {
        res.status = 200;
        res.body = id;
        return;
    } else {
        res.status = 404;
        res.body = "id doesnt match any file";
        return;
    }
}

fn getCont(env: AppContext, req: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("received contet req....\n", .{});
    const id = req.param("id") orelse "unknown";
    const content = file.getcontent(id, env.io, res.arena) catch |err| {
        switch (err) {
            error.InvalidId => {
                res.status = 400;
                res.body = "invalid id";
                return;
            },
            else => |e| {
                return e;
            },
        }
    };

    res.body = content;
    res.status = 200;
    return;
}

fn createf(env: AppContext, req: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("received create req....", .{});
    const bytes = req.body() orelse {
        res.status = 400;
        res.body = "missing file bytes(body)";
        return;
    };

    const id = try file.create(bytes, env.io, res.arena);
    res.status = 200;
    res.body = id;
    return;
}

fn delete(env: AppContext, req: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("received delete req....\n", .{});
    const id = req.param("id") orelse "unknown";
    try file.delete(id, env.io);
    res.status = 200;
    return;
}
