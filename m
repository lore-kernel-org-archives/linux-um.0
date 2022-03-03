Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Mar 2022 10:04:28 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
Message-ID: <202203030947.E2FA3D9@keescook>
References: <20220303090643.241747-1-davidgow@google.com>
 <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Mar 03, 2022 at 10:30:47AM -0700, Nathan Chancellor wrote:
> Hi David,
> 
> On Thu, Mar 03, 2022 at 05:06:42PM +0800, David Gow wrote:
> > The things built with USER_CFLAGS don't seem to recognise it as a
> > compiler option, and print a warning:
> > clang: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
> > 
> > Fixes: 744814d2fa ("um: Allow builds with Clang")
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> > 
> > This warning shows up after merging:
> > https://lore.kernel.org/lkml/20220227184517.504931-6-keescook@chromium.org/
> > 
> > I'm not 100% sure why this is necessary, but it does seem to work. All
> > the attempts to get rid of -mno-global-merge entirely have been met with
> > skepticism, but I'm guessing that it's not a problem for just the UML
> > "user" files, as they shouldn't(?) interact too much with modules.
> 
> Thank you for the patch! I think it is correct, as this flag only works
> for AArch64 and ARM, as it is only used in Clang::AddAArch64TargetArgs()
> and Clang::AddARMTargetArgs() in clang/lib/Driver/ToolChains/Clang.cpp,
> which are obviously never called with UML. I am not sure why we do not
> see warning during regular kernel builds, maybe something about how UML
> objects are compiled exposes this?

Yeah, I got really turned around when I tried to find this last week.

> 
> Regardless, I would definitely like to clean up this instance of the
> warning because I would like to make this warning a hard error so that
> we do not get cryptic cc-option failures:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1587
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> One small comment below.
> 
> >  arch/um/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/um/Makefile b/arch/um/Makefile
> > index f2fe63bfd819..320b09cd513c 100644
> > --- a/arch/um/Makefile
> > +++ b/arch/um/Makefile
> > @@ -75,6 +75,10 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> >  		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
> >  		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
> >  
> > +ifdef CONFIG_CC_IS_CLANG
> 
> Is this ifdef needed?
> 
> > +USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
> > +endif

How does -mno-global-merge get KBUILD_CFLAGS in the first place? If it's
arm/arm64 only, shouldn't that get relocated to those architectures?

*time travel* found it:

61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang")

So I think this may have been universally true long ago, and now only
arm/arm64 need it?


diff --git a/Makefile b/Makefile
index 2f6fbba88a0e..fbc42c3c389e 100644
--- a/Makefile
+++ b/Makefile
@@ -852,10 +852,6 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
 # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
-# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-# source of a reference will be _MergedGlobals and not on of the whitelisted names.
-# See modpost pattern 2
-KBUILD_CFLAGS += -mno-global-merge
 else
 
 # gcc inanely warns about local variables called 'main'
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..dcab28c44c26 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -48,6 +48,13 @@ CHECKFLAGS	+= -D__ARMEL__
 KBUILD_LDFLAGS	+= -EL
 endif
 
+ifdef CONFIG_CC_IS_CLANG
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
+# source of a reference will be _MergedGlobals and not on of the whitelisted names.
+# See modpost pattern 2
+KBUILD_CFLAGS	+= -mno-global-merge
+endif
+
 #
 # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
 # later may result in code being generated that handles signed short and signed
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2f1de88651e6..2d20fb2ea664 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,6 +36,13 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
+ifdef CONFIG_CC_IS_CLANG
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
+# source of a reference will be _MergedGlobals and not on of the whitelisted names.
+# See modpost pattern 2
+KBUILD_CFLAGS	+= -mno-global-merge
+endif
+
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)

> > +
> >  #This will adjust *FLAGS accordingly to the platform.
> >  include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
> >  
> > -- 
> > 2.35.1.616.g0bdcbb4464-goog
> > 

-- 
Kees Cook

