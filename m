Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B549CC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E1zLsdqYqpDaSP9/hgP04MeXltbn+JTexNrFkddBsh8=; b=i9pbQbbEQO/ld/
	JKUluBORXbJsRic15HapFhDV8lVVjK3z9dLdJSBDR17Np+tDF2YBfVQ/9btL4OMJlMU7aDR/qyxbt
	CC0Lveio9pOIbO/qaDJiEM9/Yd8HD/0TYMWrHQ2/+CqqrK0WEuVxqRKJwH3LMdVM3gs4tr+AHFzju
	3vKmhLxikOEP7Rso7JzTVHit+sjWfY2zJCJxZ5I4xqw1RwETcujaZwdhWwsS1ecQLh/Y0JXKpu2RS
	swZbMdEQ4lK0Loi+72LXODAZ/cxFlRcxdwIqm+p6bPSqntkBp4YjIwej0bAOOktpdK5Q4SljlMSHh
	SaSC+aP3QdvLGvww2JLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFG-007fto-My; Tue, 22 Nov 2022 10:11:14 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF0-007feS-Mn
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L5lwHk0HZHzNpW+yWG8h7bvuqrEFplbPaGqnoi6nvOE=;
	t=1669111858; x=1670321458; b=u3izfO0PVm7FlXqk/kTl7hu+jTXWFpAeBIfCEAeVZ+hqyyk
	WJFO7LJwE55oPnytDDKv45fGkn9EaAHenUt0snVDJJAuAy4gL2726X5UegS6DWoiMkwd/AS2gHi3l
	k9sh3nlq9rZT2D/RQfW6QRKEk1tFJNiN+CD+YoUULRfVXw4pcb1AAAkxKU6Cu05Z2/a/cDYxfLA03
	vMlDT6CLTJWAUzPH6x4Tn3Pm0Q0w7RJ46ciXySHV3JT8ecCHSGOR5HUdAK3/ZJI65vin31ZfAPrWu
	DLQvWy2Mm7mdlP2iHFtLdokHkDrSXmRgUNfcPpvVHS4zqrArkcxUHgCLTqturVRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEs-006IGn-2V;
	Tue, 22 Nov 2022 11:10:50 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 21/28] um: Use struct uml_pt_regs for copy_context_skas0
Date: Tue, 22 Nov 2022 11:07:52 +0100
Message-Id: <20221122100759.208290-22-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021058_907262_20FC1A2B 
X-CRM114-Status: UNSURE (   9.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

This is done as preparation for seccomp support as we have no helper to
copy the registers from a plain array.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1bc7e5aa2fc1..cdbab5a864e4 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -458,22 +458,21 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	}
 }
 
-static unsigned long thread_regs[MAX_REG_NR];
-static unsigned long thread_fp_regs[FP_SIZE];
+static struct uml_pt_regs thread_regs;
 
 static int __init init_thread_regs(void)
 {
-	get_safe_registers(thread_regs, thread_fp_regs);
+	get_safe_registers(thread_regs.gp, thread_regs.fp);
 	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) __syscall_stub_start;
+	thread_regs.gp[REGS_IP_INDEX] = STUB_CODE +
+					(unsigned long)stub_clone_handler -
+					(unsigned long)__syscall_stub_start;
 
 	/* syscall data as a temporary stack area (top half). */
-	thread_regs[REGS_SP_INDEX] = STUB_DATA +
-				     offsetof(struct stub_data, syscall_data) +
-				     sizeof(((struct stub_data *) 0)->syscall_data) -
-				     sizeof(void *);
+	thread_regs.gp[REGS_SP_INDEX] = STUB_DATA +
+					offsetof(struct stub_data, syscall_data) +
+					sizeof(((struct stub_data *)0)->syscall_data) -
+					sizeof(void *);
 	return 0;
 }
 
@@ -502,7 +501,7 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 		.child_err = -ESRCH,
 	});
 
-	err = ptrace_setregs(from->u.pid, thread_regs);
+	err = ptrace_setregs(from->u.pid, thread_regs.gp);
 	if (err < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
@@ -510,7 +509,7 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 		return err;
 	}
 
-	err = put_fp_registers(from->u.pid, thread_fp_regs);
+	err = put_fp_registers(from->u.pid, thread_regs.fp);
 	if (err < 0) {
 		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
 		       __func__, from->u.pid, err);
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
