pub const packages = struct {
    pub const @"httpz-0.0.0-PNVzrNAXCQDHb-rRH2jq07A3Ekv3GS6XOTkiqZJtKeqv" = struct {
        pub const build_root = "/home/zendrx/developer/projects/fvl/zig-pkg/httpz-0.0.0-PNVzrNAXCQDHb-rRH2jq07A3Ekv3GS6XOTkiqZJtKeqv";
        pub const build_zig = @import("httpz-0.0.0-PNVzrNAXCQDHb-rRH2jq07A3Ekv3GS6XOTkiqZJtKeqv");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "metrics-0.0.0-W7G4eGWhAQC-C6tpIW3uxJp-vl6rLyfJvoqJRLzF1SuS" },
            .{ "websocket", "websocket-0.1.0-ZPISdbERBQCnk2-UDVSJlOss6POs_aAJR2nrccYJ1wZm" },
        };
    };
    pub const @"metrics-0.0.0-W7G4eGWhAQC-C6tpIW3uxJp-vl6rLyfJvoqJRLzF1SuS" = struct {
        pub const build_root = "/home/zendrx/developer/projects/fvl/zig-pkg/metrics-0.0.0-W7G4eGWhAQC-C6tpIW3uxJp-vl6rLyfJvoqJRLzF1SuS";
        pub const build_zig = @import("metrics-0.0.0-W7G4eGWhAQC-C6tpIW3uxJp-vl6rLyfJvoqJRLzF1SuS");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"websocket-0.1.0-ZPISdbERBQCnk2-UDVSJlOss6POs_aAJR2nrccYJ1wZm" = struct {
        pub const build_root = "/home/zendrx/developer/projects/fvl/zig-pkg/websocket-0.1.0-ZPISdbERBQCnk2-UDVSJlOss6POs_aAJR2nrccYJ1wZm";
        pub const build_zig = @import("websocket-0.1.0-ZPISdbERBQCnk2-UDVSJlOss6POs_aAJR2nrccYJ1wZm");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "httpz", "httpz-0.0.0-PNVzrNAXCQDHb-rRH2jq07A3Ekv3GS6XOTkiqZJtKeqv" },
};
