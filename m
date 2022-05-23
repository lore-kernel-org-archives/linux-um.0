Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntD3H-005Zm3-Pt
 for linux-um@lists.infradead.org; Mon, 23 May 2022 18:45:14 +0000
Received: by mail-lj1-x22f.google.com with SMTP id i23so18281999ljb.4
 for <linux-um@lists.infradead.org>; Mon, 23 May 2022 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-22-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-22-ojeda@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 23 May 2022 11:44:51 -0700
Message-ID: <CAKwvOdkTjxNEmCTnuH5f41WB50ef6ErBM2Kp2zJ-t9q_5U8rBA@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Boqun Feng <boqun.feng@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Dariusz Sosnowski <dsosnowski@dsosnowski.pl>, Antonio Terceiro <antonio.terceiro@linaro.org>, Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>, David Gow <davidgow@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org

> +choice
> +       prompt "Optimization level"
> +       default RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       depends on RUST
> +       help
> +         Controls rustc's `-Copt-level` codegen option.
> +
> +         This flag controls the optimization level.
> +
> +         If unsure, say "Similar as chosen for C".
> +
> +config RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       bool "Similar as chosen for C"
> +       help
> +         This choice will pick a similar optimization level as chosen in
> +         the "Compiler optimization level" for C:
> +
> +             -O2 is currently mapped to -Copt-level=2
> +             -O3 is currently mapped to -Copt-level=3
> +             -Os is currently mapped to -Copt-level=s
> +
> +         The mapping may change over time to follow the intended semantics
> +         of the choice for C as sensibly as possible.
> +
> +         This is the default.
> +
> +config RUST_OPT_LEVEL_0
> +       bool "No optimizations (-Copt-level=0)"
> +       help
> +         Not recommended for most purposes. It may come in handy for debugging
> +         suspected optimizer bugs, unexpected undefined behavior, etc.
> +
> +         Note that this level will *not* enable debug assertions nor overflow
> +         checks on its own (like it happens when interacting with rustc
> +         directly). Use the corresponding configuration options to control
> +         that instead, orthogonally.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_1
> +       bool "Basic optimizations (-Copt-level=1)"
> +       help
> +         Useful for debugging without getting too lost, but without
> +         the overhead and boilerplate of no optimizations at all.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_2
> +       bool "Some optimizations (-Copt-level=2)"
> +       help
> +         The sensible choice in most cases.
> +
> +config RUST_OPT_LEVEL_3
> +       bool "All optimizations (-Copt-level=3)"
> +       help
> +         Yet more performance (hopefully).
> +
> +config RUST_OPT_LEVEL_S
> +       bool "Optimize for size (-Copt-level=s)"
> +       help
> +         Smaller kernel, ideally without too much performance loss.
> +
> +config RUST_OPT_LEVEL_Z
> +       bool "Optimize for size, no loop vectorization (-Copt-level=z)"
> +       help
> +         Like the previous level, but also turn off loop vectorization.

I'm super not into having the rust optimization level differ from the
C optimization level.  This is just someone having too much fun
wrapping every compiler flag in a kbuild option.  Either folks wan't
smaller size or more optimizations. Allowing for RUST_OPT_LEVEL_S and
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE or RUST_OPT_LEVEL_3 and
CONFIG_CC_OPTIMIZE_FOR_SIZE is just wacky nonsense that's going to
make randconfig bug reports more confusing to tease out.
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

