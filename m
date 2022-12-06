Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B2C352A1
	for <linux-um@archiver.kernel.org>; Tue,  6 Dec 2022 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/7myZ/wth2VK5AlWMEoSI8Nboc/6WWYOjnUiROh70DI=; b=CmCuj24g1SEWY3
	KwL9zuxDABbQ1qlC+Ss3ENK8PnqDpG6Cr6QFcU8fJf4Yt9xy1MTi78n2BV/Zr2qisixHT9aZ06UxF
	sPPuJJpEKHLAGzaIYaCkBYd0tZIgiynSoZ5j5svzMaL57ycidH57f6dCc83EagpaUBVR9Nkmrbrco
	nfETBOBkboDLzmGcTnasLKAEJYT+72bzQtda0rBBtay5PZ73auoWsvXU/NYPjGiM4U3TaAhAcxQB2
	d+c2eAi6K44AbeQ/tHH98Qx7jghgowufQ/Gh1gtA7Py/2ZU5CYPfIGiE6ZP4de60YkX2Mt7T112YG
	cuOHW2E5fqCIetyk+NNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZEv-00BgjT-5e; Tue, 06 Dec 2022 14:48:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZEs-00Bgg0-2Q
	for linux-um@lists.infradead.org; Tue, 06 Dec 2022 14:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670338085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/J/bI9dhyjQ/usSRNhI5biIirU1QHLlTc54Jeh9AEr0=;
	b=gXOb4ViwSO1ZfU8fYrFfIMBNieujLRu9JHoJnjJyXrqD2uLvtrLVa60btp532unt5GWKbg
	j4C8p2XsW2crtiZveCPFOBRfLupUqtn11+mpRh0RZTzoS6PaifdSk2iJbJRWC8/q5i5LF7
	UiTZaGVgzRq3ybLdeSkIIcp66gZkQ88=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-8CVFD73pPtiuCMFV0N15hg-1; Tue, 06 Dec 2022 09:48:01 -0500
X-MC-Unique: 8CVFD73pPtiuCMFV0N15hg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E4EA38164C3;
	Tue,  6 Dec 2022 14:48:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A3F6492B04;
	Tue,  6 Dec 2022 14:47:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Yang Shi <shy828301@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-xtensa@linux-xtensa.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable RFC 01/26] mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
Date: Tue,  6 Dec 2022 15:47:05 +0100
Message-Id: <20221206144730.163732-2-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_064806_342308_7C090F82 
X-CRM114-Status: GOOD (  12.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

We want to implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures.
Let's extend our sanity checks, especially testing that our PTE bit
does not affect:
* is_swap_pte() -> pte_present() and pte_none()
* the swap entry + type
* pte_swp_soft_dirty()

Especially, the pfn_pte() is dodgy when the swap PTE layout differs
heavily from ordinary PTEs. Let's properly construct a swap PTE from
swap type+offset.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/debug_vm_pgtable.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c631ade3f1d2..0506622016d9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -807,13 +807,34 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 {
 #ifdef __HAVE_ARCH_PTE_SWP_EXCLUSIVE
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
+	unsigned long max_swapfile_size = generic_max_swapfile_size();
+	swp_entry_t entry, entry2;
+	pte_t pte;
 
 	pr_debug("Validating PTE swap exclusive\n");
+
+	/* Create a swp entry with all possible bits set */
+	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1,
+			  max_swapfile_size - 1);
+
+	pte = swp_entry_to_pte(entry);
+	WARN_ON(pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+
 	pte = pte_swp_mkexclusive(pte);
 	WARN_ON(!pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(pte_swp_soft_dirty(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+
 	pte = pte_swp_clear_exclusive(pte);
 	WARN_ON(pte_swp_exclusive(pte));
+	WARN_ON(!is_swap_pte(pte));
+	entry2 = pte_to_swp_entry(pte);
+	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
 #endif /* __HAVE_ARCH_PTE_SWP_EXCLUSIVE */
 }
 
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
