Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0E9C98304
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 03:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3BWZhH71CkI6kIjfqREmsVNahheMeRs+lPAGQsvw7A=; b=F3gd3O48/NAG8V4CC9sxQ0W0di
	M4n+BioEkZpO1eolgemrWh+5zu6/xgKoLAXDf6x2nylGqBJGpc3n8W9JfiDS3rDxQeWQPYLGCkF2X
	fFlvIayTChTdK7FO7ahzUA7W1QA7lw4XbfC7QOxGmJD1ztCYlri4VsLg9vMASONY68zN0PXxCBjSo
	zgfVEQ18AusArsIj5oHZGUaxMFKHT3++Ail1mMTipUtBEev3mI6RgIf1UHwbTSzctarm825epFxh7
	QsiPZOQAtE6Wzk8aE3RSMYtFs5eb1QEU1cPmGW+bZGBF3wDQC5xLXDe14PaokzJlTXnlTszM3YQK+
	9Xd4YhIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9a6e-00000009w7P-38EF;
	Thu, 24 Sep 2026 03:26:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9a6d-00000009w6u-3ngi
	for linux-um@bombadil.infradead.org;
	Thu, 24 Sep 2026 03:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R3BWZhH71CkI6kIjfqREmsVNahheMeRs+lPAGQsvw7A=; b=URKNkZjd+kmD22VkbvesRpg1Rz
	PuEjhdTb+AkKSIaD04BRuF4B3pNHFK9jTqk9RilsgzRp/BqLkeBqJD8v5RntRCj1ph2ouZs2KIh7j
	wiMByYVtWiB4lOuoL+ZqCDsq/8l72QDUT/qK0sQM7G+V/mB8moVjx/3aL1uhWWC5R10QuxlNn8K3o
	K7FCBGBy9ADPwY8cEMZ3qe575BYKJeY3Kt5YHIjb32iMNFUy436jx7GhFZp/AEA/Uz9T5dhyFk2z+
	gSPoc+nZFw/iZuZh2IKNL8IPcprPA5inlMmmalJX3eCwq7nog/x9bLqCQ0mFD8zDsLWILZR2GBX2U
	6LVWJ4xw==;
Received: from out-136.mta0.migadu.com ([2001:41d0:1004:224b::88] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9a6W-0000000FUvV-2d7R
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 03:26:42 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=2yvE0h+QEBEUSGV14adujKMIHz+x1ZjAZUB9qMU3ScA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790220394; v=1; x=1790825194;
 b=qgGOhmf6IfmpZAuY5nR09PNkJ2CLfBbLQcIzCxoHH6Y8GX2l0Fgp3QZ/pSfpq/4mTGQaJwqT
 /P+paTRwLqcVXLCauERKMk1pA5/VeA8n6fofZ7V6HgkcjnqZ9YU4unflo7G8RcZw/aJXxg1kQ8U
 R/J0LuQXTaitiSzq2lliz6nk=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id ae8cc7886785f523;
	Thu, 24 Sep 2026 03:26:31 +0000
X-Mizu-Trace-ID: ae8cc7886785f523
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
Subject: Re: [PATCH v4 12/12] mm: change the contract for free_pgtables(), update docs
Date: Thu, 24 Sep 2026 11:26:25 +0800
Message-ID: <20260924032625.28555-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_042637_094806_E268959A 
X-CRM114-Status: GOOD (  15.75  )
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


On Tue, Sep 22, 2026 at 04:35:43PM +0100, Lorenzo Stoakes (ARM) wrote:
>Now that page tables are freed after an RCU grace period, it is safe for
>read-only page table walkers to walk page table ranges that are being
>concurrently torn down, provided the mm is kept alive via mmgrab().
>
>It is however unsafe for writers to do so, as they must obtain an
>appropriate lock to do so safely.
>
>Update the pte_offset_map_lock()'s comment block to reflect this.
>
>Similarly update the process addresses documentation.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---
> Documentation/mm/process_addrs.rst |  6 ++++++
> mm/pgtable-generic.c               | 15 +++++++++++----
> 2 files changed, 17 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
>index a7296f251799..b1f4f44d75eb 100644
>--- a/Documentation/mm/process_addrs.rst
>+++ b/Documentation/mm/process_addrs.rst
>@@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
> * When changing a page table entry the page table lock for that page table
>   **must** be held, except if you can safely assume nobody can access the page
>   tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
>+* Page tables may be *walked* under RCU alone, as page tables are freed only
>+  after an RCU grace period has elapsed. However, any entry found must be
>+  revalidated after the page table lock is taken (such as the
>+  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
>+  before it is acted upon. Changing an entry requires the page table
>+  lock and one of the locks that excludes teardown (mmap or VMA lock).

What about rmap walkers? try_to_unmap() clears PTEs under the rmap lock
and PTL, without an mmap or VMA lock.

Cheers, Lance

> * Reads from and writes to page table entries must be *appropriately*
>   atomic. See the section on atomicity below for details.
> * Populating previously empty entries requires that the mmap or VMA locks are
>diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>index b91b1a98029c..a127e3e8f9b9 100644
>--- a/mm/pgtable-generic.c
>+++ b/mm/pgtable-generic.c
>@@ -385,10 +385,17 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>  * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
>  * be read-only/read-write protected.
>  *
>- * Note that free_pgtables(), used after unmapping detached vmas, or when
>- * exiting the whole mm, does not take page table lock before freeing a page
>- * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
>- * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
>+ * Note that free_pgtables(), used after unmapping detached vmas or when exiting
>+ * the whole mm, does not take a page table lock before freeing a page table.
>+ *
>+ * As page table freeing itself is RCU-safe, page table readers can safely run
>+ * concurrently with page table teardown.
>+ *
>+ * However, writers CANNOT as, without a lock being held, nothing prevents
>+ * concurrent teardown.
>+ *
>+ * Also note that the PGD itself is freed at mmdrop() time, not under RCU - so
>+ * the walker must keep the mm alive either by pinning the mm or the VMA.
>  */
> pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> 			   unsigned long addr, spinlock_t **ptlp)
>
>-- 
>2.55.0
>
>

