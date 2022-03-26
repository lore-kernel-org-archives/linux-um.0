Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYCaF-004ooP-88
 for linux-um@lists.infradead.org; Sat, 26 Mar 2022 20:00:24 +0000
Date: Sat, 26 Mar 2022 13:00:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] um: Fix filtering '-mno-global-merge'
Message-ID: <Yj9wyNwZWkilNbJM@dev-arch.thelio-3990X>
References: <20220322173547.677760-1-nathan@kernel.org>
 <CAK7LNAT8TcDy=iKaWZ7_+MbT84vOVEBzHxJY8Bx54Ju5fur8-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNAT8TcDy=iKaWZ7_+MbT84vOVEBzHxJY8Bx54Ju5fur8-w@mail.gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev

On Sat, Mar 26, 2022 at 12:29:55PM +0900, Masahiro Yamada wrote:
> On Wed, Mar 23, 2022 at 2:39 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When booting a clang compiled UML kernel, the kernel panics when trying
> > to run init:
> >
> >   wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
> >   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >
> > After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
> > in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
> > variable ("VAR =") then being switched to a simple ("VAR :=") variable.
> > For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
> > '-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
> > impact code generation.
> >
> > Rework the filtering to use filter-out instead of patsubst, which allows
> > all the patterns that USER_CFLAGS cares about to be excluded in one
> > command and ensures all flags from KBUILD_CFLAGS are transferred over to
> > USER_CFLAGS properly, which resolves the boot issue noted above.
> >
> > Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> 
> 
> Can we remove -mno-global-merge entirely?
> 
> 
> 61163efae02040f66a95 was a very old commit,
> without enough explanation.
> 
> Shall we remove  -mno-global-merge, and do compile-tests.
> If we are hit by problems for arm/arm64, we can re-add it.

Yes, I think that was the conversation that we had on the commit that
this fixes:

https://lore.kernel.org/r/YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X/

I can test that on my Raspberry Pi 3 and 4 on Monday, although I would
like for this patch to be picked up in the meantime so that it is
possible to test UML on -next with clang. We can remove
-mno-global-merge in a follow up change, if you do not have any
objections?

Cheers,
Nathano

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

