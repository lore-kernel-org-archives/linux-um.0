Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOAhB-008pYz-44
 for linux-um@lists.infradead.org; Sun, 27 Feb 2022 03:58:07 +0000
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 21R3viqe005860
 for <linux-um@lists.infradead.org>; Sun, 27 Feb 2022 12:57:45 +0900
Received: by mail-pf1-f181.google.com with SMTP id p8so8098840pfh.8
 for <linux-um@lists.infradead.org>; Sat, 26 Feb 2022 19:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20220224055831.1854786-1-keescook@chromium.org>
In-Reply-To: <20220224055831.1854786-1-keescook@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 27 Feb 2022 12:57:02 +0900
Message-ID: <CAK7LNAQewgWYhioL-kWvgpQCnLeg6vgULbAotU-qi46NDoFw2w@mail.gmail.com>
Subject: Re: [PATCH v2] um: Allow builds with Clang
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
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com, llvm@lists.linux.dev, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-hardening@vger.kernel.org

On Thu, Feb 24, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> Add x86-64 target for Clang+um and update user-offsets.c to use
> Clang-friendly assembly, similar to the fix from commit cf0c3e68aa81
> ("kbuild: fix asm-offset generation to work with clang").
>
> This lets me run KUnit tests with Clang:
>
> $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> ...
> $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> ...
>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-um@lists.infradead.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: llvm@lists.linux.dev
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/Yg2YubZxvYvx7%2Fnm@dev-arch.archlinux-ax161/
> Tested-by: David Gow <davidgow@google.com>
> Link: https://lore.kernel.org/lkml/CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220217002843.2312603-1-keescook@chromium.org/
> v2:
>  - tweak commit log phrasing and alphabetize targets (nathan)
>  - fix a missing implicit fallthrough under 32-bit builds
>  - add review tags
> ---
>  arch/um/os-Linux/execvp.c  | 1 +
>  arch/x86/um/user-offsets.c | 4 ++--
>  scripts/Makefile.clang     | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
> index 84a0777c2a45..c09a5fd5e225 100644
> --- a/arch/um/os-Linux/execvp.c
> +++ b/arch/um/os-Linux/execvp.c
> @@ -93,6 +93,7 @@ int execvp_noalloc(char *buf, const char *file, char *const argv[])
>                                            up finding no executable we can use, we want to diagnose
>                                            that we did find one but were denied access.  */
>                                         got_eacces = 1;
> +                                       break;
>                                 case ENOENT:
>                                 case ESTALE:
>                                 case ENOTDIR:
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index bae61554abcc..d9071827b515 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -10,10 +10,10 @@
>  #include <asm/types.h>
>
>  #define DEFINE(sym, val) \
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))


Another way might be  #include <linux/kbuild.h> and delete this macro
definition.


>  #define DEFINE_LONGS(sym, val) \
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))


This generates wrong comments.

In include/generated/user_constants.h,
I see this:

   #define HOST_BX 5 /* RBX */

(Here, the value of RBX is 40.)



  #define DEFINE_LONGS(sym, val)     asm volatile("\n.ascii \"->" #sym
" %0 " #val "/sizeof(unsigned long)\"": : "i" (val/sizeof(unsigned
long)))

creates valid comments:

   #define HOST_BX 5 /* RBX/sizeof(unsigned long) */



Another way might be to do this indirectly.

     #define DEFINE_LONGS(sym, val)     DEFINE(sym, val / sizeof(unsigned long))

The comments in include/generated/user_constans.h do not retain
the original macro names, though...







>  void foo(void)
>  {
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 51fc23e2e9e5..6e49344c6db2 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -9,6 +9,7 @@ CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
>  CLANG_TARGET_FLAGS_powerpc     := powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
> +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu


Personally, I like Nathan's idea, but we can live with the hard-coding
since we see no efforts for UML on other host arch.




>  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
>  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

