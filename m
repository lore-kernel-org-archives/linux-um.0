Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ADBEB64DC
	for <linux-um@archiver.kernel.org>; Wed, 28 Jun 2023 03:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hjFD8sv/RJgQIRZ5cVME6MHGAoDwFrn1Ua0c2rVI+hU=; b=V0s3k63DWDAbiS
	+/wFPQj9Wek7RVEngYMp8CDT0Tnh9nWQrkfqaxJq7z5AOfDy02xBsx1UtfhyqlKPdFl+NttUhTDcB
	2juCnod/Rl3JB9PiFmJXM1LRoJsy+PizRzW/qQTaBunOPFd0MmFv1IfYHwAUU8/OaIHpcsz0lyJxU
	0iwr1b8b/10hmib8sa6cCYFCtfPfI/ZzdOS63i1g66tv4ojcnaKgkP/BhfR5lepg8F5fgBcoQ9PFJ
	aUg2Ylb1tZHf8F3EnSpdQwMQOW4Hsva4Q0utDuSWhKOvl8499J3nOy/bmsqseqimRnXTASG1RRTRT
	WFeH7NmL/P2TNIhXFB4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEM1V-00Ei8k-2A;
	Wed, 28 Jun 2023 03:39:17 +0000
Received: from a3.inai.de ([2a01:4f8:10b:45d8::f5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEM1R-00Ei6P-19;
	Wed, 28 Jun 2023 03:39:15 +0000
Received: by a3.inai.de (Postfix, from userid 25121)
	id 3EAFB5880BBDB; Wed, 28 Jun 2023 05:38:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 3CBF860DE22B8;
	Wed, 28 Jun 2023 05:38:57 +0200 (CEST)
Date: Wed, 28 Jun 2023 05:38:57 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Thomas Gleixner <tglx@linutronix.de>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Nikolay Borisov <nik.borisov@suse.com>, 
    "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
    WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
    Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
    sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>, 
    Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 00/17] init, treewide, x86: Cleanup check_bugs() and
 start sanitizing the x86 boot process
In-Reply-To: <20230613223827.532680283@linutronix.de>
Message-ID: <8qpp1r32-pr73-8477-nso-327o845o1149@vanv.qr>
References: <20230613223827.532680283@linutronix.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_203913_584268_276CAE67 
X-CRM114-Status: UNSURE (   7.35  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wednesday 2023-06-14 01:39, Thomas Gleixner wrote:

>Hi!
>
>My team and myself are working on sanitizing the x86 boot process,
>especially the complete horror show of CPUID evaluation, which is
>constructed with hay-wire circuits, duct tape and superglue.

What's with Intel and its glue analogies? Not to mention it stuck very 
well, if I may say so myself (not to mention the glue in the co 
struction of the 12th Intel series).

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
