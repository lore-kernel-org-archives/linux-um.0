Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liXP8-00DXID-SP
 for linux-um@lists.infradead.org; Mon, 17 May 2021 07:11:08 +0000
Received: by mail-ed1-x529.google.com with SMTP id h16so5562579edr.6
 for <linux-um@lists.infradead.org>; Mon, 17 May 2021 00:11:05 -0700 (PDT)
Date: Mon, 17 May 2021 09:11:02 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
Message-ID: <YKIXBpxyvhzdb1uv@gmail.com>
References: <20210517034430.9569-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517034430.9569-1-rdunlap@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
> of the arch-es that LOCKDEP depends on.
> 
> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
> intend to have LOCKDEP support, replace the awkward list of
> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
> 
> Fixes this kconfig warning: (for both um and xtensa)
> 
> WARNING: unmet direct dependencies detected for LOCKDEP
>   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>   Selected by [y]:
>   - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> ---
>  lib/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210514.orig/lib/Kconfig.debug
> +++ linux-next-20210514/lib/Kconfig.debug
> @@ -1383,7 +1383,7 @@ config LOCKDEP
>  	bool
>  	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>  	select STACKTRACE
> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
> +	depends on FRAME_POINTER || LOCKDEP_SUPPORT

Ok - the FRAME_POINTER bit is weird. Are there any architectures that have 
FRAME_POINTER defined but no LOCKDEP_SUPPORT?

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

