Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB118C982FA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=; b=cX03qTICBio4Y95tav16ep2MaC
	nxJrMcsdxdZVUilybh20qtMww3tne8QS7CoIWkfjX+36bGvonf/Ah9+OlB4Hk7U+q4Aeqing+7+lq
	IzJrooafGissTA3v6xfQX7x8FhiZ0skaSGEo/BH40xZSP/MQfRMR/+nHMfzi+3wKDFaA74aLFJ77p
	+xrZiiLISUpvP116MNtuL6Q7093hgivCdTEewCn2De7Z9l33fSOsHjXdV6hIMEn/mUIuOOZyUrHQc
	jo92lLib+zV7sL7rBCgENG4pBJ/ubMzoDd14FDhYW3nCk/bbnlWKHY873m8LtqNxlxE8ovpkXtq11
	SGYUQ3uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9IZb-00000007ZdU-0QJy;
	Wed, 23 Sep 2026 08:43:27 +0000
Received: from out-53.mta1.migadu.com ([95.215.58.53] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9IZY-00000007Zbh-2zBN
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 08:43:26 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790153003; v=1; x=1790757803;
 b=OVP+8UHSXLmBCK3c+dzOsk2DTtkt4PvGjy/FBMe5tjP12SMncYBRGF1bbqf2+ARWr1hychQU
 NrzV+WiUfQ6UfrkihqhxAO6bDiXp8t8/0WRzFKxAvF4kRdyC9MStYUxj3K2S/x8L2D4yF1YcD8I
 1h5GTjgf1ieTc55NlgCiqJAY=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c8a1201785675537;
	Wed, 23 Sep 2026 08:43:18 +0000
X-Mizu-Trace-ID: c8a1201785675537
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc, microblaze, xtensa
Date: Wed, 23 Sep 2026 16:43:11 +0800
Message-ID: <20260923084311.15570-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_014324_887222_9BDD87E4 
X-CRM114-Status: UNSURE (   7.09  )
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


On Tue, Sep 22, 2026 at 04:35:36PM +0100, Lorenzo Stoakes (ARM) wrote:
>Each of these architectures directly free page tables without routing these
>changes through tlb_remove_ptdesc().
>
>The use of tlb_remove_ptdesc() is required for
>CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
>so simply update these architectures to use these functions.
>
>Since none of the architectures share page tables or do anything unusual,
>nothing complicated is required here.
>
>Therefore this is simply a mechanical change - convert __pud_free_tlb(),
>__pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
>required.
>
>At the point this is in place, all mmu_gather page table freeing is
>performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
>each architecture.
>
>Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
>xtensa to reflect the fact that nommu does not implement page table
>gathering.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Right, the old frees already end up in pagetable_dtor_free(). With
tlb_remove_ptdesc(), the same cleanup happens after an RCU grace period.

Makes sense to me, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>

