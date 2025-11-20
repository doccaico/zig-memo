const std = @import("std");

pub fn main() !void {
    var buffer: [5]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    _ = try allocator.alloc(u8, 3);
    _ = try allocator.alloc(u8, 2);

    try std.testing.expectError(error.OutOfMemory, allocator.alloc(u8, 1));
}

// exe=succeed
