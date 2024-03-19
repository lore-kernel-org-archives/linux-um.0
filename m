Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8768CC54E68
	for <linux-um@archiver.kernel.org>; Tue, 19 Mar 2024 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUjqkKLG6pDe2F5+j6eUEcsHwO1BSL6VifE3GADSfvI=; b=C5CKjxpHQB7b3LguwtgcyIwSCD
	wPpcybHrn1em/ow3y/TGL7Gw6QwwOfpSGlbxZI2x4wMoFMIXGT+DNakX+knTdFuHTCH1xxjzX4DUE
	Dosg0dOnc6K8FrfK7DZ+N+5ULMIL3iK58uuypo3B6auwi/Qfmh//9GW95wVQl/mB5VopI1Uy8Saqh
	uOUGbwAPDZr3Egzn+PmzMSz9IQpW6Fwo70UtIxf6Z5MYkI6tBbw37d+GL4a9vuuD7Fuujfvk5nJQU
	crIgY6e9IqKzj+Y2ujqRrV7Ks+HPyF5xAZlmiuaCyG4Aj+e0u2YMXA59PQt9nw8a7bUyOFnAjE4V4
	w2fq4LxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmX29-0000000CMZO-2ooD;
	Tue, 19 Mar 2024 10:49:29 +0000
Received: from smtp-8fa9.mail.infomaniak.ch ([2001:1600:7:10::8fa9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmX24-0000000CMWY-2K8J
	for linux-um@lists.infradead.org;
	Tue, 19 Mar 2024 10:49:26 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TzT4H3R9zzLPZ;
	Tue, 19 Mar 2024 11:49:19 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TzT4G4jhgzMppDx;
	Tue, 19 Mar 2024 11:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710845359;
	bh=Q4UUhNwYZn+WDcIDuQ7Wlx71SgXa7nFVwqw5oSSibM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4dBTnlYd4A0P0aoAur3y3VFlxA+lv/yfODZl4C1bFWuVVA0GCgov/qviWUHjb6d/
	 98F/txkzdGUiMY6llvijE4GzskZi5hQSsha9ameMP3ioPjx3fWEXZow0TMB9o5NH5f
	 oHBmuObh1szJXgOfAjs4cGlOOBbBE1WBVoJPtDzo=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v3 1/7] kunit: Handle thread creation error
Date: Tue, 19 Mar 2024 11:48:51 +0100
Message-ID: <20240319104857.70783-2-mic@digikod.net>
In-Reply-To: <20240319104857.70783-1-mic@digikod.net>
References: <20240319104857.70783-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_034924_965497_C9DDEEBA 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

Previously, if a thread creation failed (e.g. -ENOMEM), the function was
called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
marking the test as failed.  Instead, fill try_result with the error
code returned by kthread_run(), which will mark the test as failed and
print "internal error occurred...".

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240319104857.70783-2-mic@digikod.net
---

Changes since v2:
* Add Rae's and David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit/try-catch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..a5cb2ef70a25 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 				  try_catch,
 				  "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
+		try_catch->try_result = PTR_ERR(task_struct);
 		try_catch->catch(try_catch->context);
 		return;
 	}
-- 
2.44.0


