Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1256CD1283
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6awg/8K1Xi+mqR//7IBqBOHFuznw79ZK+S7TPwk0wM=; b=Xx4MxxpROkifeleLNdKa0aTG2n
	vaSNWn6nWtUTsBrgw2xKIAigsxI8hbT2TyvsiXtMa4aycZMl6VrpiTdt8yo8cZrPa29/SCHoDyVyp
	kh/XMKm3SoDrxzBq+yU6aNmMOqxL0inMSLIHbNfJc3knGVLf+NCRWlkbNE9YHYsw5TrOlkpMDyzef
	nFRlB29xhB8F6ozFO45YHdU4ZXA/og4fFTHJQRKsgcXDESDOFsLFimdQOjBroStCfq7Iza+6zBAFC
	Z0tIbCDmiZ4wHK8yvyZ1hqf8RGCIu/sgmOZHjtF7bmVyYf9NKQ9wmvpd5aQXjxZndvY/IPzXK4Ru6
	2gc8mmTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp3T7-00000003u3D-1tvm;
	Tue, 26 Mar 2024 09:51:45 +0000
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp3T3-00000003tzx-1GAW
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 09:51:43 +0000
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3lST28FvzNkr;
	Tue, 26 Mar 2024 10:51:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711446697;
	bh=pBMis6waGtJRvazqv7DmqZ/uoc/dd8l3LTTdLpiJnSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcTiXieDNEC8hrQOmhiQwYuzDC/abUeUVkm+eGtlEKIbs1DqKddPBomjStsLx5Pof
	 +GBBH894Fathn8a8uU0APDC9BeGyyIuewqaT5TjDoEJ8faSPu6yb5HQvClE1zGYZwF
	 rSYthP6yna4iQmxh7yqy/TZhYY1Oi2PuTwNzpp1U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3lSS4QkWzJRS;
	Tue, 26 Mar 2024 10:51:36 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 2/7] kunit: Fix kthread reference
Date: Tue, 26 Mar 2024 10:51:13 +0100
Message-ID: <20240326095118.126696-3-mic@digikod.net>
In-Reply-To: <20240326095118.126696-1-mic@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_025141_504406_3E10F21B 
X-CRM114-Status: GOOD (  10.39  )
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

There is a race condition when a kthread finishes after the deadline and
before the call to kthread_stop(), which may lead to use after free.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: adf505457032 ("kunit: fix UAF when run kfence test case test_gfpzero")
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240326095118.126696-3-mic@digikod.net
---

Changes since v2:
* Add Fixes tag as suggested by David.
* Add David's and Rae's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit/try-catch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index a5cb2ef70a25..73f5007f20ea 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,6 +11,7 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/sched/task.h>
 
 #include "try-catch-impl.h"
 
@@ -65,14 +66,15 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
-	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
-				  try_catch,
-				  "kunit_try_catch_thread");
+	task_struct = kthread_create(kunit_generic_run_threadfn_adapter,
+				     try_catch, "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
 		try_catch->try_result = PTR_ERR(task_struct);
 		try_catch->catch(try_catch->context);
 		return;
 	}
+	get_task_struct(task_struct);
+	wake_up_process(task_struct);
 
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
@@ -82,6 +84,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		kthread_stop(task_struct);
 	}
 
+	put_task_struct(task_struct);
 	exit_code = try_catch->try_result;
 
 	if (!exit_code)
-- 
2.44.0


