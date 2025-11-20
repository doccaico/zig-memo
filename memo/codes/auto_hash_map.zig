const std = @import("std");

test "AutoHashMap Usage" {
    var map = std.AutoHashMap(u32, u32).init(std.testing.allocator);
    defer map.deinit();

    try map.put(1, 10);
    try map.put(2, 20);

    var it = map.iterator();
    while (it.next()) |kv| {
        try std.testing.expectEqual(kv.value_ptr.*, kv.key_ptr.* * 10);
    }
}

// test
