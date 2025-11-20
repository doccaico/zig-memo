const std = @import("std");

test "StringHashMap Usage" {
    var map = std.StringHashMap(u32).init(std.testing.allocator);
    defer map.deinit();

    try map.put("one", 1);
    try map.put("two", 2);

    try std.testing.expectEqual(1, map.get("one").?);
    try std.testing.expectEqual(2, map.get("two").?);
}

// test
