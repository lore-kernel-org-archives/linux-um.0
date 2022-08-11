Return-Path: <linux-sh-owner@vger.kernel.org>
Date: Thu, 11 Aug 2022 08:29:39 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] treewide: defconfig: address renamed CONFIG_DEBUG_INFO=y
Message-ID: <202208110829.F82D003490@keescook>
References: <20220811114609.2097335-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811114609.2097335-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Aug 11, 2022 at 01:44:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_DEBUG_INFO is now implicitly selected if one picks one of the
> explicit options that could be DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> DEBUG_INFO_DWARF4, DEBUG_INFO_DWARF5.
> 
> This was actually not what I had in mind when I suggested making
> it a 'choice' statement, but it's too late to change again now,
> and the Kconfig logic is more sensible in the new form.
> 
> Change any defconfig file that had CONFIG_DEBUG_INFO enabled
> but did not pick DWARF4 or DWARF5 explicitly to now pick the toolchain
> default.
> 
> Fixes: f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from a choice")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

