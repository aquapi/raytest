const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Link raylib & raygui
    {
        const raylib_dep = b.dependency("raylib", .{
            .target = target,
            .optimize = optimize,

            .raudio = true,
            .rmodels = true,
            .rshapes = true,
            .rtext = true,
            .rtextures = true,

            .shared = true,
        });

        const raylib = raylib_dep.artifact("raylib");
        @import("raylib").addRaygui(b, raylib, b.dependency("raygui", .{
            .target = target,
            .optimize = optimize,
        }));

        exe.linkLibrary(raylib);
    }

    b.installArtifact(exe);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
