Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31BCC5DF87
	for <linux-um@archiver.kernel.org>; Fri, 21 Aug 2026 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sW3Y0Mlp0FmxFeafUP6s4RLG2Q8w7+DGoCUaCKNSimY=; b=wn0h8ZtsMEGab1DImAic63pj2n
	v3mNNNnWzo4sW9mPfUKhb+RnDhBTUyCKPhMThlOGUeWSLmQ2KlDTDChXxBrzK6rqudEDf2Pag2pbJ
	Yno58+0W2ppXJzAcStOWLtg4IyDw0b2spZuzCj4BUHDvx7o5kY6eTKLupDkgZ56M1egnUBo04y8PN
	VChZboeu7+oaqcGm/DZzAX+HKvPoHk2+fnzHGalZ4lcVKck3xhQqGEXsyCoyjb+Ef5LBnp+7QVbvF
	Zl6aWI6Vftb7VwXmAReWmGr567a1zB1jWKmV2yXKFIbfRW1xX2Yjficoaj/eSyvcFgR07nVhKOjoV
	vsTGtHog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKWk-0000000CnEC-0RGd;
	Fri, 21 Aug 2026 08:23:02 +0000
Received: from sphereful.davidgow.net ([203.29.242.92])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKWh-0000000CnCm-44wh
	for linux-um@lists.infradead.org;
	Fri, 21 Aug 2026 08:23:01 +0000
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 043B51EAA4A; Fri, 21 Aug 2026 16:22:44 +0800 (AWST)
Received: from [IPV6:2001:8003:8802:7000::9c4] (unknown [IPv6:2001:8003:8802:7000::9c4])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9234D1EAA43;
	Fri, 21 Aug 2026 16:22:41 +0800 (AWST)
Message-ID: <55e7df51-9508-4b70-8aad-f00191a63294@davidgow.net>
Date: Fri, 21 Aug 2026 16:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Use asm-generic/timex.h over the host architecture
 one
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_012300_237678_B2FE8049 
X-CRM114-Status: GOOD (  19.69  )
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

Le 19/08/2026 à 3:24 PM, Thomas Weißschuh a écrit :
> The removal of the architecture-specific asm/timex.h was meant to fall
> back to asm-generic/timex.h. However on UML, the host architecture
> headers are earlier on the include path and therefore asm/timex.h from
> the host architecture is used.
> On x86 that header in turn requires the generation of cpufeaturemasks.h,
> which is not set up for UML and the build fails.
> 
> In file included from ../arch/x86/include/asm/tsc.h:9,
>                  from ../arch/x86/include/asm/timex.h:6,
>                  from ../include/linux/timex.h:67,
>                  from ../include/linux/time32.h:13,
>                  from ../include/linux/time.h:60,
>                  from ../include/linux/jiffies.h:10,
>                  from ../include/linux/ktime.h:25,
>                  from ../include/linux/timer.h:6,
>                  from ../include/linux/uprobes.h:18,
>                  from ../include/linux/mm_types.h:16,
>                  from ../include/linux/mmzone.h:22,
>                  from ../include/linux/gfp.h:7,
>                  from ../include/linux/slab.h:17,
>                  from ../include/linux/crypto.h:18,
>                  from ../arch/um/kernel/asm-offsets.c:6:
> arch/x86/include/asm/tsc.h: In function ‘get_cycles’:
> arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration of function ‘DISABLED_MASK_BIT_SET’ [-Wimplicit-function-declaration]
>    52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
>       |                                       ^~~~~~~~~~~~~~~~~~~~~
> arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
>    79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
>       |              ^~~~~~~~~~~~~~~~~~~
> arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration of function ‘_static_cpu_has’ [-Wimplicit-function-declaration]
>   115 |                 _static_cpu_has(bit)                            \
>       |                 ^~~~~~~~~~~~~~~
> arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
>    52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
>       |                                                                        ^~~~~~~~~~~~~~~
> arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
>    79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
>       |              ^~~~~~~~~~~~~~~~~~~
> arch/um/include/asm/cpufeature.h:115:17: note: ‘_static_cpu_has’ is a function-like macro and might be used incorrectly
> arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
>    52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
>       |                                                                        ^~~~~~~~~~~~~~~
> arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
>    79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
>       |              ^~~~~~~~~~~~~~~~~~~
> 
> The x86-specific timex.h also doesn't make sense on UML in general.
> 
> Reintroduce the UML-specific asm/timex.h and add a comment to document
> its necessity.
> 
> Fixes: 3ed403bbc967 ("treewide: Remove CLOCK_TICK_RATE")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---

Thanks: I just hit this, and came up with the identical fix. Can confirm
it works again across both 32- and 64-bit UML.

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>  arch/um/include/asm/timex.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/um/include/asm/timex.h b/arch/um/include/asm/timex.h
> new file mode 100644
> index 000000000000..dfb4f460fb87
> --- /dev/null
> +++ b/arch/um/include/asm/timex.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_TIMEX_H
> +#define __UM_TIMEX_H
> +
> +/* Do not fall back to the host architecture header. */
> +#include <asm-generic/timex.h>
> +
> +#endif
> 
> ---
> base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
> change-id: 20260819-uml-timex-fix-fccb27f9ca51
> 
> Best regards,
> --  
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> 


