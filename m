Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50700C5B572
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rl6igOnyCyLcIUIdrNjrR0vSvz5V+iB+/lHA2MvB5zU=; b=MlFbpiRatXAelqFCpQn5/nFjGJ
	ImBL2GVMMzhMdTxQ4gt6uuE091zouaxrfED0b8tK1G/r0pMeQaMBnOxyL+Xdl78wrUIQnPI/QzEvr
	l7A4N8oCxtaYg3QDQXFhnftGUnTaNAcDIsw9xSzjdTsZdUkTkvPUYo92HGFyJJApi2Zk7bTdUtyu0
	QlOkbsv+1TKpdHD8C0OyJAMB9M2jLPBX390Pfxo//q33V8GCcd3vY/rC2LPCE6WgzgS7on+4eCOlj
	OTYeD/Zc6wk6Ut/L/D7jZQSm6RbpaT7yZbOcAoBRoHOYqwgqBfYuLLTQk8ipv5U79Eg76qCcIDq43
	Cdk+heFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuP16-0000000HU9K-175S;
	Thu, 13 Aug 2026 06:34:16 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuP13-0000000HU8Y-18Kr
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 06:34:14 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1631798a91.1
        for <linux-um@lists.infradead.org>; Wed, 12 Aug 2026 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786602852; x=1787207652; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rl6igOnyCyLcIUIdrNjrR0vSvz5V+iB+/lHA2MvB5zU=;
        b=abMqOD+K8SFHM2JZ2yHc/NUNvgAV4R78oaiwsOHyLWK/gWfDqvVuKkZZpXbEPILIjl
         ZRDgxTPXypICmBnXIHeD/O/y6AO/XjyFFtSmE3F2drVRvPymTLp4yvMlJ7zEV8lutyXy
         zlUZF/+XQmgF76L/9Zga44TJDwzgyf2I7g+oDbiWo3DYhE++B0OLIFMpNKiEfZRjyNeH
         E6hF1PFVF7tQ9EnmTOk/nTrmDwAuPDrUPHjns6bTa3gi0QQjoMqj+PAlhSgiLOt+OcuY
         Jtpj7ajXaNkw/PQqYQ890eb0kb/ro8AIyxSUwPbE6SkYfJp6ZC7ssno1nX0Skw5rpe9L
         SB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786602852; x=1787207652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rl6igOnyCyLcIUIdrNjrR0vSvz5V+iB+/lHA2MvB5zU=;
        b=T8AHmr6TwB9kvIDvGGYyah3d/jePiSVRCUiYFzVCdwE0u2hVDansi8ZinNkbp3RHh+
         402WLkgoDxJEjuYh6YqV6Np+zbiXazl90wdONl5F1Y4/ukI4RX06/UmFU3Wv4YKNpbPQ
         x0lwrQH3UZrBrr5Hg5XYoRfGvuNBdLGT35PpTMWLYMSuICQwLjxBRwxBDpETBuZyONd/
         u4P4n8nkOlacU7qqlR1389sWYp9hAcHakzSdXa4WdmE9Ch/UYMfZSyljPjOVHBH/DW42
         fA56YWazPfc5YwWFjN/JkcX7phSw9Qzuw7p3taYrOCkH9XzTawg3qykxU6GAKaD5FNu2
         GRLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLi70ejT3v5MUoXoqA9+cfqY5jY24qldDxT1wty7Jhh+zB9VB76k1tvWW5XQmyxDckbNLJ4VITdQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+jwEi7FX/TMkIWGHuD7ffqRIeNTWuopD16QXFjxoqAXJEW8ht
	L4/3Jxsl3ETnbF2INxovxxyPs9iW3H2DVPMc1pObRJL04HFtMqqQZlUh
X-Gm-Gg: AR+sD10ctjI7LU/Jl/rVAZx0yG32f+gB71BZVfemIRTRs3I/QeVplCnUoZ9r1NL3LSq
	LE8LQiXtx/WeZ3OWwxH4AqSs5SLta7BZnR8tGL92os/4bdSl6Ks0QeibUqxI9RGIf7E20sXl2hY
	A+xhwwldNWVbcRJXJ6LmfnO4a4K9qEur9fauwh1O0NSzHNz2lZCs6fXy1wRJ+jIG4AkII3oHAPF
	x+ZJ7thHkeGeJrid/lRia6Gqpmht8O+Cumi15tRc9kIyfxdpEw7IwG46/7jojz8DEtoqaG7v1T5
	9uUqg2CB7OyCBqcGiPk+jWVwyE5XLMX8w1vOT5Q3TqC0M9YM30eWW4bRmAHKsGBaGlmfn6K1p2y
	FD60Qu6bjAGA4R93NFNNoIvYZ82eWbpd5mn0ZkvDmcYyihDAUk2hT54hgvZ3WHMibAJUhqN6Y/3
	Vl5Ka+leGvc0ER/IOCFJxO0AFZfAODRct6ehmp0r6ZfCb8tRrLDCdZcA/RLCDj5mw2yh/380v9k
	Ewtzn9HEuyEBNC8sKgsyi1xKQfqqHMYXy9ToOgfCzkr+y5hFcGHfRYGTwZt7urekQ==
X-Received: by 2002:a17:90b:52cf:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3931e29780bmr3917272a91.14.1786602852144;
        Wed, 12 Aug 2026 23:34:12 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44dcbbsm1650400a91.16.2026.08.12.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:34:11 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A203E15B0431; Thu, 13 Aug 2026 15:34:10 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [RFC PATCH 4/6] selftests: fix build errors on alpine linux
Date: Thu, 13 Aug 2026 15:33:59 +0900
Message-ID: <20260813063401.1786548-5-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813063401.1786548-1-thehajime@gmail.com>
References: <20260813063401.1786548-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_233413_367371_28F0E750 
X-CRM114-Status: GOOD (  15.90  )
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

Some nommu architectures only work on Alpine Linux, which doesn't use
glibc for the standard library.  It uses musl-libc and is implemented in
a different way as glibc, resulting build failures.

This commit fixes this issue by adding missing definitions. The fixes
are now only covered to TARGETS=mm which was tested for the moment;
future contributions are needed to fully build/execute tests on nommu
platforms.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-um@lists.infradead.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/testing/selftests/kselftest.h      | 43 ++++++++++++++++++++++++
 tools/testing/selftests/lib.mk           |  2 +-
 tools/testing/selftests/mm/hugetlb_dio.c |  8 ++---
 tools/testing/selftests/mm/mdwe_test.c   |  4 +--
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index ae18c491ae53..ac21bf3d802e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -58,6 +58,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
+#include <stdint.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -81,6 +82,48 @@
 #endif
 #endif /* end arch */
 
+#if !defined(NOLIBC) && !defined(__GLIBC__)
+#ifdef __LP64__
+typedef int64_t __fsword_t;
+#else
+typedef int32_t __fsword_t;
+#endif
+
+/*
+ * for a workaround to avoid struct conflict under
+ * musl-libc (<sys/prctl.h> v.s. <linux/prctl.h>)
+ */
+#include <sys/prctl.h>
+#ifndef _LINUX_PRCTL_H
+#define _LINUX_PRCTL_H
+#endif
+
+#ifndef PR_SET_MDWE
+#define PR_SET_MDWE 65
+#endif
+
+#ifndef PR_MDWE_REFUSE_EXEC_GAIN
+#define PR_MDWE_REFUSE_EXEC_GAIN (1UL << 0)
+#endif
+
+#ifndef PR_MDWE_NO_INHERIT
+#define PR_MDWE_NO_INHERIT (1UL << 1)
+#endif
+
+#ifndef PR_GET_MDWE
+#define PR_GET_MDWE 66
+#endif
+
+#ifndef PR_SET_MEMORY_MERGE
+#define PR_SET_MEMORY_MERGE 67
+#endif
+
+#ifndef PR_GET_MEMORY_MERGE
+#define PR_GET_MEMORY_MERGE 68
+#endif
+
+#endif
+
 /* define kselftest exit codes */
 #define KSFT_PASS  0
 #define KSFT_FAIL  1
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index f02cc8a2e4ae..2cc819006424 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -197,7 +197,7 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
 # Build with _GNU_SOURCE by default
-CFLAGS += -D_GNU_SOURCE=
+CFLAGS += -D_GNU_SOURCE= -D_LARGEFILE64_SOURCE
 
 # Additional include paths needed by kselftest.h and local headers
 CFLAGS += -I${top_srcdir}/tools/testing/selftests
diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index fb4600570e13..aee6be530ccb 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -22,12 +22,9 @@
 #include "kselftest.h"
 #include "hugepage_settings.h"
 
-#ifndef STATX_DIOALIGN
-#define STATX_DIOALIGN		0x00002000U
-#endif
-
 static int get_dio_alignment(int fd)
 {
+#ifdef STATX_DIOALIGN
 	struct statx stx;
 	int ret;
 
@@ -43,6 +40,9 @@ static int get_dio_alignment(int fd)
 		return 1;
 
 	return stx.stx_dio_offset_align;
+#else
+	return -1;
+#endif
 }
 
 static bool check_dio_alignment(unsigned int start_off,
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 647779653da0..031c79ed067e 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "kselftest_harness.h"
+
 #ifdef __aarch64__
 #include <asm/hwcap.h>
 #endif
@@ -14,8 +16,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "kselftest_harness.h"
-
 #ifndef __aarch64__
 # define PROT_BTI	0
 #endif
-- 
2.43.0


