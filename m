Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A99106ACE4
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 19:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McqqJ/O8xeq2UYW4/r1rFqCQDgZ0JT5zmWWDDok3uPA=; b=o443JArKf28NJKS6ULH7xx5l/B
	YAQ55+J1E8EZqEiC+Q7sG7a4Z9MV20mZIJBDtNN6TPNpyRBA+NpDXGI9BfJNb0il+OwPVaHfxFAe+
	T778DbgmwrEc1cpFNA6aoeN4cnUP/i2sXg+9Ksm/cLaOupH9rKfpftwbsExExiKTkhahEBzz5IO5v
	H0XXs49ljCdzQ2r1HrLn3QXpV8rhnh8gBtfd6vdqAcKDySnB9cC5bUPMzkXqcjeRgb0idj7Wvlszv
	05RviBmlpzgmrzZ8N6r2l2jHX3Eo2FUaAupZpTNnbFk5Tb/ChPOr6mCvCZq0X8bxis4NSi3v5Uk2k
	N66/9SUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWV-0000000F0jz-2pwl;
	Thu, 12 Mar 2026 19:16:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWS-0000000F0f6-0Kcd;
	Thu, 12 Mar 2026 19:16:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 203C243846;
	Thu, 12 Mar 2026 19:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B16C4CEF7;
	Thu, 12 Mar 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773342999;
	bh=dOhA+5iQB+SVk3yKxpjhcrfP4J4hd8DO2zJWxNY1VQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZVl7VhP+ZhdqtYKU95GS3nRBzwKOP5dwpy7OeaQgaWYInVFoyC/DFoBv7wF/Jh30
	 mcDQDXSTkq2ibPeX5Zb+GgvEsvxPTgeyEThEZ++xP6qftVS9O8qNvRGns+sGAZs+BN
	 L/Y1HdYaSVaSrAYWcTasLl3A+yku/gOuQfmEQVsYeZek+ouroxSo/33jJLbGwCytU9
	 7/rqz/f1SLProBktpoAz20+C6zFH2Sfj6o9msoS71nwiTxlN3h5h3TLapL5qyjG45M
	 d7ZVFRig357jA8G32biuKQkqqEBP9Qgmhr+19SQ6FseLCX3+x953NX/CxxrMJfuWBL
	 w68pcaPc5NuTw==
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
Subject: [PATCH 02/20] tools/testing/vma: add unit tests for vma_flags_[empty, diff_pair, and]()
Date: Thu, 12 Mar 2026 19:16:00 +0000
Message-ID: <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773340636.git.ljs@kernel.org>
References: <cover.1773340636.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_121640_182740_F0DB8FF9 
X-CRM114-Status: GOOD (  14.32  )
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

Add VMA unit tests to assert that:

* vma_flags_empty()
* vma_flags_diff_pair()
* vma_flags_and_mask()
* vma_flags_and()

All function as expected.

In additional to the added tests, in order to make testing easier, add
vma_flags_same_mask() and vma_flags_same() for testing only. If/when these
are required in kernel code, they can be moved over.

Also add ASSERT_FLAGS_[NOT_]SAME[_MASK](), ASSERT_FLAGS_[NON]EMPTY() test
helpers to make asserting flag state easier and more convenient.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/include/custom.h |  12 +++
 tools/testing/vma/shared.h         |  18 ++++
 tools/testing/vma/tests/vma.c      | 137 +++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 833ff4d7f799..ce056e790817 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -118,3 +118,15 @@ static __always_inline vma_flags_t __mk_vma_flags(size_t count,
 			vma_flags_set_flag(&flags, bits[i]);
 	return flags;
 }
+
+/* Place here until needed in the kernel code. */
+static __always_inline bool vma_flags_same_mask(vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
index 6c64211cfa22..e2e5d6ef6bdd 100644
--- a/tools/testing/vma/shared.h
+++ b/tools/testing/vma/shared.h
@@ -35,6 +35,24 @@
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define ASSERT_FLAGS_SAME_MASK(_flags, _flags_other) \
+	ASSERT_TRUE(vma_flags_same_mask((_flags), (_flags_other)))
+
+#define ASSERT_FLAGS_NOT_SAME_MASK(_flags, _flags_other) \
+	ASSERT_FALSE(vma_flags_same_mask((_flags), (_flags_other)))
+
+#define ASSERT_FLAGS_SAME(_flags, ...) \
+	ASSERT_TRUE(vma_flags_same(_flags, __VA_ARGS__))
+
+#define ASSERT_FLAGS_NOT_SAME(_flags, ...) \
+	ASSERT_FALSE(vma_flags_same(_flags, __VA_ARGS__))
+
+#define ASSERT_FLAGS_EMPTY(_flags) \
+	ASSERT_TRUE(vma_flags_empty(_flags))
+
+#define ASSERT_FLAGS_NONEMPTY(_flags) \
+	ASSERT_FALSE(vma_flags_empty(_flags))
+
 #define IS_SET(_val, _flags) ((_val & _flags) == _flags)
 
 extern bool fail_prealloc;
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index f6edd44f4e9e..4a7b11a8a285 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -363,6 +363,140 @@ static bool test_vma_flags_clear(void)
 	return true;
 }
 
+/* Ensure that vma_flags_empty() works correctly. */
+static bool test_vma_flags_empty(void)
+{
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					 VMA_EXEC_BIT, 64, 65);
+
+	ASSERT_FLAGS_NONEMPTY(&flags);
+	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_FLAGS_NONEMPTY(&flags);
+	vma_flags_clear(&flags, 64, 65);
+	ASSERT_FLAGS_EMPTY(&flags);
+#else
+	ASSERT_FLAGS_EMPTY(&flags);
+#endif
+
+	return true;
+}
+
+/* Ensure that vma_flags_diff_pair() works correctly. */
+static bool test_vma_flags_diff(void)
+{
+	vma_flags_t flags1 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					  VMA_EXEC_BIT, 64, 65);
+	vma_flags_t flags2 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					  VMA_EXEC_BIT, VMA_MAYWRITE_BIT,
+					  VMA_MAYEXEC_BIT, 64, 65, 66, 67);
+	vma_flags_t diff = vma_flags_diff_pair(&flags1, &flags2);
+
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_FLAGS_SAME(&diff, VMA_MAYWRITE_BIT, VMA_MAYEXEC_BIT, 66, 67);
+#else
+	ASSERT_FLAGS_SAME(&diff, VMA_MAYWRITE_BIT, VMA_MAYEXEC_BIT);
+#endif
+	/* Should be the same even if re-ordered. */
+	diff = vma_flags_diff_pair(&flags2, &flags1);
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_FLAGS_SAME(&diff, VMA_MAYWRITE_BIT, VMA_MAYEXEC_BIT, 66, 67);
+#else
+	ASSERT_FLAGS_SAME(&diff, VMA_MAYWRITE_BIT, VMA_MAYEXEC_BIT);
+#endif
+
+	/* Should be no difference when applied against themselves. */
+	diff = vma_flags_diff_pair(&flags1, &flags1);
+	ASSERT_FLAGS_EMPTY(&diff);
+	diff = vma_flags_diff_pair(&flags2, &flags2);
+	ASSERT_FLAGS_EMPTY(&diff);
+
+	/* One set of flags against an empty one should equal the original. */
+	flags2 = EMPTY_VMA_FLAGS;
+	diff = vma_flags_diff_pair(&flags1, &flags2);
+	ASSERT_FLAGS_SAME_MASK(&diff, flags1);
+
+	/* A subset should work too. */
+	flags2 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);
+	diff = vma_flags_diff_pair(&flags1, &flags2);
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_FLAGS_SAME(&diff, VMA_EXEC_BIT, 64, 65);
+#else
+	ASSERT_FLAGS_SAME(&diff, VMA_EXEC_BIT);
+#endif
+
+	return true;
+}
+
+/* Ensure that vma_flags_and() and friends work correctly. */
+static bool test_vma_flags_and(void)
+{
+	vma_flags_t flags1 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					  VMA_EXEC_BIT, 64, 65);
+	vma_flags_t flags2 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					  VMA_EXEC_BIT, VMA_MAYWRITE_BIT,
+					  VMA_MAYEXEC_BIT, 64, 65, 66, 67);
+	vma_flags_t flags3 = mk_vma_flags(VMA_IO_BIT, VMA_MAYBE_GUARD_BIT,
+					  68, 69);
+	vma_flags_t and = vma_flags_and_mask(&flags1, flags2);
+
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			  64, 65);
+#else
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+#endif
+
+	and = vma_flags_and_mask(&flags1, flags1);
+	ASSERT_FLAGS_SAME_MASK(&and, flags1);
+
+	and = vma_flags_and_mask(&flags2, flags2);
+	ASSERT_FLAGS_SAME_MASK(&and, flags2);
+
+	and = vma_flags_and_mask(&flags1, flags3);
+	ASSERT_FLAGS_EMPTY(&and);
+	and = vma_flags_and_mask(&flags2, flags3);
+	ASSERT_FLAGS_EMPTY(&and);
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT);
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT);
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+
+#if NUM_VMA_FLAG_BITS > 64
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			    64);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			    64, 65);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64,
+			  65);
+#endif
+
+	/* And against some missing values. */
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			    VMA_IO_BIT);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			    VMA_IO_BIT, VMA_RAND_READ_BIT);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+
+#if NUM_VMA_FLAG_BITS > 64
+	and = vma_flags_and(&flags1, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT,
+			    VMA_IO_BIT, VMA_RAND_READ_BIT, 69);
+	ASSERT_FLAGS_SAME(&and, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+#endif
+
+	return true;
+}
+
 static void run_vma_tests(int *num_tests, int *num_fail)
 {
 	TEST(copy_vma);
@@ -372,4 +506,7 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(vma_flags_test);
 	TEST(vma_flags_test_any);
 	TEST(vma_flags_clear);
+	TEST(vma_flags_empty);
+	TEST(vma_flags_diff);
+	TEST(vma_flags_and);
 }
-- 
2.53.0


