Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36DDEB64D8
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=La5x8IfIe8LjmYhUPzHWEHy+kN+A2LvayR9vB/c47ls=; b=ib2w1auKsOG0ZV
	G4XBFlwABMZm8npGnXb0ZSH3xznVDbmWkGn46RxEj80wnfJnkH22Ds9SH2a6fJuWkO7tWl12sGk98
	CSxEKAH/bz4i16it6VEPAmauHk+yQ5hEsK5535AbusRwYkuCEfAFSBFO/ms4DMnX1wV1A0JSZ7Z7h
	+mhRLHljfXYa3VK3GCwHafeut4FpUO1ZfKARrSbnURLguj3FqrOfPGO/90iXCxE/7N69fhR9xv+s+
	br6i4syIW7FIoGiucj97M9OVFnfcO4zxGYkW32Xv64akNFEU8UNTNk273mOFuJrmwj86U+1P2uMX2
	ac1OE4+c9oddkVcaEFHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9XJf-00CfPN-1O;
	Wed, 14 Jun 2023 20:42:07 +0000
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com ([2a02:2350:5:402::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9XJb-00CfNN-1h
	for linux-um@lists.infradead.org;
	Wed, 14 Jun 2023 20:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=cW4dy2To7/M902URPa1VAjOZaTBlNB+GfxWd9TtkCSE=;
	b=E+yvNIrkyeT6IEUt9sQXovg5SM1XJyIh1I4psC5M3E0rZecTNFqf6dUoJZIzciYDZF0wHtv1CkbtY
	 Ug1uzl6V27VzH/JmBV94T1MdtTmgFg2jzeFq6Mfho6iJGF+23+QBKJ0QDxcICllSjMb+Kt1MW6XBKv
	 PQsAOS9u08oxojjceExcrYB6dEKtgWFOX2UcAeoJzROmdLfweXYrEpnTYdlO2gOY+dDHjQtqVpfKXH
	 yhxY21X3GJ1ZCEp4H8EZ6mPYVhtwndrZHgoJss5Wr0lAHHK6G4CZP3yqRUlLm7GYcjj9weu2d/kNrz
	 fKoNo+NR6+5qOQMLwzz0o0xdvg/UVSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=cW4dy2To7/M902URPa1VAjOZaTBlNB+GfxWd9TtkCSE=;
	b=VXu9k3ldXcowqgW30zeYdluY94r2cP2Z6PZzlWmByvpKOXcQRh1vwTttSWKSGKkWXSw4a8h/rZkbB
	 U3M0jZMAA==
X-HalOne-ID: e3e45d00-0af3-11ee-bc48-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3 (Halon) with ESMTPSA
	id e3e45d00-0af3-11ee-bc48-b90637070a9d;
	Wed, 14 Jun 2023 20:41:52 +0000 (UTC)
Date: Wed, 14 Jun 2023 22:41:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Richard Henderson <richard.henderson@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chris Zankel <chris@zankel.net>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 09/17] sparc/cpu: Switch to arch_cpu_finalize_init()
Message-ID: <20230614204151.GA1492503@ravnborg.org>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.431995857@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230613224545.431995857@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_134204_956780_5FDE4622 
X-CRM114-Status: UNSURE (   9.10  )
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

On Wed, Jun 14, 2023 at 01:39:35AM +0200, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
