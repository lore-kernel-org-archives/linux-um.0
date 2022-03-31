Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZoyD-0011GB-Qt
 for linux-um@lists.infradead.org; Thu, 31 Mar 2022 07:11:51 +0000
Received: by mail-io1-xd31.google.com with SMTP id g21so14388826iom.13
 for <linux-um@lists.infradead.org>; Thu, 31 Mar 2022 00:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-2-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-2-nathan@kernel.org>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 31 Mar 2022 09:11:12 +0200
Message-ID: <CA+icZUXrVgGyaujA1iQEw5P3nJHVwMtbFxpE2gKktaxW0Xg-wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: sedat.dilek@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev

On Thu, Mar 31, 2022 at 5:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This flag is specific to clang, where it is only used by the 32-bit and
> 64-bit ARM backends. In certain situations, the presence of this flag
> will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> out -mno-global-merge from USER_CFLAGS").
>
> Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> building kernel with Clang") that added this flag back in 2014, there
> have been quite a few changes to the GlobalMerge pass in LLVM. Building
> several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> (minimum) and 15 (current main version) with this flag removed (i.e.,
> with the default of '-mglobal-merge') reveals no modpost warnings, so it
> is likely that the issue noted in the comment is no longer relevant due
> to changes in LLVM or modpost, meaning this flag can be removed.
>
> If any new warnings show up that are a result of the removal of this
> flag, it can be added back under arch/arm{,64}/Makefile to avoid
> warnings on other architectures.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..f2723d9bfca4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -784,10 +784,6 @@ ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
>  # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
>  KBUILD_CFLAGS += -Wno-gnu
> -# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> -# source of a reference will be _MergedGlobals and not on of the whitelisted names.
> -# See modpost pattern 2
> -KBUILD_CFLAGS += -mno-global-merge
>  else
>
>  # gcc inanely warns about local variables called 'main'
> --
> 2.35.1
>

I have tested this several times and was able to boot into bar metal -
no problems with building and/or booting my kernel-modules.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

Just as a side-note:
As with Linux v5.18-rc1 and -std=gnu11 we change the above comment ...?

# The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
KBUILD_CFLAGS += -Wno-gnu

- Sedat -

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

