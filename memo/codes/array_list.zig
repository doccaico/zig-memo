const std = @import("std");

test "ArrayList Usage" {
    const allocator = std.testing.allocator;

    var list = std.ArrayList(u8).empty;
    defer list.deinit(allocator);

    try list.append(allocator, 'a');
    try list.append(allocator, 'b');
    try list.append(allocator, 'c');

    std.debug.assert(std.mem.eql(u8, list.items, "abc"));
}

// test
