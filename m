Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17A1C28B26
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+WgGZZwuy6dcxKu6tQ5X7wRFZYCKjuZRXphT7j3y4s=; b=4/wr+B+0MKdw6K+6Jxkzw5yGtB
	KNA5sMF1wUNtQoNg6onSkNHQ9vHogIhEaRo70YuZYVY0PwqbN9npLatDcYmYUaOh0rZjPrOXEpI+E
	85ZWTle2wfmh7B+NvRGmQHNVHhThHzkjQJ2jZc/SXcjdoXIDgWgx/tSQ0khCOWNwP8dBRW29zlOGv
	YxcD74Wx1yS8uqM8EGlAeWVZcnGxbT8vEFLb4uslMzd/K2VyMD4LJX+8w/GmLueJmijA6utsGu8tP
	H5rKqUuC/MxJMTdIbIH4QuR7Oua2YxyXTG1qjPs189ERqglQm4492a2c7NRTA7dmlpbfkbLeEPC7O
	r5TznvxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqIdX-0000000CFpA-1Q2a;
	Thu, 06 Mar 2025 21:20:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqIdS-0000000CFnM-3Jez;
	Thu, 06 Mar 2025 21:20:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E60865C57C8;
	Thu,  6 Mar 2025 21:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9335C4CEE0;
	Thu,  6 Mar 2025 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741296005;
	bh=cZDw6Poc4BDrQ+UyFQkoa8sDIiciZub+M7TYHo89aq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCD2eitPTHFzv+QGanXjZD4bENnmRFCyuGnOvEmFo3oZUyxfGbz0e9/waUKJcay/B
	 ulqAAqZ8fT7ST4z1YZd+B5XSm85iLoKo7BN7tD3KTLECZ4zAMHYgvB+TmrABW752ri
	 sqVT0tKHdBGtciAetPrknw/7LiV2aVP98DL5X7zA=
Date: Thu, 6 Mar 2025 13:20:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg
 <johannes@sipsolutions.net>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 00/13] arch, mm: reduce code duplication in mem_init()
Message-Id: <20250306132003.0066f109dae75f74711f9432@linux-foundation.org>
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_132006_864516_5D207064 
X-CRM114-Status: GOOD (  12.94  )
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

On Thu,  6 Mar 2025 20:51:10 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Every architecture has implementation of mem_init() function and some
> even more than one. All these release free memory to the buddy
> allocator, most of them set high_memory to the end of directly
> addressable memory and many of them set max_mapnr for FLATMEM case.
> 
> These patches pull the commonalities into the generic code and refactor
> some of the mem_init() implementations so that many of them can be just
> dropped.

Thanks, I added this series to mm.git.

