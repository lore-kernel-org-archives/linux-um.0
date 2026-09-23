Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6418C982FA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2o4rQDYiHbtVqFkAN2kWkZun12rmMLs4YnN5p0vVmiw=; b=zicjR13R5F8ZA/b3pm2N7jgjo9
	WxDKS0ZAQ8lARxEjFv+fUFalnCzORYUd+zrQzU2HecHm++bH0PTaQ5GJ/TfxTMCeHrzA9dEUqkNnL
	6TL3Eh3sGCEm2c6oVtniknBeqa8Ny1xg/gUcnJm8GV0JQxrswTm/jSOMgtvQtWiuSVenGk9YwNsDN
	dx89XcXPcTXhNALOPFEBgWe/ddLS9rNy27AbGkVzimuG9gDenobML9fZRyYLTD3BfcN3T3QNu1aR3
	fRZ0uXy9UYhw2Cd7IC3lw76GQ7tf9DJhqZd8WicvmVQU7ZSA2dPNgCjp6LDu4N1wzQLXtDjDPi87d
	nbvOV9YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Iur-00000007fJt-0j0x;
	Wed, 23 Sep 2026 09:05:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Iuo-00000007fJC-1K0w;
	Wed, 23 Sep 2026 09:05:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A523C600AA;
	Wed, 23 Sep 2026 09:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E23B1F000FF;
	Wed, 23 Sep 2026 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154321;
	bh=2o4rQDYiHbtVqFkAN2kWkZun12rmMLs4YnN5p0vVmiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDCmOLtH6oBzineU5ofDYtw3CW3mtwyk5V3xT/lkkCtxB1Q+OwDra0xNToTtg8iIm
	 u7rGJ/xDe6BKL7MrOMEn8bDOMYTCV4aEzKQKJIt00q1BsH3wSVTQo2Ook3KjVOJMIR
	 AB4sDPrnTg2fF+LMD5pG93PhRaZQ302+w7tBmfT4/Q4oKOmPfIeb2DOtAbjc8G/HBr
	 9DhsZ+uSqRYGiIaloX4OWTC1NUs9xiLQ6o7nt/X/EFVExrVXn1dH9PmU3LwdrRgVG5
	 Odt7Cl6nzQ4qviO/2kqxNclnZdLZjOTUWiY2xDH0cr58TUDFGwa6IBWPTdeie3ekC9
	 ipydVMPWKNSiA==
Date: Wed, 23 Sep 2026 10:04:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <arOVbT5B1FOMe1wb@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922160021.a2fc65d05d9b867a141e5457@linux-foundation.org>
 <9dcde7e4-dadb-4644-9dff-7fd8a26e29a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcde7e4-dadb-4644-9dff-7fd8a26e29a6@kernel.org>
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

On Wed, Sep 23, 2026 at 10:45:33AM +0200, David Hildenbrand (Arm) wrote:
> On 9/23/26 01:00, Andrew Morton wrote:
> > On Tue, 22 Sep 2026 16:35:31 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> >> The majority of architectures in the kernel defer page table freeing until
> >> an RCU grace period has elapsed, this series converts all remaining
> >> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> >> altogether.
> >>
> >> This is important because it enables safe lockless page table walking under
> >> RCU alone.
> >
> > Do we have reason to believe that anyone is seeing any effects from
> > their arch's failure to rcu-free the page tables?
> >
> > This sounds like a rather long-standing wart, yes?
> >
> > The patchset is thinly reviewed and mm.git is bursting at the seams
> > again.  I'll play wait-and-see on this series.
> Do we want to nudge arch maintainers to review?

(Just to note that I replied separately, 'thinly reviewed' is incorrect, it's
been in -next for weeks and the whole thing was reviewed by Kiryl.)

The only places where that would be useful is m68k motorola, sparc32.

But in any case it has been heavily tested including on every single arch
listed with stress testing performed (I think I cover that in the cover
letter).

The changes are not controversial so I don't think that's a blocker, but
it'd be nice?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

