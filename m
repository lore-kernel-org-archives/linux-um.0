Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78468CD1292
	for <linux-um@archiver.kernel.org>; Mon,  8 Apr 2024 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwJLOcydJ+1XUYJeaYf06tvAse3gqfR0lz3Bd9zoWyI=; b=ZZgY1hMRpcnlLlra9u57m2E/+g
	BFawyl2wdGSUxkY6pir6NVpyrk+fA08LxUq3abIZP3AXsYbIptytd2Du1hAaikOAGjtp2cpbVjX7+
	oaFzLDc2GkHCk6NvUKP7OzaFOgEnha2wnRdr4b7opsvS/kirg2mU+AMeq2xpNlqtxY6Ns6SdYXbBJ
	BjEurTJbTyUWJO/WcYusD3pPfDnvuZY0PQzhclWCb0NXH1+nmvf6Nm22NKXR4tNrE8o9zxjq5X/MD
	bamdpARQ0u8js66ECujTAd2GiNhbvqfrNT/mgqvBtkZP/2M6AxQh1lIE1K3w2/V1XXRj5xld0Tggj
	ovjr8F+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjir-0000000Ejqk-2ewt;
	Mon, 08 Apr 2024 07:47:21 +0000
Received: from smtp-42aa.mail.infomaniak.ch ([2001:1600:4:17::42aa])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjiY-0000000Ejab-2jbi
	for linux-um@lists.infradead.org;
	Mon, 08 Apr 2024 07:47:06 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4g4LNJzDj5;
	Mon,  8 Apr 2024 09:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562419;
	bh=bZ6LYvtmVQg7V+57TeHLNvjsThrxUvXCCbMFN4WIJOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irilo2TyXHxH1HmjWzd5ma96hKDCpOPWki4uN2ph3nDS7pWaaIj92Q972R3WxyM6k
	 XhwQ1VQbAPWBHBxCkKYmZbAOk+BD/75YzXVGHjteeuVW09LgY1gkf0LC1mK7inHsp9
	 qFr9Bj6/nr68DCEodak6KjYhKUJEH+So8MYTUDr8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4f732zzS7b;
	Mon,  8 Apr 2024 09:46:58 +0200 (CEST)
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
Subject: [PATCH v4 RESEND 7/7] kunit: Add tests for fault
Date: Mon,  8 Apr 2024 09:46:25 +0200
Message-ID: <20240408074625.65017-8-mic@digikod.net>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
References: <20240408074625.65017-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004704_187311_71AA0C2B 
X-CRM114-Status: GOOD (  13.35  )
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

Add a test case to check NULL pointer dereference and make sure it would
result as a failed test.

The full kunit_fault test suite is marked as skipped when run on UML
because it would result to a kernel panic.

Tested with:
./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
./tools/testing/kunit/kunit.py run --arch arm64 \
  --cross_compile=aarch64-linux-gnu- kunit_fault

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-8-mic@digikod.net
---

Changes since v2:
* Add David's Reviewed-by.

Changes since v1:
* Remove the rodata and const test cases for now.
* Replace CONFIG_X86 check with !CONFIG_UML, and remove the "_x86"
  references.
---
 lib/kunit/kunit-test.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index f7980ef236a3..0fdca5fffaec 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -109,6 +109,48 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 
+#ifndef CONFIG_UML
+
+static void kunit_test_null_dereference(void *data)
+{
+	struct kunit *test = data;
+	int *null = NULL;
+
+	*null = 0;
+
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_fault_null_dereference(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_null_dereference,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_EQ(test, try_catch->try_result, -EINTR);
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+#endif /* !CONFIG_UML */
+
+static struct kunit_case kunit_fault_test_cases[] = {
+#ifndef CONFIG_UML
+	KUNIT_CASE(kunit_test_fault_null_dereference),
+#endif /* !CONFIG_UML */
+	{}
+};
+
+static struct kunit_suite kunit_fault_test_suite = {
+	.name = "kunit_fault",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_fault_test_cases,
+};
+
 /*
  * Context for testing test managed resources
  * is_resource_initialized is used to test arbitrary resources
@@ -826,6 +868,7 @@ static struct kunit_suite kunit_current_test_suite = {
 
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
-		  &kunit_current_test_suite, &kunit_device_test_suite);
+		  &kunit_current_test_suite, &kunit_device_test_suite,
+		  &kunit_fault_test_suite);
 
 MODULE_LICENSE("GPL v2");
-- 
2.44.0


