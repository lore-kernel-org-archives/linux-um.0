Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP5Xh-00Adgy-Vz
	for linux-um@lists.infradead.org; Fri, 19 Aug 2022 17:12:23 +0000
Date: Fri, 19 Aug 2022 19:11:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] Kconfig: eradicate CC_HAS_ASM_GOTO
Message-ID: <Yv/EWqYy0HzrpO2u@zn.tnic>
References: <20220819170053.2686006-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220819170053.2686006-1-ndesaulniers@google.com>
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
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>

On Fri, Aug 19, 2022 at 10:00:53AM -0700, Nick Desaulniers wrote:
> GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
> The minimum supported versions of these tools for the build according to
> Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.
> 
> Remove the feature detection script, Kconfig option, and clean up some
> fallback code that is no longer supported.
> 
> The removed script was also testing for a GCC specific bug that was
> fixed in the 4.7 release.
> 
> The script was also not portable; users of Dash shell reported errors
> when it was invoked.
> 
> Link: https://lore.kernel.org/lkml/CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com/
> Link: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Documentation/kbuild/kconfig-language.rst |  4 ++--
>  arch/Kconfig                              |  3 +--
>  arch/um/include/asm/cpufeature.h          |  4 ++--
>  arch/x86/Makefile                         |  4 ----
>  arch/x86/include/asm/cpufeature.h         |  4 ++--
>  arch/x86/include/asm/rmwcc.h              | 19 +------------------
>  arch/x86/kvm/emulate.c                    |  2 +-
>  init/Kconfig                              |  4 ----
>  scripts/gcc-goto.sh                       | 22 ----------------------
>  tools/arch/x86/include/asm/rmwcc.h        | 21 ---------------------
>  10 files changed, 9 insertions(+), 78 deletions(-)
>  delete mode 100755 scripts/gcc-goto.sh

Nice and good riddance.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

