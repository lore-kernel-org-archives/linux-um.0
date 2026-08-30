Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D7C61DD9
	for <linux-um@archiver.kernel.org>; Sun, 30 Aug 2026 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTn2PwZa/M8+jVj3fJrDpEEh/COhBy7FRr29V6qoiYI=; b=Lrl3JsqIh7Lwpou9LS9q50cn39
	ncimhKoNcW76A0TlIRZe/V9f9hCLvxTUYk5skydQQ3FBJv8xi5ZFozu2iC0uDbhPoKfn0nEZqJpP0
	TChHAcjKw7WR0JwlbdvrnIWoSG+VS2aCd5AC92D0imlfpGF5M1iCblejMFYwh8AqhuwQXGOYj7P0I
	5AWbs3UCBP35pKYP/LaCds9xn64WvedljnCc8q6ziQ/OkCGTgEfwgGDb2YrRBeAm29y4ImcxYWuYr
	ECXKzjefQygJ11WiBcW2laMfjT/ioJCTY7TJykbnlcgqsKNxVriLUGPIucgvGUvsDS/rP17guxg0C
	3WtT2PJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hpX-00000007spr-2jK7;
	Sun, 30 Aug 2026 15:52:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hpW-00000007spV-1Aty
	for linux-um@lists.infradead.org;
	Sun, 30 Aug 2026 15:52:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 910F7600C8;
	Sun, 30 Aug 2026 15:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBEF1F000E9;
	Sun, 30 Aug 2026 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788105140;
	bh=lTn2PwZa/M8+jVj3fJrDpEEh/COhBy7FRr29V6qoiYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sk65VCN98VsowdHN+8Zoh22imIXgdBaOP7PxtTldPwfbpfAo/y59yZ/4RYrYu4x5w
	 iVHCkW+vNye4ghW0ubslfMd/4D+ggCwHAXfpnXhHS6dcp/KzSXfJAeSTVs/RT32Mj8
	 h3PTGZN1mycvPUnvvKeyFKTgJhoCgNUzKysnH9pKM5K5QNGQcHNVMvJ9RTnNyw71Bc
	 gAtgNERhBYT9wor5+n1FemtO8LmlnFRlH9WsfMY93jhDxcs1RxILx0mezVHQtbIBdZ
	 P1HeqziyyP/feTb6f8Me7R/3YceRW5mAYvK5Jwbz4gvrZaqpF1bYGrJYoIH1YtNnhv
	 dV7Oa369JSrQQ==
From: SJ Park <sj@kernel.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: SJ Park <sj@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Use asm-generic/timex.h over the host architecture one
Date: Sun, 30 Aug 2026 08:52:11 -0700
Message-ID: <20260830155212.97975-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Wed, 19 Aug 2026 09:24:21 +0200 Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:

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

I got the same issue, and confirmed this patch fixes it on my setup.  Thank you
for sharing this patch.

> 
> Fixes: 3ed403bbc967 ("treewide: Remove CLOCK_TICK_RATE")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Tested-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

