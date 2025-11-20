const std = @import("std");

test "StringArrayHashMap Usage" {
    var map = std.StringArrayHashMap(u32).init(std.testing.allocator);
    defer map.deinit();

    try map.put("four", 4);
    try map.put("one", 1);
    try map.put("two", 3);
    try map.put("three", 2);

    try std.testing.expectEqual(0, map.getIndex("four").?);
    try std.testing.expectEqual(1, map.getIndex("one").?);
    try std.testing.expectEqual(2, map.getIndex("two").?);
    try std.testing.expectEqual(3, map.getIndex("three").?);
}

// test
