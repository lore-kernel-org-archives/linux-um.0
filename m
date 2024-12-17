Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF0E77188
	for <linux-um@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=111IE7H4zmyUsr2adVE7p7sD/t82ixlQP2Vi9ldpbO4=; b=WyIAssDbGmH2Xf0+zFJc6sksIA
	Ipc+iVlrI29XbotHL6QRj75lROPXcHe3uAcr+mdvE1jk9MwNiW9gCKoSVtuZukFFiXj+Qszjlh3dj
	PiC1El96l7x+8y0dqOJbVFKAju4J/UsZPOsd72ZW0IG5Iop2kcqD6f4AmU5RaIG422+jJ1C5pGfjl
	UHqUQ1WmLiYe4FJg/Yjl3HTOasM+KMiZ4sQ9vqnwFqtXZMwIbUxkaY4iV5ORog3dqza52jp0iWYdD
	d8H2WNS0WabXmw9wub+/RsvncZPfjzSLRxyiiGn26ELNed2UGjfRGomZ5Uwzav1GjI6YUwMqDtT91
	yjAMHjiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCo-0000000EkiJ-1Sg4;
	Tue, 17 Dec 2024 20:30:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCl-0000000Ekg5-2hT9
	for linux-um@lists.infradead.org;
	Tue, 17 Dec 2024 20:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=111IE7H4zmyUsr2adVE7p7sD/t82ixlQP2Vi9ldpbO4=;
	t=1734467407; x=1735677007; b=flm+413rOAD/boKKNqeSmNlFrPxC4BM8iXOV18umrsxXIVe
	PcKOY7ljEfYuvw9PwJsgI5ZnaoDteJQLtN5f2D0em3WzWuw+OHk6unegcVqv//oAIMOupQccHp5gl
	4YbHIRdTAKCpUkGUNE2qEXW1WZnaQaG4YVDk540rTePyOyb0XvYyd0rYlT9m+StfFAkjSZ50PgmGx
	uQf7DyHMXZw6do61ID1UpbiJ+56Ki8XUlVcn7UPyJnIwWZg5S0HWLhY5p3XCgQtm34rRTQs0HsDRA
	Qkdw7Agy658uqNPVVMHfhBMp1Ql8BsdAVfFBLVgSiQ2jXXO7hXeUPoNZN3OPvlbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCh-00000002NwX-3323;
	Tue, 17 Dec 2024 21:30:04 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/3] um: avoid copying FP state from init_task
Date: Tue, 17 Dec 2024 21:27:44 +0100
Message-ID: <20241217202745.1402932-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217202745.1402932-1-benjamin@sipsolutions.net>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_123007_681426_1EF7DE46 
X-CRM114-Status: GOOD (  11.08  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The init_task instance of struct task_struct is statically allocated and
does not contain the dynamic area for the userspace FP registers. As
such, limit the copy to the valid area of init_task and fill the rest
with zero.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain it.

Reported-by: Brian Norris <briannorris@chromium.org>
Closes: https://lore.kernel.org/Z1ySXmjZm-xOqk90@google.com
Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/process.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..3a67ba8aa62d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -191,7 +191,15 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 int arch_dup_task_struct(struct task_struct *dst,
 			 struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (missing FPU state) */
+	if (unlikely(src == &init_task)) {
+		memcpy(dst, src, sizeof(init_task));
+		memset((void *)dst + sizeof(init_task), 0,
+		       arch_task_struct_size - sizeof(init_task));
+	} else {
+		memcpy(dst, src, arch_task_struct_size);
+	}
+
 	return 0;
 }
 
-- 
2.47.1


