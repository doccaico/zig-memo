const std = @import("std");

test "AutoArrayHashMap Usage" {
    var map = std.AutoArrayHashMap(u32, u32).init(std.testing.allocator);
    defer map.deinit();

    try map.put(4, 4);
    try map.put(1, 1);
    try map.put(3, 3);
    try map.put(2, 2);

    try std.testing.expectEqual(0, map.getIndex(4).?);
    try std.testing.expectEqual(1, map.getIndex(1).?);
    try std.testing.expectEqual(2, map.getIndex(3).?);
    try std.testing.expectEqual(3, map.getIndex(2).?);
}

// test
