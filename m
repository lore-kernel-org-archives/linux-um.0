Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84BCD1292
	for <linux-um@archiver.kernel.org>; Mon,  8 Apr 2024 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9PeWQPDu98Kc1qd0+KMUFqgm5qvhnhgLIgLamBMyUE=; b=vOHdIEIYFDym/8nuKByfCRX9DC
	spfho8V5issuwdSgzpHa6k+Q3rC/fLprjm69o1Sa4jc9nHhUAglu6hGnkrKnOIjTjmhYVgx8c14VE
	iWq07BfROUC1Xv8Omqdqo6nLMX3IQwqx8onetQy329gdlDYjqiEQW7biycBcvBeaAIe2WApoBB5r8
	BVjFsrx6V3+u04rnsXG0OvGqUm5n82DPKZYWEJ3McH9MheLT43sDYJn7chI9f6BNJwqARt46ho1gs
	h8R4bmtdaoV30dp8+VIz6P9konpl9z2UCdY3JZqX7KX0g6+3ZIwhvgljgQtvK/IH+39Rgm1CicEYp
	FynwQ6HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjiv-0000000EjsE-1xY9;
	Mon, 08 Apr 2024 07:47:25 +0000
Received: from smtp-190a.mail.infomaniak.ch ([2001:1600:4:17::190a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjiY-0000000EjaB-2jwP
	for linux-um@lists.infradead.org;
	Mon, 08 Apr 2024 07:47:07 +0000
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4d3WYzzNSJ;
	Mon,  8 Apr 2024 09:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562417;
	bh=g0OJqBJvqd+2I5FizdlSOhG5NQKxDPvB2u6ov1eaMnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7Ik5Nr963cU/3FO4wvol+yWjal/E+rl9Ui+vQg8boC+1r26cJLnsQYMxGLdMWlv7
	 JvZEThlHTn8xtdPmB0PDMcFVLUbLpOulam4ft5TkOg1ADfG0IAN1d9R9NvhvQaGJJ/
	 Pen1LCs95LGu/Z9XrmAfUBFGYPta1BKtUPFo8Fiw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4c4wCnzcNL;
	Mon,  8 Apr 2024 09:46:56 +0200 (CEST)
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
Subject: [PATCH v4 RESEND 5/7] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Date: Mon,  8 Apr 2024 09:46:23 +0200
Message-ID: <20240408074625.65017-6-mic@digikod.net>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
References: <20240408074625.65017-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004704_209970_8051C92B 
X-CRM114-Status: UNSURE (   7.39  )
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

Fix KUNIT_SUCCESS() calls to pass a test argument.

This is a no-op for now because this macro does nothing, but it will be
required for the next commit.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-6-mic@digikod.net
---

Changes since v2:
* Add David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit_iov_iter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..27e0c8ee71d8 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -139,7 +139,7 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -194,7 +194,7 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 struct bvec_test_range {
@@ -302,7 +302,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -359,7 +359,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static void iov_kunit_destroy_xarray(void *data)
@@ -453,7 +453,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -516,7 +516,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -596,7 +596,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -674,7 +674,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -753,7 +753,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	}
 
 stop:
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static struct kunit_case __refdata iov_kunit_cases[] = {
-- 
2.44.0


