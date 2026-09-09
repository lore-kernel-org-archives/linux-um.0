Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B50FC79FB9
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n4mPQZ86gp5FDwQ4tHqlyfsOtYqdqNDLvVyVaC4A/Fo=; b=sPbIkhV2xEMA1gDA446UswU/cI
	34SxPs4Sd0tcUwHyZIEJazZJ/1toG0mFtmAtJjDoekXumIkcJZXiClowM9GqBIZB747Gi0j0xeMvH
	2gzyg2s6mfsLlRDn3BzJXeWV4zR1WMZiT2YPxB+EcmNBlBtgmlPYk7J6sp+ble4hEt8cdHSe8+/ai
	dpMquxOHSY7nR1se13OBP0lsfA++CrNIKBIOr0/PrFzQ2sr25ScAh8JkmlkeSv1R1p3KjfNL6QYV1
	npxvChUDbH41ujEKHPsMdDwdSTje8Yh/1G0AEON/WxVtuKWcF9Kq8BkBxKbePqfAaLJNXqh6yUnfS
	MHJ7o8Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4GA9-0000000BWQj-1Wmv;
	Wed, 09 Sep 2026 11:08:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4GA7-0000000BWQ6-04No;
	Wed, 09 Sep 2026 11:08:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B6D7601FD;
	Wed,  9 Sep 2026 11:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9D1F00AC4;
	Wed,  9 Sep 2026 11:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952097;
	bh=n4mPQZ86gp5FDwQ4tHqlyfsOtYqdqNDLvVyVaC4A/Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QaTpJ5ovoTiEG+gXq4D4QRjJgrK/QkDaAvE4t9yf2p1CDXfWR+kPkM4RvUM0qdfPJ
	 YQ3u5ytOfaVK2InZ/CGWXhSaMh2xZGgB5cMzAuvnJWAkL0XnASM+7IEN4Mh5mQR/v/
	 23xVaM73u8uzFcGxU4t1Ngaq+BDhm428o54Sxl6mcGruZx3hwkdRUas8xhLW+8np6o
	 1FCSepWEU5Qtr1gN3/1lPqwwWSfxlmy6GHgFq4rT9aBoF8CazzfpBWEzsvaBIQ/txk
	 czLEOp1wjtukmiYmMeK+KJpQGgy7iNAEV7FZIokob8wTGUUDEcjvf9Oxi9V03vXvLr
	 Iqy39qtZl8jxA==
Date: Wed, 9 Sep 2026 12:07:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <aqE-ABWDmw26OGK2@gremlin>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <aqEl9zv8M_o1yW62@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqEl9zv8M_o1yW62@thinkstation>
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

On Wed, Sep 09, 2026 at 10:26:03AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 08, 2026 at 01:32:09PM +0100, Lorenzo Stoakes (ARM) wrote:
> > The majority of architectures in the kernel defer page table freeing until
> > an RCU grace period has elapsed, this series converts all remaining
> > architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > altogether.
>
> Apart from few nitpicks, the patchset looks good to me:
>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks! :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo

