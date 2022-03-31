Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZk5y-000Gmz-71
 for linux-um@lists.infradead.org; Thu, 31 Mar 2022 01:59:31 +0000
Received: by mail-wr1-x42b.google.com with SMTP id h4so31621961wrc.13
 for <linux-um@lists.infradead.org>; Wed, 30 Mar 2022 18:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-2-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-2-nathan@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 31 Mar 2022 09:59:13 +0800
Message-ID: <CABVgOSk+qM8o5okFG=BbshQq_gSh5dGvy99sqjOAznHDJ3BxqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
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
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, llvm@lists.linux.dev, patches@lists.linux.dev

On Thu, Mar 31, 2022 at 7:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
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

This seems to work fine here under the KUnit tooling, with both x86_64
and arm64. That admittedly doesn't do anything with modules, so
wouldn't reveal any of those issues, but at least the warnings about
--mno-global-merge existing remain gone.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

