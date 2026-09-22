Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE755C98307
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNh8IajC2C7W4xAVN/5A4Te3DbNvUnFRUUUmja4mmRU=; b=pyoknwiQsnvCALuobXnOa4q1tp
	krm2qNd7viE/VFGpqSDEerVRLogMM5aylGTP6lCEMyQMN6vkWXcvBYghiu7JAIhj3UiJQ9iBy8Bow
	/1cyC1h3++BP1yOHyZHCl6r7ticM+a27Hzi2e9V3uaKrMuUZ+z6FNPH2IbnEDD8nTB/JmKxAx2TCa
	I50bHz3IlhPJEXrqbCkhI6LVEzwDTZI2ecFoSutyMyzXzPIa0tQ7xa/2NnSwv6ZOPNqR38CN4XPXM
	2SNU4XdgLucNjXB5DaQ0XJzOX5f8sNTPf5VCFo5tida+EDSji92TJw3DeaW9UCsJ+dowq4IMAWlwF
	ZLMlMWAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x94CY-00000006BSj-2uVj;
	Tue, 22 Sep 2026 17:22:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x94CW-00000006BSB-1VpK;
	Tue, 22 Sep 2026 17:22:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4EC096022B;
	Tue, 22 Sep 2026 17:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DCD1F000FF;
	Tue, 22 Sep 2026 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097759;
	bh=UNh8IajC2C7W4xAVN/5A4Te3DbNvUnFRUUUmja4mmRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9l/h2sgeG6pItIpsl4UOUD5LPuOPYalAOj3lX7iN1SKQRQx/7vSe8Y8wJYuJaFa9
	 tegjTwQVFA9hXGIt+1oJvFwKspvEmTZEeRl/rL3Z+1/vMB7N90Y9ljH8EiqVFiWGMa
	 llb7G+u8p4G82Y3NfZpa4T6VyMnit/o1genoOGjAzyku0OZj1fvAIP0nPa5BRjaZ1s
	 0LsiYA1bWAjQ698sUHV9gBhPhcHOkUs5jCvX2Aqi8QkSHyLlAciZyH7C9FEowKSWF8
	 GvrRJLzG6nhqL2FhCQxRW0vNDBGCdIskECu8iSBeB5zhpcl0fRPI9Q5+bVasWrDLde
	 t0gfKdsjFaNOA==
Date: Tue, 22 Sep 2026 18:22:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
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
Message-ID: <arK4XnDTuFpwPV38@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <arKv4qbF04KB2WxQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKv4qbF04KB2WxQ@casper.infradead.org>
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

On Tue, Sep 22, 2026 at 05:42:10PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 22, 2026 at 04:35:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> > m68k-motorola required the biggest change - since RCU page table freeing
> > uses call_rcu(), this means page table freeing can arise from softirq
> > context.
> >
> > This was fixed with an IRQ-safe spin lock used in both get_pointer_table()
> > and free_pointer_table().
>
> You don't need to use an irq-safe spinlock for softirqs.  It does work,
> but it's overkill since it disables hardirqs.  If you use spin_lock_bh(),
> only softirqs are prevented from running (and it's safe to call
> spin_lock_bh() when in softirq context, just like it's safe to call
> spin_lock_irqsave() in hardirq or softirq context).

Right yup, I know _bh() is fine for softirq, I think this was being overly
cautious (for sparc32 you do actually need irq saving).

But this is m68k :) functionally there's really not that much difference, and
it's over very few instrucitons so the delta here is likely to be functionally
little to nothing.

If I need to respin again I'll fix it up!

--
Cheers, Lorenzo

