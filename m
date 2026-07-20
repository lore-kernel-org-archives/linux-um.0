Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D87C4452D
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4vTZRCmYUoacTgRQeb9iD10u8BLXmQ5njXvIgguyco=; b=Rnv/6/OrBflBYjrDgUrj3XM9jt
	HNIscxzfYnmsgUrhpVQANhHuPcacGyHY78jWmZXxMRRQb4JKOXs/FTGErx2CLXcpe8p346Vooy17Z
	EEddyP3NAfHoqIaxP7QnuRKrLWsn/AXKCE1HgDHUrVEePMu/zTu7C+BwKiCrBh/yCcYH4ahbaCWYA
	++ryFNKy2N9PAUFAhFdw3n335tk/JnuQLBG7TSHtpEb8wFCqTCbZlT+5ZsLaRJwAJss7iXUkTc7NX
	pU3Njwxbwm3k1fK5hNG364voXCKU2IrkuPP9WE4OGZIZsJ00rQDDB3etGYL0FhsyH5g1ZVtnuazm0
	6D0vGxyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltY9-00000007jkz-1iUB;
	Mon, 20 Jul 2026 19:21:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltY7-00000007jkY-3ETM;
	Mon, 20 Jul 2026 19:21:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A5984433B7;
	Mon, 20 Jul 2026 19:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC12B1F000E9;
	Mon, 20 Jul 2026 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784575270;
	bh=y4vTZRCmYUoacTgRQeb9iD10u8BLXmQ5njXvIgguyco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Spav0GWz3rWmeiOvTkSHmoLaFmA0dsmghrTMMUGIy7BsnbqtE0r1vEIJpGCtqeWB+
	 BpTJQ6xzB/KOaDAAkoTPfDvyF002TmAYBtSyKK5uExFq/Cj1mLr43Z33qJ2sRMi9Nf
	 nJuZqLg2J7TvcdvdFpFOL3PuoTONb0yf3DbORivGivTO7zCY0H72Bu+OkktKpqh03L
	 Vksh67h0wy7gmPYEI4mwGb9sleMrzw8Jsb1sLuHLmScVy2tv/f+VR08LYTxzvzqe4C
	 b/ZkM/7+AGeKxhezpkSh009TVoxiBEuZvcET+KD3PE+3fxGAVYAS/3R9Y8DzfgWlkp
	 U2Lg+Wsg/dkOQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
In-Reply-To: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
References: <20260707181957.433213175@kernel.org>
 <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Date: Mon, 20 Jul 2026 21:21:07 +0200
Message-ID: <87wluplb6k.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain
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

Magnus!

On Sun, Jul 19 2026 at 13:25, Magnus Lindholm wrote:
> One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
> that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
> before calling into the generic entry code: syscall_set_return_value() also
> updates r19/a3, which is still syscall argument 4 on the normal entry path.
> Doing that too early broke early userspace mmap() during boot.

Similar to what Peter and me suggested in the related discussion
vs. s390 which has a similar issue, you can just have a dedicated
syscall_return member in your pt_regs struct, which is preset to -ENOSYS
and operate on that. You have an unused padding entry there which means
it won't even change the size.

> Are you planning to send a v2 with the seccomp recheck fix and any other
> review fixups folded in? Is the intention to route this upstream
> during the next merge window?

You were on CC for the V2, no?

The whole pile including Jinjie's seccomp bypass fix is in

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is targeted for the 7.3 merge window.

If you want to base your stuff on that for 7.3, I can add a tag which
makes it immutable so it can be pulled into the alpha tree.

Thanks,

        tglx


