Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5B8C9830D
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=; b=BJcpt+RZwHIw+waPDi1ZUMsT2x
	AwQ6m0U7ZSICPPAyICLN34YPkmhrf687qEXSBYI9BNUDslGeSkM3lMM4gWMT41d3nsVEEVmTxD7M5
	j1k8WlO6Nhksp8NTbTHLqQnusZSj7J7XfLITFcpWNUiJjn9utvgkN8Iy5OHi/ADeqpZb8chL72IP1
	HJxQSORFOihD+7EjtJf85MpTY8xQHRrJPzxxm44L3fD4MkIPjO0pYMwCk5STerVtW+n0LmA5Se8yo
	brrV0h38h0puB2JCkivK8I6jWw22SXf9ExtiOCSTFnjV28PCtLbPih7OcBeyIcmmn7DaALf5cZ9so
	9CylFE9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9MqA-00000008Mow-16ZR;
	Wed, 23 Sep 2026 13:16:50 +0000
Received: from out-212.mta0.migadu.com ([2001:41d0:1004:224b::d4] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Mq6-00000008Mn7-0UbY
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 13:16:48 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790169404; v=1; x=1790774204;
 b=R+Vt7VKYQ6Z6CnIF0Eghz5I7R/+ugag7Aunz3sd2gZveys399bQFeSb1YCVCCXeuNz7jxa37
 fR+ZJBx2QZ4T6EQAoywLElJG7bK8WPX5c2c7ag3JVpTGS3iEoDuR3IwCKjQhRx0Yl/5NhF5zp4m
 lAlRbSUtpkfWnXHknys8Ra4A=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id acd8da373ac6bf50;
	Wed, 23 Sep 2026 13:16:40 +0000
X-Mizu-Trace-ID: acd8da373ac6bf50
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
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-motorola
Date: Wed, 23 Sep 2026 21:16:34 +0800
Message-ID: <20260923131634.47896-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_061646_294281_F36DEFC4 
X-CRM114-Status: GOOD (  10.65  )
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


On Tue, Sep 22, 2026 at 04:35:40PM +0100, Lorenzo Stoakes (ARM) wrote:
>sun3 and coldfire are already supported, however motorola requires a little
>more care.
>
>Here, custom table removal logic is required, so
>CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>
>Firstly as part of this change, the page table level must be communicated
>to the underlying __tlb_remove_table() implementation.
>
>Take advantage of the fact that page tables are aligned by more than enough
>to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
>and store this there.
>
>Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
>then have __tlb_remove_table() decode this and pass it to
>free_pointer_table().
>
>The page table freeing is performed via call_rcu(), so free_pointer_table()
>now will be invoked from softirq context, and as such may be re-entrant.
>
>Introduce an irq save/restore spinlock to handle this, and hold it over the
>time a given ptable entry is being referenced in both get_pointer_table()
>and free_pointer_table().
>
>In order to make things a little easier in this respect, separate out the
>logic for adding a new ptable entry into add_pointer_table() and only hold
>the lock during ptable entry insertion in this case.
>
>Note that original list_add_tail(new, dp) added new prior to dp, which is
>ptable_list[type].next, i.e. after ptable_list[type].
>
>The equivalent therefore is list_add(new, &ptable_list[type]), which adds
>new after ptable_list[type], only without needing to make reference to dp.
>
>Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
>does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.
>
>With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

I wondered about slot reuse during the RCU wait, but that can't happen :)

The slot stays marked busy until free_pointer_table() runs after RCU, and
the last free unlinks the page under ptable_lock.

Also ran page-table teardown stress and fork/exec churn on
qemu-system-m68k (virt, m68040, CONFIG_MMU_MOTOROLA=y). All 40 rounds ran
cleanly :D

Acked-by: Lance Yang <lance.yang@linux.dev>

Tested-by: Lance Yang <lance.yang@linux.dev>

