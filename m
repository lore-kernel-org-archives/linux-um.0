Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E6EEB577
	for <linux-um@archiver.kernel.org>; Thu,  1 Jan 2026 01:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIZ2+TTs0EEoEyjGKcpoyL5C5f8RhmuxTK2sG/mfXjE=; b=gCANRQl4SpEPiSW+RM44NpCC5p
	Dbmm090G+vfVP/+GeUK3/a/SmtwQNDe7V6BKHkR65rv5g84HZJ2OgXHwY3XIQ2A/4Q6pvl0j2WWaX
	dnMn8Ny09s93soFxUDrj+AhbItminnssHeiFoKy538tLT3L0hD3sdHwCT/xvmWCwYjCOFJqVbr8rn
	fmkcsmfrlnri2uVcpE8LNunGBpCZI3pCSbFT+hdWQzgHh4sSrkvVVPpq/Sx35sFlJ9rpxYMmzwP0N
	ZMX4Z737gucueAKJ6fXQbHf5nu5/EytGuCPnXCXRdarIWUvc5OzwIkAKYpVyuerwpBM5VtlMjdinl
	9ZOOD/uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb7TG-00000006Upi-3Xoc;
	Thu, 01 Jan 2026 01:27:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb7TD-00000006UpL-3Plf;
	Thu, 01 Jan 2026 01:27:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3163160008;
	Thu,  1 Jan 2026 01:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7ACC113D0;
	Thu,  1 Jan 2026 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767230836;
	bh=kfzq7OmA115iWgJ760zWgcONuzBXEf0EdKCppmYMA+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=go9XllSISBYzAOyojV4kRDLc0Hnz1rcUEPO57TcB9+qJSNx41b/AgCw3COmwnxqiT
	 j7mZyPb6MMMoWfBvYMRKbnSkqA9aNlPjK8qN3O6fQrDlWlCfoS7A/tERDwbL0qwoSr
	 LfQqAcLLX+Rrl87zP58OiVxJMBgmW31R6wiBayKc=
Date: Wed, 31 Dec 2025 17:27:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, Dinh
 Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
 <corbet@lwn.net>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Michal Simek <monstr@monstr.eu>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, Pratyush
 Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, Russell
 King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil
 Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH 00/28] arch, mm: consolidate hugetlb early reservation
Message-Id: <20251231172714.a7fe44e856c14fdc8fe1cb43@linux-foundation.org>
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 28 Dec 2025 14:39:30 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Order in which early memory reservation for hugetlb happens depends on
> architecture, on configuration options and on command line parameters.
> 
> Some architectures rely on the core MM to call hugetlb_bootmem_alloc()
> while others call it very early to allow pre-allocation of HVO-style
> vmemmap.
> 
> When hugetlb_cma is supported by an architecture it is initialized during
> setup_arch() and then later hugetlb_init code needs to understand did it
> happen or not.
> 
> To make everything consistent and unified, both reservation of hugetlb
> memory from bootmem and creation of CMA areas for hugetlb must be called
> from core MM initialization and it would have been a simple change.
> However, HVO-style pre-initialization ordering requirements slightly
> complicate things and for HVO pre-init to work sparse and memory map should
> be initialized after hugetlb reservations.
> 
> This required pulling out the call to free_area_init() out of setup_arch()
> path and moving it MM initialization and this is what the first 23 patches
> do.
> 
> These changes are deliberately split into per-arch patches that change how
> the zone limits are calculated for each architecture and the patches 22 and
> 23 just remove the calls to free_area_init() and sprase_init() from arch/*.
> 
> Patch 24 is a simple cleanup for MIPS.
> 
> Patches 25 and 26 actually consolidate hugetlb reservations and patches 27
> and 28 perform some aftermath cleanups.

Thanks for the diligence - this can't have been the most exciting thing
to work on!

> I tried to trim the distribution list and although it's still quite long
> if you feel that someone was wrongly excluded please add them back.

I'll add these to mm.git's mm-new branch for some testing.  I'll
suppress the usual email storm because 41 * 28 is a lot of emails ;)

