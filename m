Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-28-ojeda@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Aug 2022 16:39:57 +0200
Message-ID: <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
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
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Van Asbroeck <thesven73@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Miguel Cano <macanroj@gmail.com>, Paul Mackerras <paulus@samba.org>, Gary Guo <gary@garyguo.net>, Douglas Su <d0u9.su@outlook.com>, Borislav Petkov <bp@alien8.de>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Wedson Almeida Filho <wedsonaf@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Antonio Terceiro <antonio.terceiro@linaro.org>, Adam Bratschi-Kaye <ark.email@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, linux-um@lists.infradead.org, =?UTF-8?Q?Bj=C3=83B_6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Michal Marek <michal.lkml@markovi.net>, Daniel Xu <dxu@dxuuu.xyz>, David Gow <davidgow@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Dariusz Sosnowski <dsosnowski@dsosnowski.pl>, linux-arm-kernel@lists.infradead.org, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Boris-Chengbiao Zhou <bobo1239@web.de>, Jarkko Sakkinen <jarkko@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, Finn Behrens <me@kloenk.de>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org

On Tue, Aug 2, 2022 at 3:50 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> +# These flags apply to all Rust code in the tree, including the kernel and
> +# host programs.
> +export rust_common_flags := --edition=2021 \
> +                           -Zbinary_dep_depinfo=y \
> +                           -Dunsafe_op_in_unsafe_fn -Drust_2018_idioms \
> +                           -Dunreachable_pub -Dnon_ascii_idents \
> +                           -Wmissing_docs \
> +                           -Drustdoc::missing_crate_level_docs \
> +                           -Dclippy::correctness -Dclippy::style \
> +                           -Dclippy::suspicious -Dclippy::complexity \
> +                           -Dclippy::perf \
> +                           -Dclippy::let_unit_value -Dclippy::mut_mut \
> +                           -Dclippy::needless_bitwise_bool \
> +                           -Dclippy::needless_continue \
> +                           -Wclippy::dbg_macro

Hi Miguel,

I tried enabling rust support in the gcc builds I provide at
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/12.1.0/
to make this more accessible, but it appears that the command line
options here are not portable:

 /home/arnd/cross/x86_64/gcc-12.1.0+rust-nolibc/x86_64-linux/bin/x86_64-linux-gccrs
--edition=2021 -Zbinary_dep_depinfo=y -Dunsafe_op_in_unsafe_fn
-Drust_2018_idioms -Dunreachable_pub -Dnon_ascii_idents -Wmissing_docs
-Drustdoc::missing_crate_level_docs -Dclippy::correctness
-Dclippy::style -Dclippy::suspicious -Dclippy::complexity
-Dclippy::perf -Dclippy::let_unit_value -Dclippy::mut_mut
-Dclippy::needless_bitwise_bool -Dclippy::needless_continue
-Wclippy::dbg_macro -O -Cstrip=debuginfo -Zallow-features=
--emit=dep-info,link --out-dir=scripts/
/git/arm-soc/scripts/generate_rust_target.rs; mv
scripts/generate_rust_target.d scripts/.generate_rust_target.d; sed -i
'/^#/d' scripts/.generate_rust_target.d
x86_64-linux-gccrs: error: unrecognized command-line option
'--edition=2021'; did you mean '-frust-edition=2021'?
x86_64-linux-gccrs: error: unrecognized command-line option
'-Zbinary_dep_depinfo=y'
x86_64-linux-gccrs: error: unrecognized command-line option
'-Wmissing_docs'; did you mean '-Wmissing-braces'?
x86_64-linux-gccrs: error: unrecognized command-line option
'-Wclippy::dbg_macro'
x86_64-linux-gccrs: error: unrecognized command-line option '-Cstrip=debuginfo'
x86_64-linux-gccrs: error: unrecognized command-line option '-Zallow-features='
x86_64-linux-gccrs: error: unrecognized command-line option
'--emit=dep-info,link'
x86_64-linux-gccrs: error: unrecognized command-line option '--out-dir=scripts/'
make[3]: *** [/git/arm-soc/scripts/Makefile.host:157:
scripts/generate_rust_target] Error 1

I guess nobody has tried this so far. Would you think that fixing this is only
a matter for fixing the build system to pass the correct flags depending on the
compiler, or is this broken in a more fundamental way?

         Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

