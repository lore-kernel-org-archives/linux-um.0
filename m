Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510ECDD552
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRQ8kJ8BCapXhxGQP1IPvoShGo3sJialKKWdj1L00Js=; b=nmb+Xta2TGvL81nXxu8vmZvJwa
	MYEiTSjR/0p2Mltt3MVlXrqud+QPq6R3s1/ke//5unatA2vtwvDV48KJOfYI2yAB7+MxopdQyQocq
	y7tYwQWtV+6hl6kizVDXCmxOVYWKrfsOaaIhApVbkkbzJUwRvwA4Y5d5JJd7/cZCPr7x0HpzlKL7x
	PUWG93Bg5I6yP3hPfBTg8F480YF3XiG0pB5lM2gfSW+qyKI4NbGj95aKLP/7mc8Kfxagc2RbGqkkZ
	pQ5czdHgwJ2kpO1ug3IKBfQUAMqYIUAXu/X/vbUOUcmUjuALlL9W9fpUSWsim46B/KuhyQkENcGtz
	g0/Euvxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXh-0000000AGvh-2YvH;
	Thu, 19 Sep 2024 12:45:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXf-0000000AGto-0Sj8
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QRQ8kJ8BCapXhxGQP1IPvoShGo3sJialKKWdj1L00Js=;
	t=1726749950; x=1727959550; b=yTKAyIg1b8vTlH6/TftVXybVk/Wa5Y1cPZ0lJNZQmdplGbC
	qAz65tb8ynGJgJMH2Wsrm1K7gOZ98zyh0t7RMRd80/7pPf/YFrZwv+NeVFnEB7SgsWxGsXRYg8Wyc
	HiSSckCPIQz/moY01RnDnecjCIPysArX6m+HO0sEta4hagpJX3ZiRThT+qGgJdQ6kWUiXaMAfkOvc
	j589V8Kmg9kmLM+zYpl0gExWrBRlPyrXqYk8LXQmknOiwRB64pJebLTichR+BeMkNneOabezCNS+0
	fDQR+EYBrTSYfFbPtwg3TUwDxfG24ODZ9v34EoU0gv5Ko+KVFEEeyq8T3K5TgK5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXc-000000047AZ-3ZwC;
	Thu, 19 Sep 2024 14:45:49 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 09/10] um: clear all memory in new userspace processes
Date: Thu, 19 Sep 2024 14:45:10 +0200
Message-ID: <20240919124511.282088-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054551_185353_9D14265D 
X-CRM114-Status: GOOD (  16.47  )
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

With the change to use execve() we can now safely clear the memory up to
STUB_START as rseq will not be trying to use memory in that region. Also,
on 64 bit the previous changes should mean that there is no usable
memory range above the stub.

Make the change and remove the comment as it is not needed anymore.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/skas/mmu.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 886ed5e65674..d3fb506d5bd6 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -40,29 +40,8 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
-	/*
-	 * Ensure the new MM is clean and nothing unwanted is mapped.
-	 *
-	 * TODO: We should clear the memory up to STUB_START to ensure there is
-	 * nothing mapped there, i.e. we (currently) have:
-	 *
-	 * |- user memory -|- unused        -|- stub        -|- unused    -|
-	 *                 ^ TASK_SIZE      ^ STUB_START
-	 *
-	 * Meaning we have two unused areas where we may still have valid
-	 * mappings from our internal clone(). That isn't really a problem as
-	 * userspace is not going to access them, but it is definitely not
-	 * correct.
-	 *
-	 * However, we are "lucky" and if rseq is configured, then on 32 bit
-	 * it will fall into the first empty range while on 64 bit it is going
-	 * to use an anonymous mapping in the second range. As such, things
-	 * continue to work for now as long as we don't start unmapping these
-	 * areas.
-	 *
-	 * Change this to STUB_START once we have a clean userspace.
-	 */
-	unmap(new_id, 0, TASK_SIZE);
+	/* Ensure the new MM is clean and nothing unwanted is mapped */
+	unmap(new_id, 0, STUB_START);
 
 	return 0;
 
-- 
2.46.0


