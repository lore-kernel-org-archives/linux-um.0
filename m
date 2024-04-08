Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C6AC67861
	for <linux-um@archiver.kernel.org>; Mon,  8 Apr 2024 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1f3rk8fKnQ5528Q1sN//wjIKQ0nPJ2paE31DZuTdi8=; b=JyyakZMcfMS8IvYgjd4oPDA+Tp
	5ZRtiHrM06JJ57RgE7JVX/AdlnxEZcAkuv/nyx8Wsfg/Zdzsm0c5I08ykUuF8sIu2fTEElDX7YvV0
	Buu9ZDCPijvCJqy+EFIE0eSeG/chSjuH5KHOxpZhRaU8+97Ye0oBIPNckwxKk9+3xPDT4ME0yma1w
	y5WUsDjG9tKKuDiCIVnrpuU7KQ+MeWaAV2SYx+k4EBOnygWrr8b851sdAtvUCiXgcTAQ+5CfLyWgz
	URzEdKyr6XHBUecR5uXjJmQmaXgmkJVyi9GelYhrliF7e7YNO6YKJwjMgVLTCMd1+YQ3h71gWly+6
	mMc26Y0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjip-0000000Ejou-3Z85;
	Mon, 08 Apr 2024 07:47:19 +0000
Received: from smtp-42aa.mail.infomaniak.ch ([2001:1600:4:17::42aa])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjiY-0000000EjaV-2jSO
	for linux-um@lists.infradead.org;
	Mon, 08 Apr 2024 07:47:06 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4f4XSKzLMs;
	Mon,  8 Apr 2024 09:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562418;
	bh=DSVedLN/9sNq/HBRK05msQLVmLdeU8WEsK5nC9gm8+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plIrvCaCTl2uB50gN84HYodD7H8HQiFSINSoCXMjfQl23eukDoU30Y0Idn6p2DtOa
	 UtzO+MtiJhZ11JPAf8m+J3QpBv/lbHe6RBXHHBM/x0vzZOnTf3s+YTiEkAD1OWFQlN
	 UPGcS4zYrQFY+7jxFjh0nXgSV9ariQbyvbEbcdT4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4d6Rnlzgq4;
	Mon,  8 Apr 2024 09:46:57 +0200 (CEST)
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
	kunit-dev@googlegroups.com,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 RESEND 6/7] kunit: Print last test location on fault
Date: Mon,  8 Apr 2024 09:46:24 +0200
Message-ID: <20240408074625.65017-7-mic@digikod.net>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
References: <20240408074625.65017-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004704_076999_C8A412EC 
X-CRM114-Status: GOOD (  16.71  )
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

This helps identify the location of test faults with opportunistic calls
to _KUNIT_SAVE_LOC().  This can be useful while writing tests or
debugging them.  It is possible to call KUNIT_SUCCESS() to explicit save
last location.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-7-mic@digikod.net
---

Changes since v3:
* Improve the try-fault error message as suggested by David.

Changes since v2:
* Extend the commit message according to discussion with David.

Changes since v1:
* Add Kees's Reviewed-by.
---
 include/kunit/test.h  | 24 +++++++++++++++++++++---
 lib/kunit/try-catch.c | 10 +++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index fcb4a4940ace..f3aa66eb0087 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -301,6 +301,8 @@ struct kunit {
 	struct list_head resources; /* Protected by lock. */
 
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
+	/* Saves the last seen test. Useful to help with faults. */
+	struct kunit_loc last_seen;
 };
 
 static inline void kunit_set_failure(struct kunit *test)
@@ -567,6 +569,15 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 #define kunit_err(test, fmt, ...) \
 	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * Must be called at the beginning of each KUNIT_*_ASSERTION().
+ * Cf. KUNIT_CURRENT_LOC.
+ */
+#define _KUNIT_SAVE_LOC(test) do {					       \
+	WRITE_ONCE(test->last_seen.file, __FILE__);			       \
+	WRITE_ONCE(test->last_seen.line, __LINE__);			       \
+} while (0)
+
 /**
  * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
  * @test: The test context object.
@@ -575,7 +586,7 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
  * words, it does nothing and only exists for code clarity. See
  * KUNIT_EXPECT_TRUE() for more information.
  */
-#define KUNIT_SUCCEED(test) do {} while (0)
+#define KUNIT_SUCCEED(test) _KUNIT_SAVE_LOC(test)
 
 void __noreturn __kunit_abort(struct kunit *test);
 
@@ -601,14 +612,16 @@ void __kunit_do_failed_assertion(struct kunit *test,
 } while (0)
 
 
-#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
+#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...) do {		       \
+	_KUNIT_SAVE_LOC(test);						       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
 		      kunit_fail_assert,				       \
 		      kunit_fail_assert_format,				       \
 		      {},						       \
 		      fmt,						       \
-		      ##__VA_ARGS__)
+		      ##__VA_ARGS__);					       \
+} while (0)
 
 /**
  * KUNIT_FAIL() - Always causes a test to fail when evaluated.
@@ -637,6 +650,7 @@ void __kunit_do_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ...)					       \
 do {									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(!!(condition_) == !!expected_true_))			       \
 		break;							       \
 									       \
@@ -698,6 +712,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(__left op __right))					       \
 		break;							       \
 									       \
@@ -758,6 +773,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
 		break;							       \
 									       \
@@ -791,6 +807,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(__left && __right))					       \
 		if (likely(memcmp(__left, __right, __size) op 0))	       \
 			break;						       \
@@ -815,6 +832,7 @@ do {									       \
 do {									       \
 	const typeof(ptr) __ptr = (ptr);				       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (!IS_ERR_OR_NULL(__ptr))					       \
 		break;							       \
 									       \
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 7a3910dd78a6..fa687278ccc9 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -96,9 +96,13 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	if (exit_code == -EFAULT)
 		try_catch->try_result = 0;
-	else if (exit_code == -EINTR)
-		kunit_err(test, "try faulted\n");
-	else if (exit_code == -ETIMEDOUT)
+	else if (exit_code == -EINTR) {
+		if (test->last_seen.file)
+			kunit_err(test, "try faulted: last line seen %s:%d\n",
+				  test->last_seen.file, test->last_seen.line);
+		else
+			kunit_err(test, "try faulted\n");
+	} else if (exit_code == -ETIMEDOUT)
 		kunit_err(test, "try timed out\n");
 	else if (exit_code)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
-- 
2.44.0


