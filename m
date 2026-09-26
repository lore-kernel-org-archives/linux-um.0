Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9739C9832F
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXn9QqWZXmGefzT3VQOz3oJvy5MN3Br9p7ifVvOgl7Y=; b=R/DRaR0z3qXmaBJJhKIWf7psLO
	A4/G7w6zAEFTZsE8vNG5c9Z6rPU5NZzh2NxgIYpbBlAxkWzvODAgvpXwXsqLlg6oHHkUoWhLwHsYE
	ygUUDsAglqJhWUKcWLrRg16yqVrvcfHd/dyEH8NcPKJDHJSFuon+EzTbkvQiC3pWGHlyiBpnZDtBJ
	xGpjOYrPJglS1anAyONUz1BCXQGHV1/knhUzBqURRKUSnX7OHuUlwKJBdA0javPjmUy7aYW1uIeYi
	De+YXjE3CN3idIDzHMCHk4ec52qdW/x3aaUeKtTQHg3zGLVwBmmM2N/pAUCoo1hzWyh6fF1OCNxVa
	Z/j5rWlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtz-0000000En9K-1om3;
	Sat, 26 Sep 2026 01:08:31 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtw-0000000En7Q-2iBE
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 01:08:30 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2dd53691be5so9888325ad.1
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384908; x=1790989708; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXn9QqWZXmGefzT3VQOz3oJvy5MN3Br9p7ifVvOgl7Y=;
        b=WSmEqEJn9qJEWHnBC6DOQbKj8GIP+NXYZIqHhUZWcSM80ux2xWVZgxS6rTPTK3WwsA
         fDLP1Md91zTa9mns4aH8a9ac8lm4hCK2Qra4koSm4pZnq95p/NAxZfgkq2w+pSHdzHEf
         ON6q+AyELwjcbfWd0YwZvn3bk6Frz589yiI0hwEdQJfwbXKeK1XI1LNpdBLRPxFQNnKW
         oAnVSk8Vobj9RbP1RxMmEdXXdittgjH5Tg40BsLPcf/N/5v2QOMY5AWIJJ1gJm/lVk0L
         XwXeDikUmkFVaxYTmlu/1p6oJAG9SaSwWY3mvXl2h4qj5cz9IDGdwpTKu9/CyptnaVgE
         ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384908; x=1790989708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXn9QqWZXmGefzT3VQOz3oJvy5MN3Br9p7ifVvOgl7Y=;
        b=I0zBt7I0xNTMSazC02itznkIT9nksWoG/JfcUCDTlj7eXP8G5PMJkJdS/y4IDk6E8N
         BgJkOhl3F7VsUiNa+u1jmOZQN+crq+3I71wK5M1g4nOt1/a36Q7iNZTZKkMQmYX/YTVJ
         VnRopPhAxxpSV9JxRYKT48juZPX4twExEeMY2idu0jeQywly8Y+xNoEs09fW8fnKOYr7
         Y5clPLVtSj+i8wHfIYkgGuAuh1NgUKQyzZAckwsPcOyMlEtUeIccOor6xSu157iHHSML
         Adm3b4CogosNcCNYjeejdBaTRvclhL4Mu4mKpYUJiCF66DRsT1KY4Qpfy5arXVQw2a28
         qkOw==
X-Forwarded-Encrypted: i=1; AKwUvBwW9/ak7kjBRJ8OAmdKzfypl8ceoZ8kKk1KAiO84WwJXsQi3n605hjmYwr671zCWV2a6V2gmFVmHQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nFmR/FIMccjvpQl1cEr0/kWVpEM72ff4qQZw2J28gxL49lFlfJ
	aRxKyL7K9uAsqXrqdCpADqQBI2K9RaxMGko+4L4/ZzVif/YPgpsyXMTMWfkGOS5t
X-Gm-Gg: AYBFou0JjJxqwbEmgyzIX8CSU5alWkd1WwR/aL5KVL3Kz1qri9BQWcaXYE/fwXZ0msw
	hWhueJBCDQokVYto2hJkDHlUUh0yl/lEEAVPFIJHNIvGCb7S3rxKeu7G/1ctDEr7HkbCa0/jWYt
	rBdiqwlJOQCQ2XOwKpB6PNI9rq7WTJztRc+WwDMq/Ajc+bADGhvAPS6wyhK+BiiRGdK5OQ1BWX7
	QiGPmIFQNvvVco9MneIf2XV4ChxkRsKeLzNCqCsHST2AHMJO246Lo2OsYSpgJXRIcyQzAs8ysyv
	Ik4zLu3dEa3YqBkmnRB0HR8QwyopYXS2yU9oUheRPWMw2wuSCKneCDX7vj8PME/ztgKOx/DsiEy
	4mGxZygbuThyMbqhwEPz8Si1hJhxN8hZuwhjkWB1jo+APy4XQibdkzZQ94vusF6x5+aQZ4gpMwl
	uaeJ4zqINqETGE3SA0BpvXXQ+PF0i0PNmU9MODQKHKLpiOBT6uqrt5SDuXAg+jlPGTk8rTbrWbg
	og49CnGTl+UO7Nk8iKlaDVB734qcTCaphJ9r39E9R868ySLQQX+X5uesbnz912P8DomZP/0nQmg
	Zi1GA1rFV8ZjTv1TbBYsGuoiDt82SJc6Grz0jGmuXQDeA7iqkgbXnWVN4SBBQg==
X-Received: by 2002:a17:902:f650:b0:2df:8034:a96a with SMTP id d9443c01a7336-2df9490a9b4mr30665715ad.13.1790384907637;
        Fri, 25 Sep 2026 18:08:27 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91461d38sm17181395ad.76.2026.09.25.18.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:08:27 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 32B6816C9C9A; Sat, 26 Sep 2026 10:08:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH v3 3/3] selftests/nommu: add nommu mmap and mremap behavior tests
Date: Sat, 26 Sep 2026 10:08:19 +0900
Message-ID: <20260926010819.604346-4-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926010819.604346-1-thehajime@gmail.com>
References: <20260926010819.604346-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_180828_714214_192607AD 
X-CRM114-Status: GOOD (  24.15  )
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

Introduce a kselftest utility to validate memory mapping capabilities
under nommu kernels, aligned with
Documentation/admin-guide/mm/nommu-mmap.rst.

The test implements basic checks into a generic architecture-agnostic
test matrix applicable across nommu targets. It evaluates:

1. MAP_FIXED allocation rejections.
2. Standard MAP_PRIVATE and MAP_ANONYMOUS allocation resilience.
3. Regular file mappings via standard filesystem storage.
4. Block device subsystem mappings (gracefully skipping if node is
   missing).
5. Shared vs Private backing discrepancies under nommu conditions.
6. mremap limits, ensuring non-expandable restrictions behave properly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-um@lists.infradead.org
Closes: https://sashiko.dev/#/patchset/20260825015945.141739-1-thehajime@gmail.com
Assisted-by: Gemini:Pro [AI_Reviewer] [Sashiko_Linter]
Assisted-by: cubic.dev:unspecified
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

--

v2 => v3
- remove unnecessary modifications
- address Sashiko review

rfc => v2
- prepare a different TARGETS for tests (mm/nommu)
- drop shrink fix tests
- drop mmap /dev/zero tests
- https://lore.kernel.org/linux-mm/20260825015945.141739-3-thehajime@gmail.com/

rfc:
- https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/
---
 tools/testing/selftests/nommu/Makefile        |   8 +
 tools/testing/selftests/nommu/local.mk        |   7 +
 .../testing/selftests/nommu/nommu_mmap_test.c | 258 +++++++++++++
 .../selftests/nommu/nommu_mremap_test.c       | 362 ++++++++++++++++++
 4 files changed, 635 insertions(+)
 create mode 100644 tools/testing/selftests/nommu/Makefile
 create mode 100644 tools/testing/selftests/nommu/local.mk
 create mode 100644 tools/testing/selftests/nommu/nommu_mmap_test.c
 create mode 100644 tools/testing/selftests/nommu/nommu_mremap_test.c

diff --git a/tools/testing/selftests/nommu/Makefile b/tools/testing/selftests/nommu/Makefile
new file mode 100644
index 000000000000..8e7cd7315c53
--- /dev/null
+++ b/tools/testing/selftests/nommu/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for nommu selftests
+
+TEST_GEN_PROGS += nommu_mmap_test
+TEST_GEN_PROGS += nommu_mremap_test
+
+include ../lib.mk
+include local.mk
diff --git a/tools/testing/selftests/nommu/local.mk b/tools/testing/selftests/nommu/local.mk
new file mode 100644
index 000000000000..0bd1300f00f4
--- /dev/null
+++ b/tools/testing/selftests/nommu/local.mk
@@ -0,0 +1,7 @@
+# detect if users request NOMMU build or not
+# User can set NOMMU to 1 to build/test for NOMMU platforms
+NOMMU ?= 0
+ifeq ($(NOMMU),1)
+CFLAGS += -DNOMMU
+export NOMMU
+endif
diff --git a/tools/testing/selftests/nommu/nommu_mmap_test.c b/tools/testing/selftests/nommu/nommu_mmap_test.c
new file mode 100644
index 000000000000..8d396638da56
--- /dev/null
+++ b/tools/testing/selftests/nommu/nommu_mmap_test.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <limits.h>
+#include "kselftest.h"
+
+#include <sys/vfs.h>
+#ifndef RAMFS_MAGIC
+#define RAMFS_MAGIC 0x858458f6
+#endif
+
+static size_t ps;
+
+struct test_case_t {
+	const char *name;
+	const char *pathname;
+	int open_flags;
+	int mmap_prot;
+	int mmap_flags;
+	int exp_err;
+	int (*resolve_exp_err)(const char *path);
+};
+
+static int get_shm_expected_error(const char *path)
+{
+	struct statfs fs;
+
+	if (statfs(path, &fs) == 0) {
+		if (fs.f_type == RAMFS_MAGIC)
+			return 0; /* ramfs succeed with contiguous memory */
+	}
+	 /* hostfs, etc returns ENODEV due to lack of contiguous allocation */
+	return ENODEV;
+}
+
+static struct test_case_t test_cases[] = {
+	{
+		.name = "anonymous private allocation",
+		.pathname = NULL,
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ | PROT_WRITE,
+		.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
+		.exp_err = 0,
+		.resolve_exp_err = NULL,
+	},
+	{
+		.name = "non-anonymous private file mapping (rw-)",
+		.pathname = "/tmp/ksft.nommu-reg-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ | PROT_WRITE,
+		.mmap_flags = MAP_PRIVATE,
+		.exp_err = 0,
+		.resolve_exp_err = NULL,
+	},
+	{
+		.name = "non-anonymous private file mapping (r--)",
+		.pathname = "/tmp/ksft.nommu-reg-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_PRIVATE,
+		.exp_err = 0,
+		.resolve_exp_err = NULL,
+	},
+	{
+		.name = "non-anonymous shared file mapping (rw-)",
+		.pathname = "/tmp/ksft.nommu-shm-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ | PROT_WRITE,
+		.mmap_flags = MAP_SHARED,
+		.exp_err = 0,
+#ifdef NOMMU
+		.resolve_exp_err = get_shm_expected_error,
+#else
+		.resolve_exp_err = NULL,
+#endif
+	},
+	{
+		.name = "non-anonymous shared file mapping (r--)",
+		.pathname = "/tmp/ksft.nommu-shm-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_SHARED,
+		.exp_err = 0,
+#ifdef NOMMU
+		.resolve_exp_err = get_shm_expected_error,
+#else
+		.resolve_exp_err = 0,
+#endif
+	},
+};
+
+static int run_mapping_matrix_test(struct test_case_t *tcase)
+{
+	int fd;
+	void *ptr;
+	char path_buf[PATH_MAX];
+	const char *path = tcase->pathname;
+	int rc = KSFT_PASS;
+	int expected_error;
+
+	ksft_print_msg("[RUN] Testing: %s\n", tcase->name);
+
+	if (tcase->pathname == NULL) {
+		fd = -1;
+	} else if (strstr(tcase->pathname, "XXXXXX")) {
+		strncpy(path_buf, tcase->pathname, sizeof(path_buf) - 1);
+		path_buf[sizeof(path_buf) - 1] = '\0';
+		fd = mkstemp(path_buf);
+		if (fd < 0) {
+			ksft_test_result_skip("Failed to setup temp node: %s\n",
+					      tcase->pathname);
+			return KSFT_SKIP;
+		}
+		if (ftruncate(fd, ps) != 0) {
+			ksft_test_result_fail("ftruncate failed for: %s\n",
+					      tcase->pathname);
+			close(fd);
+			unlink(path_buf);
+			return KSFT_FAIL;
+		}
+		path = path_buf;
+	} else {
+		fd = open(tcase->pathname, tcase->open_flags, 0600);
+		if (fd < 0) {
+			ksft_test_result_skip("Device node not accessible: %s\n",
+				       tcase->pathname);
+			return KSFT_SKIP;
+		}
+	}
+
+	expected_error = tcase->exp_err;
+	if (tcase->resolve_exp_err && fd >= 0)
+		expected_error = tcase->resolve_exp_err(path);
+
+	ptr = mmap(NULL, ps, tcase->mmap_prot, tcase->mmap_flags, fd, 0);
+
+	if (expected_error != 0) {
+		if (ptr != MAP_FAILED) {
+			ksft_test_result_fail("%s: mmap unexpectedly succeeded (exp error %d)\n",
+					      tcase->name, expected_error);
+			munmap(ptr, ps);
+			rc = KSFT_FAIL;
+			goto cleanup;
+		}
+		if (errno != expected_error) {
+			ksft_test_result_fail("%s: mmap failed with %d (%s), but expected %d\n",
+					      tcase->name, errno, strerror(errno), expected_error);
+			rc = KSFT_FAIL;
+			goto cleanup;
+		}
+		ksft_test_result_pass("%s: Correctly rejected with expected error %s(%d)\n",
+				      tcase->name, strerror(expected_error), expected_error);
+		rc = KSFT_PASS;
+		goto cleanup;
+	}
+
+	if (ptr == MAP_FAILED) {
+		ksft_test_result_fail("%s: mmap failed unexpectedly: %s\n",
+				      tcase->name, strerror(errno));
+		rc = KSFT_FAIL;
+		goto cleanup;
+	}
+
+	ksft_test_result_pass("%s: mmap validation successfully passed\n", tcase->name);
+	munmap(ptr, ps);
+
+cleanup:
+	if (fd >= 0) {
+		close(fd);
+		if (tcase->pathname && strstr(tcase->pathname, "XXXXXX"))
+			unlink(path_buf);
+	}
+	return rc;
+}
+
+static int test_map_fixed(void)
+{
+	void *fixed_addr;
+	void *ptr;
+
+	ksft_print_msg("[RUN] Testing MAP_FIXED behavior\n");
+
+	fixed_addr = mmap(NULL, ps, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (fixed_addr == MAP_FAILED) {
+		ksft_test_result_skip("Unable to reserve test address: %s\n",
+				strerror(errno));
+		return KSFT_SKIP;
+	}
+
+	if (munmap(fixed_addr, ps)) {
+		ksft_test_result_fail("Unable to release test address: %s\n",
+				strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	ptr = mmap(fixed_addr, ps, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+#ifdef NOMMU
+	if (ptr == MAP_FAILED && (errno == ENODEV || errno == EINVAL)) {
+		ksft_test_result_pass("MAP_FIXED correctly rejected under nommu\n");
+		return KSFT_PASS;
+	}
+	if (ptr != MAP_FAILED) {
+		ksft_test_result_fail("MAP_FIXED unexpectedly allowed under nommu\n");
+		munmap(ptr, ps);
+		return KSFT_FAIL;
+	}
+	ksft_test_result_fail("MAP_FIXED failed under NOMMU: %s\n",
+			      strerror(errno));
+	return KSFT_FAIL;
+#else
+	if (ptr != MAP_FAILED) {
+		ksft_test_result_pass("MAP_FIXED successfully allocated under MMU\n");
+		munmap(ptr, ps);
+		return KSFT_PASS;
+	}
+	ksft_test_result_fail("MAP_FIXED failed allocation under MMU\n");
+	return KSFT_FAIL;
+#endif
+}
+
+int main(int argc, char **argv)
+{
+	int result = KSFT_PASS;
+	int i, rc;
+
+	ps = sysconf(_SC_PAGESIZE);
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(test_cases) + 1);
+
+#ifdef NOMMU
+	ksft_print_msg("Running strict MMAP test criteria under nommu architecture\n");
+#else
+	ksft_print_msg("Running MMAP test criteria under MMU architecture\n");
+#endif
+
+	if (test_map_fixed() == KSFT_FAIL)
+		result = KSFT_FAIL;
+
+	for (i = 0; i < (int)ARRAY_SIZE(test_cases); i++) {
+		rc = run_mapping_matrix_test(&test_cases[i]);
+		if (rc == KSFT_FAIL)
+			result = KSFT_FAIL;
+	}
+
+	if (result == KSFT_PASS)
+		ksft_finished();
+
+	ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/nommu/nommu_mremap_test.c b/tools/testing/selftests/nommu/nommu_mremap_test.c
new file mode 100644
index 000000000000..2aaca59085fb
--- /dev/null
+++ b/tools/testing/selftests/nommu/nommu_mremap_test.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <limits.h>
+#include "kselftest.h"
+
+#include <sys/vfs.h>
+#ifndef RAMFS_MAGIC
+#define RAMFS_MAGIC 0x858458f6
+#endif
+
+static size_t ps;
+
+static long get_fs_type(const char *path)
+{
+	struct statfs fs;
+
+	if (statfs(path, &fs) == 0)
+		return fs.f_type;
+
+	return 0;
+}
+
+static void munmap_shrink_test(void)
+{
+	void *addr;
+	int ret;
+
+	/* munmap shrink test */
+	for (int i = 0; i < 4; i++) {
+		addr = mmap(NULL, ps * 4, PROT_READ | PROT_WRITE,
+			    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+		if (addr == MAP_FAILED) {
+			ksft_test_result_fail("mmap failed: %s(%d)\n", strerror(errno), errno);
+			return;
+		}
+		ret = munmap((char *)addr + ps * i, ps);
+		if (ret != 0) {
+			ksft_test_result_fail("memory %p isn't unmapped at %p\n",
+					addr, (char *)addr + ps * i);
+			return;
+		}
+
+		if (i == 0) {
+			if (munmap(addr +  ps, ps * 3))
+				goto error;
+		} else if (i == 1) {
+			if (munmap(addr, ps) || munmap(addr + (ps * 2), ps * 2))
+				goto error;
+		} else if (i == 2) {
+			if (munmap(addr, ps * 2) || munmap(addr + (ps * 3), ps))
+				goto error;
+		} else if (i == 3) {
+			if (munmap(addr, ps * 3))
+				goto error;
+		}
+	}
+
+	ksft_test_result_pass("%s success\n", __func__);
+	return;
+error:
+	for (int j = 0; j < 4; j++)
+		munmap((char *)addr + j * ps, ps);
+	ksft_test_result_fail("%s clean up failures\n", __func__);
+}
+
+static size_t page_align(size_t len)
+{
+	return (len + ps - 1) / ps * ps;
+}
+
+static void mremap_shrink_test(void)
+{
+	void *addr, *addr2;
+	size_t current_len;
+	size_t old_len, new_len;
+	struct param {
+		size_t old;
+		size_t new;
+	} params[] = {
+		/* should not happen any shrink */
+		{ .old = ps * 4 - 1, .new = ps * 4 - 2 },
+		/* should not happen any shrink */
+		{ .old = ps * 4 - 1, .new = ps * 4 },
+		{ .old = ps * 4, .new = ps * 2 },
+		/* should not happen any shrink */
+		{ .old = ps * 2, .new = ps * 2 - 2 },
+		{ .old = ps * 2 - 2, .new = ps * 1 },
+	};
+
+	/* mremap shrink test */
+	current_len = page_align(ps * 4 - 1);
+	addr = mmap(NULL, ps * 4 - 1, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (addr == MAP_FAILED) {
+		ksft_test_result_fail("mmap failed: %s(%d)\n", strerror(errno), errno);
+		return;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(params); i++) {
+		old_len = params[i].old;
+		new_len = params[i].new;
+		current_len = page_align(new_len);
+		addr2 = mremap(addr, old_len, new_len, MREMAP_MAYMOVE);
+		if (addr2 == MAP_FAILED) {
+			ksft_test_result_fail("memory %p isn't remapped at %p\n", addr, addr2);
+			munmap(addr, page_align(old_len));
+			return;
+		}
+
+		addr = addr2;
+	}
+
+	if (munmap(addr, current_len)) {
+		ksft_test_result_fail("%s cleanup failed: %s\n",
+				      __func__, strerror(errno));
+		return;
+	}
+	ksft_test_result_pass("%s success\n", __func__);
+}
+
+static int get_shared_writable_file_expected_error(const char *path)
+{
+	if (get_fs_type(path) == RAMFS_MAGIC)
+		return EPERM; /* ramfs failed */
+
+	return 0;
+}
+
+struct mremap_case_t {
+	const char *name;
+	const char *pathname;
+	int open_flags;
+	int mmap_prot;
+	int mmap_flags;
+	int exp_err;
+	int (*resolve_exp_err)(const char *path);
+	unsigned int old_pages;
+	unsigned int new_pages;
+};
+
+static struct mremap_case_t mremap_cases[] = {
+	{
+		.name = "anonymous shrink (r--)",
+		.pathname = NULL,
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
+		.exp_err = 0,
+		.resolve_exp_err = 0,
+	},
+	{
+		.name = "shared file shrink (r--)",
+		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_SHARED,
+		.exp_err = 0,
+#ifdef NOMMU
+		.resolve_exp_err = get_shared_writable_file_expected_error,
+#else
+		.resolve_exp_err = 0,
+#endif
+	},
+	{
+		.name = "private file unchanged length (r-)",
+		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_PRIVATE,
+#ifdef NOMMU
+		.exp_err = EPERM,
+#else
+		.exp_err = 0,
+#endif
+		.resolve_exp_err = 0,
+		.old_pages = 4,
+		.new_pages = 4,
+	},
+	{
+		.name = "private file unchanged length (rw-)",
+		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ | PROT_WRITE,
+		.mmap_flags = MAP_PRIVATE,
+		.exp_err = 0,
+		.resolve_exp_err = 0,
+		.old_pages = 4,
+		.new_pages = 4,
+	},
+	{
+		.name = "private file growth (r-)",
+		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ,
+		.mmap_flags = MAP_PRIVATE,
+#ifdef NOMMU
+		.exp_err = EPERM,
+#else
+		.exp_err = 0,
+#endif
+		.resolve_exp_err = 0,
+		.old_pages = 4,
+		.new_pages = 8,
+	},
+	{
+		.name = "private file growth (rw-)",
+		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
+		.open_flags = O_CREAT | O_RDWR | O_EXCL,
+		.mmap_prot = PROT_READ | PROT_WRITE,
+		.mmap_flags = MAP_PRIVATE,
+#ifdef NOMMU
+		.exp_err = ENOMEM,
+#else
+		.exp_err = 0,
+#endif
+		.resolve_exp_err = 0,
+		.old_pages = 4,
+		.new_pages = 8,
+	},
+};
+
+static int run_mremap_test(struct mremap_case_t *tcase)
+{
+	int fd = -1;
+	void *addr, *addr2;
+	char pb[PATH_MAX];
+	const char *path = tcase->pathname;
+	int rc = KSFT_PASS;
+	int expected_error;
+	unsigned int old_pages = tcase->old_pages ?: 4;
+	unsigned int new_pages = tcase->new_pages ?: 2;
+	unsigned int file_pages = old_pages > new_pages ?
+				  old_pages : new_pages;
+
+	ksft_print_msg("[RUN] Testing mremap: %s\n", tcase->name);
+
+	if (tcase->pathname && strstr(tcase->pathname, "XXXXXX")) {
+		strncpy(pb, tcase->pathname, sizeof(pb) - 1);
+		pb[sizeof(pb) - 1] = '\0';
+		fd = mkstemp(pb);
+		if (fd < 0) {
+			ksft_test_result_skip("Failed to setup file backing\n");
+			return KSFT_SKIP;
+		}
+		if (ftruncate(fd, ps * file_pages) != 0) {
+			ksft_test_result_fail("Failed to setup file backing\n");
+			close(fd);
+			unlink(pb);
+			return KSFT_FAIL;
+		}
+
+#ifdef NOMMU
+		if ((tcase->mmap_flags & MAP_SHARED) && get_fs_type(pb) != RAMFS_MAGIC) {
+			ksft_test_result_skip("Skip the test under non-ramfs filesystem (%s)\n",
+					      pb);
+			close(fd);
+			unlink(pb);
+			return KSFT_SKIP;
+		}
+#endif
+		path = pb;
+	} else if (tcase->pathname) {
+		fd = open(tcase->pathname, tcase->open_flags, 0600);
+		if (fd < 0) {
+			ksft_test_result_skip("Backing node not accessible\n");
+			return KSFT_SKIP;
+		}
+
+#ifdef NOMMU
+		if ((tcase->mmap_flags & MAP_SHARED) &&
+		    get_fs_type(tcase->pathname) != RAMFS_MAGIC) {
+			ksft_test_result_skip("Skip the test under non-ramfs filesystem (%s)\n",
+					      tcase->pathname);
+			close(fd);
+			return KSFT_SKIP;
+		}
+#endif
+	}
+
+	addr = mmap(NULL, ps * old_pages, tcase->mmap_prot,
+		    tcase->mmap_flags, fd, 0);
+	if (addr == MAP_FAILED) {
+		ksft_print_msg("mmap mapping failed %s(%d)\n", strerror(errno), errno);
+		rc = KSFT_FAIL;
+		goto out;
+	}
+
+	expected_error = tcase->exp_err;
+	if (tcase->resolve_exp_err && fd >= 0)
+		expected_error = tcase->resolve_exp_err(path);
+
+	addr2 = mremap(addr, ps * old_pages, ps * new_pages,
+		       MREMAP_MAYMOVE);
+
+	if (expected_error != 0) {
+		if (addr2 != MAP_FAILED) {
+			ksft_print_msg("Expected error %d, but mremap unexpectedly succeeded\n",
+				       expected_error);
+			rc = KSFT_FAIL;
+		} else if (errno != expected_error) {
+			ksft_print_msg("Expected error %d, got %s(%d)\n",
+				       expected_error, strerror(errno), errno);
+			rc = KSFT_FAIL;
+		} else {
+			ksft_print_msg("%s/%s: Handled expected error path (errno=%d)\n",
+				       __func__, tcase->name, expected_error);
+		}
+	} else if (addr2 == MAP_FAILED) {
+		ksft_print_msg("mremap shrink failed unexpectedly: %s\n",
+			       strerror(errno));
+		rc = KSFT_FAIL;
+	} else {
+		ksft_print_msg("%s/%s step successful\n", __func__, tcase->name);
+	}
+
+	/* clean up */
+	if (munmap(addr2 == MAP_FAILED ? addr : addr2,
+		   addr2 == MAP_FAILED ? ps * old_pages : ps * new_pages)) {
+		ksft_print_msg("munmap failed: %s\n", strerror(errno));
+		rc = KSFT_FAIL;
+	}
+
+out:
+	if (fd >= 0) {
+		close(fd);
+		if (tcase->pathname && strstr(tcase->pathname, "XXXXXX"))
+			unlink(pb);
+	}
+
+	ksft_test_result_report(rc, "%s:%s\n", __func__, tcase->name);
+	return rc;
+}
+
+int main(int argc, char **argv)
+{
+	int res = KSFT_PASS;
+	int i;
+
+	ps = sysconf(_SC_PAGESIZE);
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(mremap_cases) + 2);
+
+	munmap_shrink_test();
+	mremap_shrink_test();
+
+	for (i = 0; i < (int)ARRAY_SIZE(mremap_cases); i++) {
+		if (run_mremap_test(&mremap_cases[i]) == KSFT_FAIL)
+			res = KSFT_FAIL;
+	}
+
+	if (res == KSFT_PASS)
+		ksft_finished();
+
+	ksft_exit_fail();
+}
-- 
2.43.0


