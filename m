Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBCC982EA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmR3kOZB3ACXfNo3laV3NfaLUopFF9HlVbP149Haq1Y=; b=VSQzfh9LGuWN0o/WnCqJpiB2sd
	Wic0LmNg+fUyw0gqyhfkFMjYQNerZxsjz0e0zWEyaMp3bcNWd/Ceh3DSrqYk6lSKmf1v90KBEdyRd
	cZQ5x+O0ltuVPXHeCcwJIQgkx/44mCcLbqFTeqtXZmDUbQioLZuxXR9+2ldNgFNNgT6IeRXyBaqIL
	vjYm/gE1VvlXUpNOhnNnv8Jacp2G07zDUcBHREsPbP9FG+Xx53i80LT6fDqg7tDvq2mmdDHt9gDt/
	8J3h1oEX4V+aj3635Dnc7ITBWEsgQV0qipzyKq3MwTWdSFXdPEYgR5BrVmSL0W/XL84oDEb9tMNP8
	j09kEHeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9H36-00000007LZy-0t0X;
	Wed, 23 Sep 2026 07:05:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9H33-00000007LZY-2kR4;
	Wed, 23 Sep 2026 07:05:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B240436CF;
	Wed, 23 Sep 2026 07:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A21F000FF;
	Wed, 23 Sep 2026 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147144;
	bh=WmR3kOZB3ACXfNo3laV3NfaLUopFF9HlVbP149Haq1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EAnwJUiAqyojRKJf9KNQTwXny7L+XnGgJ0trGGXwGUbbfY4A9uWcu9K0SsUiWOgmc
	 yb41CHhlT/HBuBnzVyYR5/fQuSR3XjSBl9uXtd/UfutbvMg5gyAst3woO5CUYyXhGy
	 AD976W51iwZLDg5mT7WlRmgWnW6l1yj7+OPvlJqhBDwYsyITZldKacOLPw8X3r5iwh
	 xdzP0DsHgF0BxH20eqFZEB0DFdFfRS+stF04cj498KEixAmiiwoIiMX7fOO4v2ki3T
	 qJvjlyssz0DhAO2ce9/8NcZk01mVg0oHHUpA2uecyxQvoQ0UuWqDvbZALG/EIOlt5M
	 hZKVkk39Tca+Q==
Date: Wed, 23 Sep 2026 08:05:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Message-ID: <arN6JBJixHUjX2CJ@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
 <20260923061551.84398-1-lance.yang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923061551.84398-1-lance.yang@linux.dev>
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

On Wed, Sep 23, 2026 at 02:15:51PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:34PM +0100, Lorenzo Stoakes (ARM) wrote:
> >Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
> >CONFIG_MMU.
> >
> >Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
> >MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
> >riscv builds.
> >
> >This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
> >is enabled if CONFIG_MMU is enabled).
> >
> >Naturally a single core system does not encounter issues with software page
> >table walkers being correctly synchronised across cores, as there is only a
> >single core.
> >
> >However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so for
> >a future RCU-only page table walker, this guarantee is required to prevent
> >concurrent page table teardown.
> >
> >All page table freeing is already done via tlb_remove_ptdesc() so the
> >conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> Yeah, for RISC-V, page-table freeing already goes through
> tlb_remove_ptdesc() :) Tested on QEMU, no issues seen :)
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks! :)

A cheeky A-b tag possible too? :P


--
Cheers, Lorenzo

