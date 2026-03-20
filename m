Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673531099B3A
	for <linux-um@archiver.kernel.org>; Fri, 20 Mar 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MF3HDfZN/X2IuMlCa6w9U893UanxlzUmNuSBnCYYxSY=; b=gT/EPzC4s0N4NYPOVwo7t0GkQ3
	dMSwnSp1KRQ4KBUnRCMyHHp6GFLCQywHcRCZLQxxxrKb36rYUyD1xpGy6gqJXCuP9/2MjJflMqri2
	eit07Dc/9gpGf+XGP29xGqZ5+rSLmp+xk9UxCNpZ8c/h/QeRLW6DzBnjpWLEzqKnHeR+iaiw/wiIn
	4o8Bp0Nr1NbJ1SxfaEbpEutENXrbddvCROf8+74+VaV20RstAjTg+Ef2GFvAuH5ow7GKCaKfamjB5
	SBOfJURX/QkhlEyqMRDpy3WX7PJUIvhUJegwezOefCxAzwtxxp/yc2w3TYLVVf6nVx3UizEElK/RG
	sey/0+WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fhh-0000000DV19-1dpd;
	Fri, 20 Mar 2026 19:40:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fh9-0000000DU8h-2UjX;
	Fri, 20 Mar 2026 19:39:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 891DB61857;
	Fri, 20 Mar 2026 19:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57BFC2BCB4;
	Fri, 20 Mar 2026 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035582;
	bh=Zhv1fm6PGlE9I5DuXJBB0cLrVMXpxk9UQr3R6GGX2pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNEQNMxCWbltp4ulEcA/1pi0w9rAVKrTGQS8+v4PLs+aFYEzztK3IIefy1UFIkuOR
	 rTDQcWY0SioZrCgW7IXmcLKciwKlGXqabHTR/PcPYieqDzBPZ60XqkkxP5s59rZg1A
	 xan9A1ghdC6iIBLyXGYzuD8n0RYMLN+9ymJTqE/THx9LECKRwfgZYXza+nT86iX/k6
	 8p+GKYR5eQNho+Uv+ID2mHduFoCDPEsGOedTudZT9YZBqkya5QuQ6VKpjiS64ChS4F
	 YZzIJnzVkO0R7vQNfDQ1O4zJG1AtpdIzGw2MrsNefJt4teIMi0TcMEfp1mYeAj2lCz
	 AoksKkIoUqu0w==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 25/25] mm: simplify VMA flag tests of excluded flags
Date: Fri, 20 Mar 2026 19:38:42 +0000
Message-ID: <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We have implemented flag mask comparisons of the form:

if ((vm_flags & (VM_FOO|VM_BAR|VM_BAZ) == VM_FOO) { ... }

Like-for-like in the code using a bitwise-and mask via vma_flags_and() and
using vma_flags_same() to ensure the final result equals only the required
flag value.

This is fine but confusing, make things clearer by instead explicitly
excluding undesired flags and including the desired one via tests of the
form:

	if (vma_flags_test(&flags, VMA_FOO_BIT) &&
	    !vma_flags_test_any(&flags, VMA_BAR_BIT, VMA_BAZ_BIT)) { ... }

Which makes it easier to understand what is going on.

No functional change intended.

Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/mprotect.c | 12 ++++--------
 mm/vma.c      |  7 +++----
 mm/vma.h      |  6 ++----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 007d9a72b2f0..110d47a36d4b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -784,14 +784,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
 	 * fault on access.
 	 */
-	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT)) {
-		const vma_flags_t mask =
-			vma_flags_and(&old_vma_flags, VMA_WRITE_BIT,
-				      VMA_SHARED_BIT, VMA_LOCKED_BIT);
-
-		if (vma_flags_same(&mask, VMA_LOCKED_BIT))
-			populate_vma_page_range(vma, start, end, NULL);
-	}
+	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT) &&
+	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT) &&
+	    !vma_flags_test_any(&old_vma_flags, VMA_WRITE_BIT, VMA_SHARED_BIT))
+		populate_vma_page_range(vma, start, end, NULL);
 
 	vm_stat_account(mm, vma_flags_to_legacy(old_vma_flags), -nrpages);
 	newflags = vma_flags_to_legacy(new_vma_flags);
diff --git a/mm/vma.c b/mm/vma.c
index c335f989586f..a4b30a069153 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2343,7 +2343,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
 static bool accountable_mapping(struct mmap_state *map)
 {
 	const struct file *file = map->file;
-	vma_flags_t mask;
 
 	/*
 	 * hugetlb has its own accounting separate from the core VM
@@ -2352,9 +2351,9 @@ static bool accountable_mapping(struct mmap_state *map)
 	if (file && is_file_hugepages(file))
 		return false;
 
-	mask = vma_flags_and(&map->vma_flags, VMA_NORESERVE_BIT, VMA_SHARED_BIT,
-			     VMA_WRITE_BIT);
-	return vma_flags_same(&mask, VMA_WRITE_BIT);
+	return vma_flags_test(&map->vma_flags, VMA_WRITE_BIT) &&
+		!vma_flags_test_any(&map->vma_flags, VMA_NORESERVE_BIT,
+				    VMA_SHARED_BIT);
 }
 
 /*
diff --git a/mm/vma.h b/mm/vma.h
index adc18f7dd9f1..1bfe7e47f6be 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -529,10 +529,8 @@ static inline bool is_data_mapping(vm_flags_t flags)
 
 static inline bool is_data_mapping_vma_flags(const vma_flags_t *vma_flags)
 {
-	const vma_flags_t mask = vma_flags_and(vma_flags,
-			VMA_WRITE_BIT, VMA_SHARED_BIT, VMA_STACK_BIT);
-
-	return vma_flags_same(&mask, VMA_WRITE_BIT);
+	return vma_flags_test(vma_flags, VMA_WRITE_BIT) &&
+		!vma_flags_test_any(vma_flags, VMA_SHARED_BIT, VMA_STACK_BIT);
 }
 
 static inline void vma_iter_config(struct vma_iterator *vmi,
-- 
2.53.0


