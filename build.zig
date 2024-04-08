const srcs = &.{
    "library/adler32.c",
    "library/compress.c",
    "library/crc32.c",
    "library/deflate.c",
    "library/gzclose.c",
    "library/gzlib.c",
    "library/gzread.c",
    "library/gzwrite.c",
    "library/inflate.c",
    "library/infback.c",
    "library/inftrees.c",
    "library/inffast.c",
    "library/trees.c",
    "library/uncompr.c",
    "library/zutil.c",
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zlib",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    lib.addCSourceFiles(.{ .files = srcs, .flags = &.{"-std=c89"} });
    lib.linkLibC();
    lib.installHeader("library/zlib.h", "zlib.h");
    lib.installHeader("library/zconf.h", "zconf.h");

    b.installArtifact(lib);

    const module = b.addModule("zlib", .{
        .root_source_file = null,
    });

    module.linkLibrary(lib);
}

const std = @import("std");
