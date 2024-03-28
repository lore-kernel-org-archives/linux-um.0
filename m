Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD74C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fjWputmxWIOxc8zEZ0YweNF74ZEvqCJV1sDZ3d34o6g=; b=FJrij+kg4PFezPcx7LyWaVMhPo
	dFWHCFNuhuz2XTca8qX181aPSXSO/+GFGp3ebZL7KLp4Rk0FTOD6VlgoA72dsgEo+1emzuXlYsoI1
	4O4HS6dnvZcxW+PwKMXXVJpAn7BBzVHun3IbcfK6V1dblizPTkRQm4bVaxBBsz4C6VzmH3RuuArJO
	85B743lFw/iMLwTqCawW3ar+qWhKr9dEyW2tUOCO8I93gZ29Bv94/GBqrirQ/vXZZVSmshk9AlSFJ
	rAaLILpNBuYwf12dtyN/NIgFgS04y23MKR/0I8KxIIFtAf3xGJ+N3XXm13rtXUzT7OpZR6uQTE2JZ
	wcnY/l1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnY-0000000DFYE-36ly;
	Thu, 28 Mar 2024 09:11:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnU-0000000DFVQ-1G6H
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fjWputmxWIOxc8zEZ0YweNF74ZEvqCJV1sDZ3d34o6g=;
	t=1711617104; x=1712826704; b=JyXVg/rYW7w15u0g4eMhVvdxH4lyyBfP6IOAIznlqQFhoUV
	kL77Ien2BZxj5SvUfc5AhsmspLiZPIrDdYe8nvDHERWcvfJubGczsTDUZGSBwJMg6Jm9Vo01Fl78i
	JW46Vw42HbdEYeu03Y04T27DSRBrabpbYI/cff93EFGtXsaJmuXuEToTJDzIQlEgcqtPwyW4XiYjP
	UM0aVmM9sWrLDUJbu//yTcJeJvSx/Wv7XIWD0Kxp+u61WNc78BpjG4vAfQ7ZJ0fXQ/CDcc6p2iS/M
	XdUSS/vvN62ZBb0lHg2HOIjqDgvM930ZPWeD/gojwEP4auhd6FFi/FHtwYV28oDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplnR-00000000oe8-26vr;
	Thu, 28 Mar 2024 10:11:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] um: process: remove unused 'n' variable
Date: Thu, 28 Mar 2024 10:06:38 +0100
Message-ID: <20240328100640.cec1867f0944.I739ea3921fa4354f4afcd6de1d3db2056ea11c72@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
References: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021144_361002_1FF0DE3A 
X-CRM114-Status: GOOD (  12.29  )
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

From: Johannes Berg <johannes.berg@intel.com>

The return value of fn() wasn't used for a long time,
so no need to assign it to a variable, addressing a
W=1 warning.

This seems to be - with patches from others posted to
the list before - the last W=1 warning in arch/um/.

Fixes: 22e2430d60db ("x86, um: convert to saner kernel_execve() semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bf7739ed0f..d2134802f6a8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -102,7 +102,7 @@ int get_current_pid(void)
  */
 void new_thread_handler(void)
 {
-	int (*fn)(void *), n;
+	int (*fn)(void *);
 	void *arg;
 
 	if (current->thread.prev_sched != NULL)
@@ -115,7 +115,7 @@ void new_thread_handler(void)
 	/*
 	 * callback returns only if the kernel thread execs a process
 	 */
-	n = fn(arg);
+	fn(arg);
 	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
-- 
2.44.0


