const std = @import("std");

test "MultiArrayList Usage" {
    const allocator = std.testing.allocator;

    const Foo = struct {
        a: u32,
        b: []const u8,
        c: u8,
    };

    var list = std.MultiArrayList(Foo){};
    defer list.deinit(allocator);

    try std.testing.expectEqual(list.items(.a).len, @as(usize, 0));
    try std.testing.expectEqual(list.items(.b).len, @as(usize, 0));
    try std.testing.expectEqual(list.items(.c).len, @as(usize, 0));

    try list.append(allocator, .{
        .a = 1,
        .b = "fizz",
        .c = 'a',
    });

    try list.append(allocator, .{
        .a = 2,
        .b = "buzz",
        .c = 'b',
    });

    try std.testing.expectEqualSlices(u32, &[_]u32{ 1, 2 }, list.items(.a));
    try std.testing.expectEqualStrings("fizz", list.items(.b)[0]);
    try std.testing.expectEqualStrings("buzz", list.items(.b)[1]);
    try std.testing.expectEqualSlices(u8, &[_]u8{ 'a', 'b' }, list.items(.c));
}

// test
