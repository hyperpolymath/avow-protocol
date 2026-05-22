// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell
// FFI bindings for @std/path (Deno standard library)

@module("@std/path") external relative: (string, string) => string = "relative"

@module("@std/path") external basename: string => string = "basename"

@module("@std/path") external join: (string, string) => string = "join"

@module("@std/path") external dirname: string => string = "dirname"
