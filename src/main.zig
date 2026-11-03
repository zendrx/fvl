const std = @import("std");
const Io = std.Io;
const Alloc = std.mem.Allocator;
const server = @import("socket.zig");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const alloc = init.gpa;
    const arena = init.arena.allocator();

    Io.Dir.cwd().createDir(io, "fvlBin", .default_dir) catch |err| {
        switch (err) {
            error.PathAlreadyExists => {},
            else => |e| {
                return e;
            },
        }
    };
    const args = try init.minimal.args.toSlice(arena);
    for (args) |arg| {
        if (arg.len < 2) {
            std.log.info("usuage: fvl --<start|stop>", .{});
            return;
        }

        if (std.mem.eql(u8, arg, "--start")) {
            try server.server(io, alloc);
            std.log.info("server started succesfully...", .{});
        }

        if (std.mem.eql(u8, arg, "--stop")) {
            std.process.exit(0);
            std.log.info("fvl stopped...", .{});
        }
    }
}
