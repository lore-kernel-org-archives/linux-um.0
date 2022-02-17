Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKkmn-00BcDs-RW
 for linux-um@lists.infradead.org; Thu, 17 Feb 2022 17:41:47 +0000
Date: Thu, 17 Feb 2022 10:41:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] um: Allow builds with Clang
Message-ID: <Yg6I0YZAh5yWYpT2@dev-arch.archlinux-ax161>
References: <20220217002843.2312603-1-keescook@chromium.org>
 <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
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
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Nick Desaulniers <ndesaulniers@google.com>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com, llvm@lists.linux.dev, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-hardening@vger.kernel.org

On Thu, Feb 17, 2022 at 01:54:58PM +0900, Masahiro Yamada wrote:
> On Thu, Feb 17, 2022 at 9:28 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Add x86-64 target for Clang+um and update user-offsets.c to use
> > Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
> > ("kbuild: fix asm-offset generation to work with clang").
> >
> > This lets me run KUnit tests with Clang:
> >
> > $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> > ...
> > $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> > ...
> >
> > Cc: Jeff Dike <jdike@addtoit.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: David Gow <davidgow@google.com>
> > Cc: linux-um@lists.infradead.org
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/um/user-offsets.c | 4 ++--
> >  scripts/Makefile.clang     | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> > index bae61554abcc..d9071827b515 100644
> > --- a/arch/x86/um/user-offsets.c
> > +++ b/arch/x86/um/user-offsets.c
> > @@ -10,10 +10,10 @@
> >  #include <asm/types.h>
> >
> >  #define DEFINE(sym, val) \
> > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
> >
> >  #define DEFINE_LONGS(sym, val) \
> > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
> >
> >  void foo(void)
> >  {
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 51fc23e2e9e5..857b23de51c6 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc    := powerpc64le-linux-gnu
> >  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
> >  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
> >  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> > +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu
> 
> 
> Does this work for the i386 host?
> 
> UML supports i386 and x86_64 as the host architecture as of now,
> but this always compiles UML for x86_64?

I think the current code will work because arch/x86/Makefile.um includes
-m32 for CONFIG_X86_32, which will implicitly change x86_64-linux-gnu
into a 32-bit target triple:

$ echo | clang --target=x86_64-linux-gnu -x c -c -o test.o -

$ file test.o
test.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped

$ echo | clang --target=x86_64-linux-gnu -m32 -x c -c -o test.o -

$ file test.o
test.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped

In fact, we rely on this for ARCH=i386 LLVM=1 right now, as it uses
x86_64-linux-gnu for the target flag.

While UML only supports x86, maybe it is worth using SUBARCH instead of
hardcoding the triple? No strong opinion around that though.

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..87285b76adb2 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)

> >  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
> >
> >  ifeq ($(CROSS_COMPILE),)
> > --
> > 2.30.2
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

