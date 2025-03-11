Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641EC28B2F
	for <linux-um@archiver.kernel.org>; Tue, 11 Mar 2025 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjtbj0rMoRhWzV3nxSJsuSOSdwzNUEUPeZ0N5AhKsuE=; b=bs7KA+nzQp6Wa41sQ5bIbPufsn
	uUfBo0Dg5AW3oT4X/jeqYA4rWYrP5JJRbYbjWcjfgoGAQUPfFMPLsoWFi6m9U9Z4oA6ROmxyJMYq/
	/ZrIeyTZOAOEfuvtOyQ9F49YarHn2zahs9vK4UUD1aT4lU8Zi12QTPbr+JHpbkm9vUSH8AGbIoM1H
	Q8RU8UmeFurGHGxXFqEbnP9eTUDYe2m0aohSye4EKE+dm+BdnxWMxf8F2THTCuIYGM2ecWwrhU4XA
	4W2Ulg/p211GbJKuL+CWsU8SsORGqk6QTmi4wtOY0C3zbShxXNCcxxjqB/f1X0tu/y8O8snqcNMEu
	84KnCuIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts6ov-00000006zT3-1Pvh;
	Tue, 11 Mar 2025 21:07:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts6or-00000006zRV-2Jli;
	Tue, 11 Mar 2025 21:07:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DFAB5C06AD;
	Tue, 11 Mar 2025 21:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BDBC4CEE9;
	Tue, 11 Mar 2025 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741727240;
	bh=rNimSVN80xWe5rcUWVjkmfCgcoptPPb9Jv9OZmpPkd4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=C1iHqPEKFmOZ1AdRri3tQAqNRCUTPzRJDLMlo7w9miEeyKlINu4yaWAdRhzIs0paH
	 jfkQRnK0XKmpkNOb3HtMEZGNKykGUrnuj1eWXqoXCuk4rS12Ikm530MvS19u7Mf4J3
	 tH/UJQzFzlpWZeIQ8GU3qF5sOrZxvuNLkXsoHttkETnhl82ybMrj85LRdzmLv+hBla
	 wPX3Fb5aCd0lbfNzAcpKqyB8kieIZqzft75UbkCyh4kRvACkkIIDZ2qg0qRSwpfeTU
	 KbinhUeYSjsKqONFQqPFUHd8wwI3NPOSMI/Iwxdn5G8aIP9ZQgz2eFjKKr2GfyLFcr
	 AI9TcpmJNf73w==
Date: Tue, 11 Mar 2025 23:06:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z9Cl8JKkRGhaRrgM@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_140721_677285_107E37E9 
X-CRM114-Status: GOOD (  16.60  )
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

Hi Mark,

On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > high_memory defines upper bound on the directly mapped memory.
> > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > high memory and by the end of memory otherwise.
> > 
> > All this is known to generic memory management initialization code that
> > can set high_memory while initializing core mm structures.
> > 
> > Remove per-architecture calculation of high_memory and add a generic
> > version to free_area_init().
> 
> This patch appears to be causing breakage on a number of 32 bit arm
> platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> die on boot with no output, a bisect with qemu points at this commit and
> those for physical platforms appear to be converging on the same place.

Can you share how this can be reproduced with qemu?

-- 
Sincerely yours,
Mike.

