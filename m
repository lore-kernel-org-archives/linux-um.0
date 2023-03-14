Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9068C6FD1D
	for <linux-um@archiver.kernel.org>; Tue, 14 Mar 2023 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BfeXhK+GOrwmA74HkdxLTs85bF9xHMDCcMXhqWjTujc=; b=MBNxHU6nN9bXxm
	TTb2kAY9sgoBPTtIeqAi1eYwCnJ1AaKZOFIhyF9frfAioX7lf80vtKvYlLu36TBsb23oj95BWk2tq
	4dLpOs7iopdAnVrKy+/vmyt95Wt1WoZtxwYwYedkb5uAqwtaPm/dkV97DyvtvtBJnXKxzv9uPjyDP
	C+MdcZNXGUK8pzdY6obYzvX8jJPwf/4l4VWzT/spEtDFr74FlW/2iM8KBFG2mGwV+GjpSXqJIzoKJ
	Qu1He6zZG/bAtOswoWvg8RKLxln8m6fRNYRUygrMGw+KcqTHlWnHZexqS0BGRmNJPfkFX86iPOB8d
	CAP6l/8PijYxUEgzpnLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc3xE-00A8au-2n;
	Tue, 14 Mar 2023 12:40:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc3xB-00A8ZM-0f;
	Tue, 14 Mar 2023 12:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pOg2+UYpTygnBlX1RyGCO9nWu9fsmXuoawMaiLoDXLo=;
	t=1678797630; x=1680007230; b=FRHH+0L3EXTxJU4jJhSPKTnXbRJt5P7rpPdWencY9wi5jed
	vHkr7Y9FFmgU1uyivsDK8wmlmDSsu7iY/lCpdha4lsJTuzoXxylCjJK42SZC4CsP9VS6wJl8pQ9Pp
	/P2DzmVC3D1cKGR/If9nOnMl/fkvJgv83mlNXhduhXPui1neupSdZn/ztiCYxM76/93UkKNOxmLBz
	8czwPjqCEZST6ChMNelpoBGIKAEdPaqCgCchEcfrh4zmQQjAQATZXp2icABF55Nn7Hr1FzqBdHOKq
	dIotZMWgdQ8XY9mHJm6cia/vtCduHNg+PLnLc6dzUEtIJFUlIOkVmNS9xFABIPig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pc3uU-003AIF-1Y;
	Tue, 14 Mar 2023 13:37:46 +0100
Message-ID: <21a828bae06b97b8ca806a6b76d867902b1e0e1f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
From: Johannes Berg <johannes@sipsolutions.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
  Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal
 Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>,  Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller"
 <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Alan Stern <stern@rowland.harvard.edu>, "Rafael J.
 Wysocki" <rafael@kernel.org>,  linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,  linux-pci@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>,  linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,  linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,  linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-um@lists.infradead.org
Date: Tue, 14 Mar 2023 13:37:43 +0100
In-Reply-To: <20230314121216.413434-2-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
	 <20230314121216.413434-2-schnelle@linux.ibm.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_054033_275707_5EC5F11B 
X-CRM114-Status: GOOD (  11.61  )
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

On Tue, 2023-03-14 at 13:11 +0100, Niklas Schnelle wrote:
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -56,6 +56,7 @@ config NO_IOPORT_MAP
>  
>  config ISA
>  	bool
> +	depends on HAS_IOPORT
> 

config ISA here is already unselectable, and nothing ever does "select
ISA" (only in some other architectures), so is there much point in this?

I'm not even sure why this exists at all.

But anyway, adding a dependency to a always-false symbol doesn't make it
less always-false :-)

Acked-by: Johannes Berg <johannes@sipsolutions.net> # for ARCH=um


Certainly will be nice to get rid of this cruft for architectures that
don't have it.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
