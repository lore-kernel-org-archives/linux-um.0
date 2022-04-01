Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naGxZ-005i9L-GO
 for linux-um@lists.infradead.org; Fri, 01 Apr 2022 13:05:03 +0000
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 231D4Tsd023606
 for <linux-um@lists.infradead.org>; Fri, 1 Apr 2022 22:04:29 +0900
Received: by mail-pj1-f44.google.com with SMTP id
 g9-20020a17090ace8900b001c7cce3c0aeso5285859pju.2
 for <linux-um@lists.infradead.org>; Fri, 01 Apr 2022 06:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-1-nathan@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 1 Apr 2022 22:03:41 +0900
Message-ID: <CAK7LNAS6C6Uj9cCQ0o=bYF1F-EVD=VgdR8YYx-1PJc9toX_HZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove '-mno-global-merge' from KBUILD_CFLAGS
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev

On Thu, Mar 31, 2022 at 8:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> As discussed at [1] and [2], this series removes '-mno-global-merge'
> from KBUILD_CFLAGS for clang, as it causes warnings for UML, and it
> no longer appears to be necessary, as I do not see any modpost warnings
> with LLVM 11 through 15 with several different ARCH=arm and ARCH=arm64
> configurations.
>
> [1] is currently in the UML tree, destined for 5.18, but it is buggy, as
> I note in [2]. This series is an alternative to [2], which has not been
> picked up yet, so it is based on the current UML tree. If [2] is picked
> up, I can rework the first patch to remove the '-mno-global-merge'
> filtering from arch/um/Makefile; otherwise, this should be picked up in
> place of [2].
>
> I intentionally kept the first patch vague around what fixed the modpost
> warnings, as I am not too sure. [3] seems somewhat likely, but I don't
> think that will revert cleanly on main to test. I think the testing is
> enough to show that the original issue is resolved but I do note that we
> can add this flag back in the architecture specific Makefiles if needed.
>
> Please review and ack as necessary.


Both applied to linux-kbuild/fixes.




> [1]: https://lore.kernel.org/r/20220303090643.241747-1-davidgow@google.com/
> [2]: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
> [3]: https://github.com/llvm/llvm-project/commit/863bfdbfb446adaef767ff514d1f2ffb5d489562
>
> Nathan Chancellor (2):
>   kbuild: Remove '-mno-global-merge'
>   Revert "um: clang: Strip out -mno-global-merge from USER_CFLAGS"
>
>  Makefile         | 4 ----
>  arch/um/Makefile | 4 ----
>  2 files changed, 8 deletions(-)
>
>
> base-commit: 82017457957a550d7d00dde419435dd74a890887
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

