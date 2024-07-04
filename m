Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE9C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INihewrT92CzIbsoaGqN3U4W5g6odN915DCeWJorosU=; b=DlW/O9WxmVT2qcMlX5e2zYT/5/
	G4VqsC6Y4B4PytdEripKyCqqtRP/Jow8qWYHq8UWA+NuWhkzOhq5L7Ymkdz2cZGgMOIKFcJBNuynO
	yWWXdNE941qrOUG2nddUIwbo44Lp2TAP8SnhB668+KTAR1qI8REVJSo7Q2NgPCvmohvYz89TZsXn2
	AAxVbVNNdLyTSrzYNahtV9MMGQs7VqJNe83/afHsdgg1PnD9peYvxwo6Dlzt3cEplwkFuc7YhcvMn
	aP15FBmUC3yZskJgCeIkE0b5mS/zaOEt4uE8xUIQ0qvK9LCT92+luUcxiB5jK3JjEzFIIXQ8I4jdj
	+wCBRKoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJQ-0000000DqKv-02xd;
	Thu, 04 Jul 2024 16:28:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJN-0000000DqJQ-2R7I
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:27:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=INihewrT92CzIbsoaGqN3U4W5g6odN915DCeWJorosU=;
	t=1720110477; x=1721320077; b=Aqvm92VAvYjCuG9/dB1Qzi6oi+2Yvl/VcmOYXHKFvXrrvqY
	gt61lYEFhCn/ZWxpR3QEA28uC7UGlHurlvPqsb4YjOosqmHRbstQBPTyLdIKhP6MpVbOJLZFuLQll
	S64nSz6sPqPhcivs0QsGpLARZqS+ylSIe3iUc+LeMoDo3FSq3x7qZxzeKZhi4iGH1c9sV1nvnavcK
	0Mo2m+Yqr9l46pqtE2VmjG86raP1ZBut+WuvRgYONDyVcUxjrQ2DAhVS5IyH5Ay2jTnhbDS9U80FH
	fYa7cRybx8A2IW09O/zK20VImbpDj/aFRvYfP3JBaWdJ7GVLR57QODBF83RmMYrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPPJK-0000000DOu8-01X6;
	Thu, 04 Jul 2024 18:27:55 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v7 6/7] um: clear all memory in new userspace processes
Date: Thu,  4 Jul 2024 18:27:16 +0200
Message-ID: <20240704162717.1417338-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704162717.1417338-1-benjamin@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_092757_654281_DF27438A 
X-CRM114-Status: GOOD (  15.92  )
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
---
 arch/um/kernel/skas/mmu.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 47f98d87ea3c..bf64702d9e04 100644
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
2.45.2


