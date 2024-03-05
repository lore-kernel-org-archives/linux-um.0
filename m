Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB057C54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUU17H/883Su4y5t0ORguJT8aM0bkdnEyWS9d9zukeE=; b=NoN+CM3gitd0VMIZiIp2ji3eEP
	g6ouDAwwjtfnzihAGKqEod9whsZ31v0JcUcxcXq0WFB9qm//w26OZoLyJmQFMjQN1zrJE9NbNxNhf
	s/um1//cjWj9S+yKHSVNMBu9v83Ccy+kwHsMVpzq779OKx5DlfaH2U8rOIsRRKyHNT/oXLYU8M+RN
	aokTt7NDYb8kX+svo2+V3tbBwPvlFtSgRt+k05N5Vtw8yk9Ntn0U896HrfX59MrgNt+KXhdYYYH38
	BYQoJ1sNPck4z5+add6bB93+jy1WU586Q02JAsz1TizchaSpdmfEw0QpxpW5FnCYRXw6V2KMQ9SLn
	tyNpshuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSWc-0000000DDdA-1sV2;
	Tue, 05 Mar 2024 10:59:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSWI-0000000DDVq-2cIV;
	Tue, 05 Mar 2024 10:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FUU17H/883Su4y5t0ORguJT8aM0bkdnEyWS9d9zukeE=;
	t=1709636378; x=1710845978; b=jIQYco3NVWE1Sy8f0dyfdkvYQwO04N4pnTRj/RpXtYFwhjG
	De3PKlD5kiMmZIMfZBpVhkDWzx8t6Z3732fvvXpn65jqM2APRYdwGsSwREVNOGKUVWCLhUQixqeOU
	FCYt2XKqZ13TkeEwJynJbo+y4aVLFoiYTc0MDbAtZ9hQFIhm49NdkzgplekiarChLZOY6DBqYnZxK
	gqsNLycd8UzpfPCBULilrqedLYGPA93N02bqcrMJfqQeAHZE4xKX72crmI5mid29uO98sKnghib2h
	DKkWzL7GeKitpEP3EvFlOwhazfo1I4UpZIcz8v6PJRUxRfuMO92hHDF8Cn3Yzcog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhSVn-00000002j5H-3fnE;
	Tue, 05 Mar 2024 11:59:08 +0100
Message-ID: <65f6e65e90ca5f134ef1a238a38ab02a6c1c3360.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all
 architectures
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook
 <keescook@chromium.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Andy Lutomirski <luto@kernel.org>, Jan
 Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-um@lists.infradead.org
Date: Tue, 05 Mar 2024 11:59:05 +0100
In-Reply-To: <20240226161414.2316610-4-arnd@kernel.org>
References: <20240226161414.2316610-1-arnd@kernel.org>
	 <20240226161414.2316610-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_025938_735637_26B203F0 
X-CRM114-Status: UNSURE (   6.40  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 2024-02-26 at 17:14 +0100, Arnd Bergmann wrote:
>=20
>  arch/um/Kconfig                    | 1 +
>  arch/um/include/asm/page.h         | 2 +-


LGTM, thanks.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

