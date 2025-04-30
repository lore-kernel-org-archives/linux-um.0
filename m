Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D2C3ABAC
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKNXVLBcT4Xr7n5nchj8L9iY1mzXmC4cFVEABdfStPE=; b=Sx3oYUcrq1bpvKrp/YcW/5mL7q
	i32tTncM6J/ALBiGUXqxFvSjWBcHpIgRmRpoJ1vf6p6ccI5GXsUACxKzzIcRAWiea6ml3WOfoa5hM
	pNv/pMEfm/ir3W+lg/FPmwYJzBbyc2WhoVhyJGjVXcpjAp7OY4DtKkRswcl3joEveo7uvbtgo4UgL
	DQx0fOQQLK0pyBQ8jV3fbNTU6bTZmKDZDJiBECX2QyUE/fS1PuYfPLmNo4RrWvLqOwgu52VbvfOBC
	fUMgS3SqY34D10Fpn9H+bYBEOuwh5hah8JJWouxy5D7fCVy3rPqFKeSXnqONfXHdq7vglH8BWTab1
	jv6Mj/OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zU-0000000DO1B-2NTV;
	Wed, 30 Apr 2025 16:08:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9ws-0000000DNf7-0HtO
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kKNXVLBcT4Xr7n5nchj8L9iY1mzXmC4cFVEABdfStPE=;
	t=1746029172; x=1747238772; b=KtURQU1NUC9c+JGwrf+V/2a6mXbBT7nQhOLjG94TMXnVOm1
	jIgJwEvK3aNfnoAUF5Da/bk5zr20NMt+XiOQJcZgGt7xmqpo8EwlyYxTP6TPzcIcdIUYvjn+8Xx/r
	69uPfqjptzlAnlTAqpDl6L4wpnEj/KrF6ubrDLvv1iIMurlP2KQWVQ91+IcnMGkYIUAxJ6nYiYClh
	DCrR+f3QRYI/yTRoNTAoQrK/S0sw/UNc74Pz2e93P0zdpM19YiAfCcG/08/LX5IugRtzPwLOv7hKs
	l9G0SSrun7KloJKGGyJU1DeIOckYD3/8mArVQuw/SmHJXZP3vV1cR2mt5HWV1/AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wn-0000000DxyX-2IEy;
	Wed, 30 Apr 2025 18:06:09 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 1/8] um: Move faultinfo extraction into userspace routine
Date: Wed, 30 Apr 2025 18:04:06 +0200
Message-ID: <20250430160413.3250227-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090614_106492_4E260C83 
X-CRM114-Status: GOOD (  11.80  )
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

The segv handler is called slightly differently depending on whether
PTRACE_FULL_FAULTINFO is set or not (32bit vs. 64bit). The only
difference is that we don't try to pass the registers and instruction
pointer to the segv handler.

It would be good to either document or remove the difference, but I do
not know why this difference exists. And, passing NULL can even result
in a crash.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index ae2aea062f06..97c2f964f5fc 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -163,12 +163,6 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 }
 
-static void handle_segv(int pid, struct uml_pt_regs *regs)
-{
-	get_skas_faultinfo(pid, &regs->faultinfo);
-	segv(regs->faultinfo, 0, 1, NULL, NULL);
-}
-
 static void handle_trap(int pid, struct uml_pt_regs *regs)
 {
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
@@ -521,13 +515,14 @@ void userspace(struct uml_pt_regs *regs)
 
 			switch (sig) {
 			case SIGSEGV:
-				if (PTRACE_FULL_FAULTINFO) {
-					get_skas_faultinfo(pid,
-							   &regs->faultinfo);
+				get_skas_faultinfo(pid, &regs->faultinfo);
+
+				if (PTRACE_FULL_FAULTINFO)
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs, NULL);
-				}
-				else handle_segv(pid, regs);
+				else
+					segv(regs->faultinfo, 0, 1, NULL, NULL);
+
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
-- 
2.49.0


