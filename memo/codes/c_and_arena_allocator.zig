const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.c_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const ptr = try allocator.create(i32);
    // defer allocator.destroy(ptr);
    // 本来ならdestroyしないといけないけど、ArenaAllocatorなので必要ない。
    ptr.* = 7;

    std.debug.assert(ptr.* == 7);
}

// exe=succeed
// link_libc
