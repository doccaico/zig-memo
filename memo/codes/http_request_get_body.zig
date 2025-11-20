const std = @import("std");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    const gpa = debug_allocator.allocator();
    defer std.debug.assert(debug_allocator.deinit() == .ok);

    const url: []const u8 = "https://example.com";

    var client = std.http.Client{ .allocator = gpa };
    defer client.deinit();

    var body: std.Io.Writer.Allocating = .init(gpa);
    defer body.deinit();

    const fetch_res = try client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
        .response_writer = &body.writer,
    });
    std.debug.assert(fetch_res.status == .ok);

    std.debug.print("{s}", .{body.written()});
}

// exe=succeed
