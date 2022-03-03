Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPpI2-007JgR-3p
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 17:31:00 +0000
Date: Thu, 3 Mar 2022 10:30:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
Message-ID: <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
References: <20220303090643.241747-1-davidgow@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303090643.241747-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hi David,

On Thu, Mar 03, 2022 at 05:06:42PM +0800, David Gow wrote:
> The things built with USER_CFLAGS don't seem to recognise it as a
> compiler option, and print a warning:
> clang: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
> 
> Fixes: 744814d2fa ("um: Allow builds with Clang")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This warning shows up after merging:
> https://lore.kernel.org/lkml/20220227184517.504931-6-keescook@chromium.org/
> 
> I'm not 100% sure why this is necessary, but it does seem to work. All
> the attempts to get rid of -mno-global-merge entirely have been met with
> skepticism, but I'm guessing that it's not a problem for just the UML
> "user" files, as they shouldn't(?) interact too much with modules.

Thank you for the patch! I think it is correct, as this flag only works
for AArch64 and ARM, as it is only used in Clang::AddAArch64TargetArgs()
and Clang::AddARMTargetArgs() in clang/lib/Driver/ToolChains/Clang.cpp,
which are obviously never called with UML. I am not sure why we do not
see warning during regular kernel builds, maybe something about how UML
objects are compiled exposes this?

Regardless, I would definitely like to clean up this instance of the
warning because I would like to make this warning a hard error so that
we do not get cryptic cc-option failures:

https://github.com/ClangBuiltLinux/linux/issues/1587

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small comment below.

>  arch/um/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index f2fe63bfd819..320b09cd513c 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -75,6 +75,10 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
>  		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
>  
> +ifdef CONFIG_CC_IS_CLANG

Is this ifdef needed?

> +USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
> +endif
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
>  
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

