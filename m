Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
 <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Aug 2022 17:13:25 +0200
Message-ID: <CANiq72nNucEhXAXkXSujnGkpQrkv3-Pcn7ua8N=2XB-suAjs9w@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Van Asbroeck <thesven73@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Miguel Cano <macanroj@gmail.com>, Paul Mackerras <paulus@samba.org>, Gary Guo <gary@garyguo.net>, Douglas Su <d0u9.su@outlook.com>, Borislav Petkov <bp@alien8.de>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Wedson Almeida Filho <wedsonaf@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Antonio Terceiro <antonio.terceiro@linaro.org>, Adam Bratschi-Kaye <ark.email@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, linux-um@lists.infradead.org, =?UTF-8?Q?Bj=C3=83B_6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Michal Marek <michal.lkml@markovi.net>, Daniel Xu <dxu@dxuuu.xyz>, David Gow <davidgow@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Dariusz Sosnowski <dsosnowski@dsosnowski.pl>, linux-arm-kernel@lists.infradead.org, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Boris-Chengbiao Zhou <bobo1239@web.de>, Jarkko Sakkinen <jarkko@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, Finn Behrens <me@kloenk.de>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org, Philip Herron <philip.herron@embecosm.com>, Arthur Cohen <arthur.cohen@embecosm.com>

Hi Arnd,

On Wed, Aug 17, 2022 at 4:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Miguel,
>
> I tried enabling rust support in the gcc builds I provide at
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/12.1.0/

Thanks for giving it a go!

> to make this more accessible, but it appears that the command line
> options here are not portable:
>
>  /home/arnd/cross/x86_64/gcc-12.1.0+rust-nolibc/x86_64-linux/bin/x86_64-linux-gccrs

So you mean with GCC Rust, right? (i.e. we have "GCC builds" working,
via compiling the Rust side with LLVM and linking with the GCC C side,
but it is not intended for production or to be supported, even if we
cover it in our CI, test it boots and loads modules etc.).

Indeed, `gccrs` does not support `rustc` flags yet. I am not sure if
the GCC Rust team will eventually provide a driver for those like
clang does for e.g. `cl` -- I would hope they do, since many projects
would benefit from it, but maybe they plan to start simply by
modifying Cargo to call them as they need instead.

If they don't support it, we will have to map the flags on our side --
it should not be a big problem. However, see below...

> I guess nobody has tried this so far. Would you think that fixing this is only
> a matter for fixing the build system to pass the correct flags depending on the
> compiler, or is this broken in a more fundamental way?

If you meant GCC Rust, then it is a bit too early for the compiler. As
far as I now, they are working on compiling the `core` crate and
supporting more stable language features. They are also researching
the integration of the borrow checker, though we wouldn't need that
for "only" compiling the kernel.

Now, if they decided to focus on supporting Rust for Linux early on
(which would be great), they would still need to work on the delta
between what what they target now and what we use (which includes both
stable and some unstable features), plus I assume infrastructure bits
like the platform (target spec) support, the flags / `rustc` driver
(though I would be happy to do as much as possible on our side to
help), etc.

(We privately talked about possible timelines for all that if they
were to focus on Rust for Linux etc., but I let them comment or not on
that... Cc'ing them! :)

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

