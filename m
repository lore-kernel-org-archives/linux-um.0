Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CA8C5478C
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LC5EKLQTepdq2jdkga3aCWt3tJPeoAKukrYc+lqhvRM=; b=N2MWVsHj0FNlS9aVoGp4rFMBLs
	R2G1xmMoVx/O4vqVEuMidgoVNFDLJPpHPUeoqjuyx33YxNiOnIVfDB85/IgOZw+knGzxt64ua+d2s
	i1+LWc1LklBClYYkXLdp36++tSAtDu9syb1HrgkFSjFh4QNOD3GZBn5APApTW15AKC84nPynIiWVJ
	45GO5QUggO9YgbkQcdugEONK5FgdWKzEXmg7qHNTudFKoURqcCttQwX8BuLAQkYyNja0g/100L9v1
	9d/rfJSio82Atv5Qve3D4Ohs8BCOC4+vTURp55sVOkIC12K/0E/95K1qRGbRs2oG5ry1Rkx+vAG8L
	v5hSPO9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8ka-00000001lT9-2Ap0;
	Fri, 01 Mar 2024 19:40:56 +0000
Received: from smtp-bc09.mail.infomaniak.ch ([2001:1600:7:10::bc09])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8kX-00000001lRc-0u5D
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 19:40:55 +0000
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmdjt5ghXzkK1;
	Fri,  1 Mar 2024 20:40:50 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmdjt0SPqznyw;
	Fri,  1 Mar 2024 20:40:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709322050;
	bh=jkhmQz7nkMs7xp2ykDqNMWSLInw6oMw8Eref1dxaomo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vd+N/tIgA2C6MTwZX8etILLsyzDPCEdWFm06zVVXnd3T/PZeUUlbXgO+5vW7bM1VX
	 o6oY/T9zP+sgCjKPE9FQgDuYo3APtqNDmKr1JS8HLqpFP2xMdLnE2q1lZherO6MoI2
	 KHqktHrPWkaKpsb0ZNB4JKViPBvmEt0V5Tsu7CKw=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
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
Subject: [PATCH v2 1/7] kunit: Handle thread creation error
Date: Fri,  1 Mar 2024 20:40:31 +0100
Message-ID: <20240301194037.532117-2-mic@digikod.net>
In-Reply-To: <20240301194037.532117-1-mic@digikod.net>
References: <20240301194037.532117-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_114053_426514_3075BBED 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240301194037.532117-2-mic@digikod.net
---

Changes since v1:
* Added Kees's Reviewed-by.
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


