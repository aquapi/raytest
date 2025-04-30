const std = @import("std");

const ray = @import("./cray.zig");
const lib = ray.lib;

pub fn main() !void {
    lib.InitWindow(1280, 720, "App");
    defer lib.CloseWindow();

    lib.SetTargetFPS(60);

    const bg = lib.GetColor(@bitCast(lib.GuiGetStyle(lib.DEFAULT, lib.BACKGROUND_COLOR)));

    while (!lib.WindowShouldClose()) {
        lib.BeginDrawing();
        defer lib.EndDrawing();

        lib.ClearBackground(bg);

        if (lib.GuiButton(.{
            .height = 100,
            .width = 100,
            .x = 100,
            .y = 100,
        }, "Hi") == 1) {
            std.debug.print("Button pressed!\n", .{});
        }
    }
}
