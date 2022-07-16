Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v7 00/25] Rust support
Date: Sat, 16 Jul 2022 13:42:14 +0100
Message-Id: <20220716124214.329949-1-conor@kernel.org>
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: ojeda@kernel.org
Cc: gregkh@linuxfoundation.org, jarkko@kernel.org, kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org, rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org

Hey,

Maybe I am just missing something blatantly obvious here, but trying
to build rust support in -next fails for me. I am using ClangBuiltLinux
clang version 15.0.0 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa and LLD
15.0.0. Is it just expected that building -next with rust support is
not a good idea?
My defconfig is the default RISC-V one plus:
CONFIG_RUST=y
CONFIG_SAMPLES=y
CONFIG_SAMPLES_RUST=y
CONFIG_SAMPLE_RUST_MINIMAL=y

Thanks,
Conor.

Fail log:
  UPD     rust/target.json
  BINDGEN rust/bindings_generated.rs
  BINDGEN rust/bindings_helpers_generated.rs
  RUSTC L rust/core.o
  EXPORTS rust/exports_core_generated.h
  RUSTC P rust/libmacros.so
  RUSTC L rust/compiler_builtins.o
  RUSTC L rust/alloc.o
  RUSTC L rust/build_error.o
  EXPORTS rust/exports_alloc_generated.h
  RUSTC L rust/kernel.o
error[E0428]: the name `maple_enode` is defined multiple times
     --> linux/rust/bindings_generated.rs:18009:1
      |
18006 | pub struct maple_enode {
      | ---------------------- previous definition of the type `maple_enode` here
...
18009 | pub type maple_enode = *mut maple_enode;
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `maple_enode` redefined here
      |
      = note: `maple_enode` must be defined only once in the type namespace of this module

error[E0428]: the name `maple_pnode` is defined multiple times
     --> linux/rust/bindings_generated.rs:18015:1
      |
18012 | pub struct maple_pnode {
      | ---------------------- previous definition of the type `maple_pnode` here
...
18015 | pub type maple_pnode = *mut maple_pnode;
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `maple_pnode` redefined here
      |
      = note: `maple_pnode` must be defined only once in the type namespace of this module

error[E0391]: cycle detected when expanding type alias `bindings::bindings_raw::maple_pnode`
     --> linux/rust/bindings_generated.rs:18015:29
      |
18015 | pub type maple_pnode = *mut maple_pnode;
      |                             ^^^^^^^^^^^
      |
      = note: ...which immediately requires expanding type alias `bindings::bindings_raw::maple_pnode` again
      = note: type aliases cannot be recursive
      = help: consider using a struct, enum, or union instead to break the cycle
      = help: see <https://doc.rust-lang.org/reference/types.html#recursive-types> for more information
note: cycle used when computing type of `bindings::bindings_raw::maple_range_64::parent`
     --> linux/rust/bindings_generated.rs:18058:22
      |
18058 |     pub parent: *mut maple_pnode,
      |                      ^^^^^^^^^^^

error[E0391]: cycle detected when expanding type alias `bindings::bindings_raw::maple_enode`
     --> linux/rust/bindings_generated.rs:18009:29
      |
18009 | pub type maple_enode = *mut maple_enode;
      |                             ^^^^^^^^^^^
      |
      = note: ...which immediately requires expanding type alias `bindings::bindings_raw::maple_enode` again
      = note: type aliases cannot be recursive
      = help: consider using a struct, enum, or union instead to break the cycle
      = help: see <https://doc.rust-lang.org/reference/types.html#recursive-types> for more information
note: cycle used when computing type of `bindings::bindings_raw::maple_topiary::next`
     --> linux/rust/bindings_generated.rs:18340:20
      |
18340 |     pub next: *mut maple_enode,
      |                    ^^^^^^^^^^^

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18005:10
      |
18005 | #[derive(Copy, Clone)]
      |          ^^^^
      |          |
      |          impl doesn't use only types from inside the current crate
      |          `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Copy` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18011:10
      |
18011 | #[derive(Copy, Clone)]
      |          ^^^^
      |          |
      |          impl doesn't use only types from inside the current crate
      |          `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Copy` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18005:16
      |
18005 | #[derive(Copy, Clone)]
      |                ^^^^^
      |                |
      |                impl doesn't use only types from inside the current crate
      |                `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Clone` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
     --> linux/rust/bindings_generated.rs:18011:16
      |
18011 | #[derive(Copy, Clone)]
      |                ^^^^^
      |                |
      |                impl doesn't use only types from inside the current crate
      |                `*mut [type error]` is not defined in the current crate
      |
      = note: define and implement a trait or new type instead
      = note: this error originates in the derive macro `Clone` (in Nightly builds, run with -Z macro-backtrace for more info)

error: aborting due to 8 previous errors

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

