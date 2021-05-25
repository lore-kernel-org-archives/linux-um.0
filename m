Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXsi-005bXE-72
 for linux-um@lists.infradead.org; Tue, 25 May 2021 14:18:06 +0000
Received: by mail-qk1-f199.google.com with SMTP id
 b203-20020a3767d40000b02903a6207bfef5so14030663qkc.1
 for <linux-um@lists.infradead.org>; Tue, 25 May 2021 07:18:00 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
References: <20210524224150.8009-1-rdunlap@infradead.org>
Message-ID: <7e4cc7da-c185-a35f-9047-615ffb222640@redhat.com>
Date: Tue, 25 May 2021 10:17:57 -0400
MIME-Version: 1.0
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Julian Braha <julianbraha@gmail.com>, linux-arch@vger.kernel.org

On 5/24/21 6:41 PM, Randy Dunlap wrote:
> Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
> LOCKDEP.
> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
> of the arch-es that LOCKDEP depends on.
>
> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
> intend to have LOCKDEP support, replace the awkward list of
> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>
> But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
> which is already a dependency here, so LOCKDEP_SUPPORT is redundant
> and not needed.
> That leaves the FRAME_POINTER dependency, but it is part of an
> expression like this:
> 	depends on (A && B) && (FRAME_POINTER || B')
> where B' is a dependency of B so if B is true then B' is true
> and the value of FRAME_POINTER does not matter.
> Thus we can also delete the FRAME_POINTER dependency.
>
> Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)
>
> WARNING: unmet direct dependencies detected for LOCKDEP
>    Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>    Selected by [y]:
>    - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>    - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>    - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>
> Link to v1: https://lore.kernel.org/lkml/20210517034430.9569-1-rdunlap@infradead.org/
>
> Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
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
> Cc: Julian Braha <julianbraha@gmail.com>
> Cc: linux-arch@vger.kernel.org
> ---
> @Julian: please take a look. I'm a little concerned about the
>    FRAME_POINTER dependency going away when our 2 patches are combined.
>
> v2: drop depends on LOCKDEP_SUPPORT for LOCKDEP; the use of
>      LOCK_DEBUGGING_SUPPORT already covers that dependency;
>      drop FRAME_POINTER dependency (thanks to Waiman Long
>      for both of these suggestions)
> v2: add CC: to linux-arch
>
>   lib/Kconfig.debug |    1 -
>   1 file changed, 1 deletion(-)
>
> --- linux-next-20210524.orig/lib/Kconfig.debug
> +++ linux-next-20210524/lib/Kconfig.debug
> @@ -1383,7 +1383,6 @@ config LOCKDEP
>   	bool
>   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>   	select STACKTRACE
> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>   	select KALLSYMS
>   	select KALLSYMS_ALL
>   
>
Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

