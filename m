Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFBDC5DF81
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjtlSqjePQMRj4TeKuxAz2/6GIxKPHosReR3jogYEN8=; b=D1y4fPzlemdRF7qZrHj0eb/OwS
	AstYef387WNiMh2JCr+IfI8hxS75kgqZLt+A5X4fg76kQuvzE8c2mBcvBntOEoNwmXV3dJDJbS7/b
	55++XhbExgfzp4wnKpzK3zMEdKSeVWA2OnWJR39CzJZbe4IsnYGEjzZCS6ux+yvqJNJj4X3S8zTG2
	UFeZuKSZ5kVSzr6GlAKcZv/K0RvSNoqqQMSc68J3KQU37K18aarK5w9EmnVogIa0UweysryPBtiPb
	Fq8HUeSosHNgbnFookHLbokyHvwbcjS8ec0IWbdSoEkmPUUxYAsJcsKupT48ZZLul/I9oNDZhgPwy
	zq/+K6fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyPDK-0000000G6CZ-2hw0;
	Mon, 24 Aug 2026 07:35:26 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyPDF-0000000G6Ba-0nO7
	for linux-um@lists.infradead.org;
	Mon, 24 Aug 2026 07:35:26 +0000
Date: Mon, 24 Aug 2026 09:35:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787556916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjtlSqjePQMRj4TeKuxAz2/6GIxKPHosReR3jogYEN8=;
	b=cKs2Ds6WpfFedivT9Ks+wifTn+qv/fjGMwcEHeCJcy7mIiX7PWcFz9ISkFSh3/jsx9IR5/
	hqoplsl0zRUT8DYgnnnL9X3Rk95EASpbKhdCr59f8CLWLFN3cbe3yPnX76QC6mBV9BvQsm
	J7IkDVmLJVYklgBk80UYU3x+8O/u0wePXCPFMfSi3ErZj6c8CtK519g/EpMMou/2+Ncpd/
	YlPnKNM5wvKRHarWAaYi8LlUdT5E9ok57OLuYJ3G7fYhhLJvD+Dv18oTao5nTqe/csfT7v
	zjM4WoOf4jjcGGMnIdaZKGrCYpvkMjmnG8bKM+3cvLnGtpiR0tly4Fby/Uu0kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787556916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjtlSqjePQMRj4TeKuxAz2/6GIxKPHosReR3jogYEN8=;
	b=LdIW45LC5D+mazBSSRz0Kv6wwOPl3nZ0f9KlU/KSOjqOM1orkgmMUSA8aSycxK/5vMu7zY
	9L2kPoyQgshnWpDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Fabian Franz <fabian@isomorphic-ai.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Nikolay Borisov <nik.borisov@suse.com>, "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>, 
	Claude Fable 5 <noreply@anthropic.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH REGRESSION] um: Fix cpu_feature_enabled() build breakage
Message-ID: <20260824092300-3e9a9d58-b273-421b-a4bf-5609ccb9ab49@linutronix.de>
References: <20260823201521.2576344-1-fabian@isomorphic-ai.com>
 <a02b160a-874f-491c-987b-4d7eb0d35a9f@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a02b160a-874f-491c-987b-4d7eb0d35a9f@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_003521_390927_5A5F95B9 
X-CRM114-Status: GOOD (  38.65  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Aug 24, 2026 at 08:54:19AM +0200, Thorsten Leemhuis wrote:
> On 8/23/26 22:14, Fabian Franz wrote:
> > Since commit 3ed403bbc967 ("treewide: Remove CLOCK_TICK_RATE") deleted
> > the (otherwise empty) arch/um/include/asm/timex.h, UML builds resolve
> > <asm/timex.h> to arch/x86/include/asm/timex.h via the HEADER_ARCH
> > include path.  That pulls <asm/tsc.h>, whose get_cycles() uses
> > cpu_feature_enabled(), into virtually every translation unit, starting
> > with asm-offsets.c.  This newly expands parts of UML's copy of
> > <asm/cpufeature.h> that no longer compile, and "make ARCH=um" now dies
> > in prepare0:
> > 
> >   arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration
> >     of function 'DISABLED_MASK_BIT_SET'
> >   arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration
> >     of function '_static_cpu_has'; did you mean '__static_cpu_has'?
> 
> To ensure everyone is aware of it: Thomas Weißschuh (now CCed) a few
> days ago already submitted a fix for a problem that to my untrained eyes
> looks like the same problem (do not hesitate to correct me!):

Thanks for this pointer.

> https://lore.kernel.org/all/20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de/

Indeed, both our fixes seem to be for the same breakage.

Personally I prefer my patch, as it reverts the specific change which
introduced the breakage into the tree. Franz' change does not look incorrect
but is a larger change and should go through a regular release cycle.

> Ciao, Thorsten
> > Two independent breakages meet here:
> > 
> >  1. cpu_feature_enabled() and this_cpu_has() still test
> >     DISABLED_MASK_BIT_SET()/REQUIRED_MASK_BIT_SET().  Those used to
> >     come from <asm/disabled-features.h>/<asm/required-features.h> via
> >     <asm/cpufeatures.h>, but since commit 8f97566c8a81
> >     ("x86/cpufeatures: Remove {disabled,required}-features.h") they
> >     live in the generated <asm/cpufeaturemasks.h>, which only the
> >     arch/x86 archprepare rule generates.  ARCH=um never generates nor
> >     includes it, so the references have been dangling since then.
> > 
> >  2. The _static_cpu_has() macro expands to itself.  Commit
> >     3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()") renamed
> >     the inline function _static_cpu_has() -> __static_cpu_has() and
> >     the macro static_cpu_has() -> _static_cpu_has(), but in the UML
> >     header the macro's out-of-line branch kept calling
> >     _static_cpu_has(), which now names the macro itself and is left
> >     unexpanded by the preprocessor.
> > 
> > Fix the macro to call __static_cpu_has(), as the x86 header does, and
> > drop the mask based short-circuits from cpu_feature_enabled() and
> > this_cpu_has().  UML has no compile-time feature masking to express:
> > capabilities are copied from the host's CPUID at boot, see commit
> > d8fb32f4790f ("um: Add support for host CPU flags and alignment"),
> > and generating cpufeaturemasks.h from a UML .config would wrongly
> > mark features disabled simply because the gating CONFIG_X86_* symbols
> > do not exist for ARCH=um.
> > 
> > Fixes: 3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()")
> > Fixes: 8f97566c8a81 ("x86/cpufeatures: Remove {disabled,required}-features.h")
> > Signed-off-by: Fabian Franz <fabian@isomorphic-ai.com>
> > Assisted-By: Claude Fable 5 <noreply@anthropic.com>
> > ---
> >  arch/um/include/asm/cpufeature.h | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
> > index f7770083c0a4..20b2c7ead62e 100644
> > --- a/arch/um/include/asm/cpufeature.h
> > +++ b/arch/um/include/asm/cpufeature.h
> > @@ -37,8 +37,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
> >  	 test_cpu_cap(c, bit)
> >  
> >  #define this_cpu_has(bit)						\
> > -	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
> > -	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
> > +	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability)
> >  
> >  /*
> >   * This macro is for detection of features which need kernel
> > @@ -48,8 +47,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
> >   * supporting a possible guest feature where host support for it
> >   * is not relevant.
> >   */
> > -#define cpu_feature_enabled(bit)	\
> > -	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
> > +#define cpu_feature_enabled(bit)	_static_cpu_has(bit)
> >  
> >  #define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
> >  
> > @@ -112,7 +110,7 @@ static __always_inline bool __static_cpu_has(u16 bit)
> >  (								\
> >  	__builtin_constant_p(boot_cpu_has(bit)) ?		\
> >  		boot_cpu_has(bit) :				\
> > -		_static_cpu_has(bit)				\
> > +		__static_cpu_has(bit)				\
> >  )
> >  
> >  #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
> >
> > -- 
> > 2.43.0
> > 
> > Every ARCH=um build has failed since the 7.3 merge window.
> > 
> > #regzbot introduced: 3ed403bbc967
> > 
> > Steps to reproduce on master:
> > 
> > make ARCH=um O=/tmp/um-build defconfig
> > make ARCH=um O=/tmp/um-build -j$(nproc)
> > 
> > fails with:
> > 
> > /home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h: In function ‘get_cycles’:
> > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration of function ‘DISABLED_MASK_BIT_SET’ [-Werror=implicit-function-declaration]
> >    52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
> >       |                                       ^~~~~~~~~~~~~~~~~~~~~
> > /home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
> >    79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
> >       |              ^~~~~~~~~~~~~~~~~~~
> > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration of function ‘_static_cpu_has’; did you mean ‘__static_cpu_has’? [-Werror=implicit-function-declaration]
> >   115 |                 _static_cpu_has(bit)                            \
> >       |                 ^~~~~~~~~~~~~~~
> > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
> >    52 | builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
> >       |                                                             ^~~~~~~~~~~~~~~
> > 
> > If this is known please disregard. I am also not 100% sure if this is the right fix or if it's better to bring back the macros to um.
> > 
> > In any case it would be good for um to build again on the master branch out of the box.


