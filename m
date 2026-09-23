Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F848C982FA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PVPdXmv6NnvLVZVQ7aZbUUffkgQCjLv7KTz76oZcF8=; b=VtRkXEXxTBlbIvAafGD666KO4C
	bhd9gU+kymhU8kTa/qz/xxhPyG+PUo31dEpreMBcZzPo0En2dIjFhwZXrcBd32puRsPNBSxHDqxBd
	bf0rsH2YSDYboGzM1up3y7iOY/DuM3b88eJbECj89s1Fo0SKNRt5kidLXPHu7gh0I2fbUJrK4nHM9
	dD8hJTM0ar37r72ivN1RHDMGKEy16qKGgFgH0YOaR331a6L0suLs1rGbZUd+mbkjmpvR+ui8MqxwL
	L1Y9/AR3h2L0tj5vUgpbL+yc2PbwW/xABBynscQDQMbPKEo9Ta3d0wmo2ko0/JTk7WLlD3V+qjCaM
	ig5mvrbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9HzF-00000007T8T-3f8A;
	Wed, 23 Sep 2026 08:05:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9HzD-00000007T7I-3aCT
	for linux-um@bombadil.infradead.org;
	Wed, 23 Sep 2026 08:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8PVPdXmv6NnvLVZVQ7aZbUUffkgQCjLv7KTz76oZcF8=; b=S4Gt5qENm44qQfYUEujSQ1rmFT
	mmwk5wZQZubbydfbrMbwy6q0bN+fn+jn7CiAXDHBDVw8gSZpCVOYmUcVzypc0LMNlRRi2/ZNJ0Y5U
	L140cjpDObM3tcsoP0bJKvc4pQLfqMlYSAb92BGrhzxNvqpogLH/ys/QzrhhuYs506Xi9uC4P0+7J
	WQA9SbmT2+xlQqIHp7UunsKECHSQKk3iyW/a0A2F9DkHqRxa5vfNW5szCoApyiUp1Wu+sfxLru2Kl
	Tyctccs+ZU+RQYyhKD8WV222+69H4Jz1+Nd3k1aWM/+n+P9e37CW9E1JOlHJlBLv5oxaN4AVAWTu8
	HeY6Pn5Q==;
Received: from out-145.mta1.migadu.com ([95.215.58.145] helo=mta1.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9HzA-0000000EVJL-0j6r
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 08:05:50 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=5BGZTHY8kFe6g0IgkeIcnp2oHzMTIKE0zyxoC0cn6HM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790150746; v=1; x=1790755546;
 b=WWzI1t7TTqFw2wr0jDkPbtN7TwQkuQvfOO3Aoft9mKRYRiQ8BJkP6zHsQzDXqVepu6W5cjvb
 tfHsZBOIWQv3UyolWYXTaga2Up9GF8hClSUeIYphsrLfUFaHgusY8nU/X1vFS5NizsI0/JMz8p6
 fN5aMOPIlrRM1utL1VgA1DNQ=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 0dc515f7c86dd02d;
	Wed, 23 Sep 2026 08:05:34 +0000
X-Mizu-Trace-ID: 0dc515f7c86dd02d
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
Subject: Re: [PATCH v4 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU arm
Date: Wed, 23 Sep 2026 16:05:23 +0800
Message-ID: <20260923080523.9480-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_090548_673186_AB8BB7BB 
X-CRM114-Status: GOOD (  10.89  )
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


On Tue, Sep 22, 2026 at 04:35:35PM +0100, Lorenzo Stoakes (ARM) wrote:
>Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
>CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
>arm architectures with LPAE enabled.
>
>Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
>table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
>
>Non-LPAE PMD page tables are folded into the PGD and freed by
>pgd_free() (PGD freeing is not part of mmu_gather page table freeing in any
>case), so this is a noop in this case.
>
>Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs")
>both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
>
>Thus all page table freeing is performed under RCU with
>CONFIG_MMU_GATHER_RCU_TABLE_FREE enabled for LPAE and non-LPAE and thus it
>need not be gated on LPAE.
>
>A UP arm system can set CONFIG_PREEMPT_RCU, so a future pure RCU page
>table walker requires MMU_GATHER_RCU_TABLE_FREE to be enabled on UP as
>well, even if concurrent GUP fast is not possible there.
>
>Therefore, it is both safe and desirable to set
>CONFIG_MMU_GATHER_RCU_TABLE_FREE for all MMU arm architectures (nommu does
>not perform mmu_gather operations).
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Tested under heavy page-table teardown load on qemu-system-arm,
with and without ARM_LPAE. No issues seen :D

Tested-by: Lance Yang <lance.yang@linux.dev>

Also, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>


> arch/arm/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>index 408aa58a2a5b..72b9afc6ae10 100644
>--- a/arch/arm/Kconfig
>+++ b/arch/arm/Kconfig
>@@ -134,7 +134,7 @@ config ARM
> 	select HAVE_PERF_REGS
> 	select HAVE_PERF_USER_STACK_DUMP
> 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>-	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
>+	select MMU_GATHER_RCU_TABLE_FREE if MMU
> 	select HAVE_REGS_AND_STACK_ACCESS_API
> 	select HAVE_RSEQ
> 	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
>
>-- 
>2.55.0
>
>

