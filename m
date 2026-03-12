Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C68C106ACE0
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyNOJRFBn6GYecjz/uIi6J1r7bpamrPl/8rZmvXcRyc=; b=Re/aDvcOormpgvDVYm9GK7xLPB
	J1UBTMWOhxreP3RL4dlG1XZ2uyCO6SIVSUOc971Otv+82pS+LU12g7ATYgthWPSFdMJrkFNf0o8Lm
	sQhx80NWY5Qc7gg2H8TN3ppFhBTS/obFy7WGxwQOwn8MUcSgnqF2o/q/U8y9GeuWpmsQ7GQJmnsP3
	i1ykYFeM1Cj/VpPdJIcY7RFI0WKF2QTIu0cn/6zfF0arSHDQsts6ieO9iq4s/wEzKmr06rN6d0Uc0
	+SvNgcfyz53Awe7rN7ZTK252+8YmkmiT6NHQTaKugH7THjmxMtrI536SMT3x2pfUUiaQAgnFrrq6Q
	sSGiAfBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWY-0000000F0oH-3RZI;
	Thu, 12 Mar 2026 19:16:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWU-0000000F0hg-1PKW;
	Thu, 12 Mar 2026 19:16:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C91E944504;
	Thu, 12 Mar 2026 19:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E70C2BC86;
	Thu, 12 Mar 2026 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343001;
	bh=bmvUDjwEogjDbOSJi1Au4cu8FeNepAROkOURcG3tLdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mD8due7j6LcH1JQ77FvTm2O64To7W0qOMNPmhfFPikEgImXxT3veeh3L41ScCRDBh
	 hmg4qqqniVoHcKkT7m8O5H+mumGm8N4zmYge7Opsa8Ce/9GDHTedwhM9/CUSKMWgwY
	 IU6e/CBYw2NRKVOVFqQ2bgGlpInKV5G+fS4rkhtPIgTgj/deO9vmVz7mlvAjgVC+y0
	 7ims1tNWR6jHJF5nM+CJQxylOO6k9izJWD84PHMXlW2lamVOJSdsyjSiiiJAPNBn3k
	 Gtips/dqUFGzguPMfBbLSaJzhO9FYdS+kBwGG+aI/v6lVZ5+gEbRp5AK402grOd7TP
	 H8o+1/QbaQGqw==
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
Subject: [PATCH 03/20] mm/vma: add further vma_flags_t unions
Date: Thu, 12 Mar 2026 19:16:01 +0000
Message-ID: <cd3f6777c6a11a425ce5e249a5d315448e954b46.1773342102.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773342102.git.ljs@kernel.org>
References: <cover.1773342102.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_121642_429953_20AA33CD 
X-CRM114-Status: GOOD (  12.31  )
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

In order to utilise the new vma_flags_t type, we currently place it in
union with legacy vm_flags fields of type vm_flags_t to make the transition
smoother.

Add vma_flags_t union entries for mm->def_flags and vmg->vm_flags -
mm->def_vma_flags and vmg->vma_flags respectively.

Once the conversion is complete, these will be replaced with vma_flags_t
entries alone.

Also update the VMA tests to reflect the change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm_types.h        | 6 +++++-
 mm/vma.h                        | 6 +++++-
 tools/testing/vma/include/dup.h | 5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ad414ff2d815..ea76821c01e3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1262,7 +1262,11 @@ struct mm_struct {
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 		unsigned long stack_vm;	   /* VM_STACK */
-		vm_flags_t def_flags;
+		union {
+			/* Temporary while VMA flags are being converted. */
+			vm_flags_t def_flags;
+			vma_flags_t def_vma_flags;
+		};
 
 		/**
 		 * @write_protect_seq: Locked when any thread is write
diff --git a/mm/vma.h b/mm/vma.h
index eba388c61ef4..cf8926558bf6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -98,7 +98,11 @@ struct vma_merge_struct {
 	unsigned long end;
 	pgoff_t pgoff;
 
-	vm_flags_t vm_flags;
+	union {
+		/* Temporary while VMA flags are being converted. */
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	struct file *file;
 	struct anon_vma *anon_vma;
 	struct mempolicy *policy;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 2f53c27ddb21..faaf1239123d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -33,7 +33,10 @@ struct mm_struct {
 	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 	unsigned long stack_vm;	   /* VM_STACK */
 
-	unsigned long def_flags;
+	union {
+		vm_flags_t def_flags;
+		vma_flags_t def_vma_flags;
+	};
 
 	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
 };
-- 
2.53.0


