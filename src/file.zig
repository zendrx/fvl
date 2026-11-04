const std = @import("std");
const Io = std.Io;
const Alloc = std.mem.Allocator;

pub fn create(filec: []const u8, io: Io, alloc: Alloc) ![]const u8 {
    const source: std.Random.IoSource = .{ .io = io };
    const id = source.interface().int(u32);

    const stringname = try Alloc.print(alloc, "{d}", .{id});
    const cc = try Io.Dir.cwd().openDir(io, "fvlBin", .{});
    const dd = try cc.createFile(io, stringname, .{
        .read = true,
    });
    try dd.writeStreamingAll(io, filec);
    defer {
        cc.close(io);
    }

    return stringname;
}

pub fn check(id: []const u8, io: Io) !bool {
    const dir = try Io.Dir.cwd().openDir(io, "fvlBin", .{ .iterate = true });
    defer dir.close(io);
    var iterate = dir.iterate();
    while (try iterate.next(io)) |entry| {
        if (std.mem.eql(u8, entry.name, id)) {
            return true;
        }
    }

    return false;
}

pub fn getcontent(id: []const u8, io: Io, alloc: Alloc) ![]u8 {
    if (try check(id, io) == false) {
        return error.InvalidId;
    }

    const dir = try Io.Dir.openDirAbsolute(io, "fvlBin", .{});
    //it would have been okay to provide buffer and use readFile but considering fact some file might be large beyond 8mb
    // stack size alloc is better
    const data = try dir.readFileAlloc(io, id, alloc, .unlimited);
    defer {
        dir.close(io);
    }
    return data;
}

pub fn delete(id: []const u8, io: Io) !void {
    if (try check(id, io) == false) {
        return error.InvalidId;
    }

    const dir = try Io.Dir.cwd().openDir(io, "fvlBin", .{});
    try dir.deleteFile(io, id);
    defer dir.close(io);
}
