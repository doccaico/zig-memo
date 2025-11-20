const std = @import("std");

test "parsing a JSON string" {
    const s =
        \\{
        \\  "foo": 123,
        \\  "sub": {
        \\    "bar": true
        \\  }
        \\}
    ;
    var parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, s, .{});
    defer parsed.deinit();

    try std.testing.expectEqual(123, parsed.value.object.get("foo").?.integer);
    try std.testing.expectEqual(true, parsed.value.object.get("sub").?.object.get("bar").?.bool);
    try std.testing.expectEqual(null, parsed.value.object.get("notfound"));
}

test "parsing a struct" {
    const T = struct { a: i32 = -1, b: [2]u8 };
    var parsed_struct = try std.json.parseFromSlice(T, std.testing.allocator, "{\"b\":\"xy\"}", .{});
    defer parsed_struct.deinit();

    try std.testing.expectEqual(-1, parsed_struct.value.a);
    try std.testing.expectEqualSlices(u8, "xy", parsed_struct.value.b[0..]);
}

test "stringifying a struct" {
    // zig fmt: off
    const T = struct {
        a: i32,
        b: []const u8,
        c: struct {
            foo: i32,
        }
    }{
        .a = -1,
        .b = &[_]u8{ 'a', 'b' },
        .c = .{ .foo = 7 }
    };
    // zig fmt: on

    var buffer: [1024]u8 = undefined;
    var w: std.io.Writer = .fixed(&buffer);
    var s: std.json.Stringify = .{
        .writer = &w,
        .options = .{ .whitespace = .indent_4 },
    };

    try s.write(T);

    const expected =
        \\{
        \\    "a": -1,
        \\    "b": "ab",
        \\    "c": {
        \\        "foo": 7
        \\    }
        \\}
    ;
    try std.testing.expectEqualStrings(expected, w.buffered());
}

// test
