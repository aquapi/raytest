const std = @import("std");
const ray = @cImport({
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});

pub fn main() !void {
    ray.InitWindow(1280, 720, "App");
    defer ray.CloseWindow();

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();

        ray.ClearBackground(ray.SKYBLUE);
    }
}
