Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5928C43217
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bwiT8q+mhHqJYBJT9TtNlnywFVGzxOtBrShauDMyLmQ=; b=uQQljYK6CyOAr+
	ZWZHlBsMhCNsFqfcw4VI3Eb4e96Ex7E5OkCCsy22f1sSluB5UcKwT+ZQKxklMFf2tRdRmEpXMIoXl
	TrOwPVs66r5lUKnCytFIKrPWXNJwrTwSVshIr2sjMflfWDF07gnGkevG+BJxKFwNveIxEgdqBbb0r
	uS14lkg2FkTqnpTo6LzW5SYQexd3YFveJrP5Z0/WZyKWDrQ7tSrvUBnNUbeWhp3OpfpIh+icjvE0z
	yNoxkvA5fcLWTJRKOwWwweY4VX3zb7s+JPq5HckrH0PYGxu96wnomOStAyHtCQIjajNXb+1PUTfr+
	XzTPL4dUNklsPflkO1vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFM-007fym-Tc; Tue, 22 Nov 2022 10:11:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF2-007feN-13
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ikJn9sZNcthzmWedxxWRBgwrx55FyWEuQV8gh8wD4Pg=;
	t=1669111856; x=1670321456; b=N4xPHboM5cCNXGQ+oHxifsJ6RIVrmAyxxKjL3ec21F03W6Z
	iA58m0QrrBUY8UPoCdSdYS3XpHwbk6by94r/acmJh+tJByWjU3I972s/RUxvMAW5kPn/ykQi3SRN3
	PGZ07RjuiKkD1XllKxD2RROkXHEq2g5D4iQ8r62GSQRdJ3dgg8i8HD+LKbKyfl4mbcp3fWUtjm6Od
	UzwYXcQf/EYxJSjC29Ml8Vz/9dwNCpUmfrKi1RbB1wiadRSiWBOOzhv4HmFV/tHcwzGd8hRpm7Zta
	/bB0nlexsSIUt+EUFFSckymDFaFlsuP8bZBBgLyJ9djBz/Q5ANUpNo5nCldsMmCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-1F;
	Tue, 22 Nov 2022 11:10:47 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 12/28] um: Remove unused register save/restore functions
Date: Tue, 22 Nov 2022 11:07:43 +0100
Message-Id: <20221122100759.208290-13-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021100_144755_3BB9D159 
X-CRM114-Status: UNSURE (   9.02  )
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

These functions were only used when calling PTRACE_ARCH_PRCTL, but this
code has been removed.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/registers.h |  2 --
 arch/um/os-Linux/registers.c       | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index 2f9c3ce5b45e..a0450326521c 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -14,8 +14,6 @@ extern int save_fp_registers(int pid, unsigned long *fp_regs);
 extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);
 extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
-extern int save_registers(int pid, struct uml_pt_regs *regs);
-extern int restore_pid_registers(int pid, struct uml_pt_regs *regs);
 extern int init_pid_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern int get_fp_registers(int pid, unsigned long *regs);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index b123955be7ac..bd80b921add0 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -11,26 +11,6 @@
 #include <sysdep/ptrace_user.h>
 #include <registers.h>
 
-int save_registers(int pid, struct uml_pt_regs *regs)
-{
-	int err;
-
-	err = ptrace(PTRACE_GETREGS, pid, 0, regs->gp);
-	if (err < 0)
-		return -errno;
-	return 0;
-}
-
-int restore_pid_registers(int pid, struct uml_pt_regs *regs)
-{
-	int err;
-
-	err = ptrace(PTRACE_SETREGS, pid, 0, regs->gp);
-	if (err < 0)
-		return -errno;
-	return 0;
-}
-
 /* This is set once at boot time and not changed thereafter */
 
 static unsigned long exec_regs[MAX_REG_NR];
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
