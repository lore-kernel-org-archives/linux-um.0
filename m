Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C0C4167D
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=79qdtHhqYpGXK/cdgBJaRozERqWVNlhLhvpJ8tGOEOA=; b=ZrgW+48ZNUc1jr
	FoIOubBRDcs+5Gb7GENdg0GbzgfBJ28NEh45K7SGP8XfI3n29sAmDtqxKaPOKASpRu4rHKyObBRmx
	0aYMO4pvw9QZA6NmRW/nyk5uWtuWPY+x5bOPM9PPRz/gucdXYpP4v/qIRH+oGFDD7FUBG/7IGudic
	uYspF3AOpM2qwZGWhZkLdulmdvpl6iuiCrO5VGpsf7JENh5cFuAjDVQjF+lYDnwZBImsCSPMBxdom
	oDWEiOBmN8tpP6skH3fSDKyhZoJniMitEu+tVesULU2gqz7eayWn79DrgynLkITZa/qh8MDZHe6wE
	rugfLC8aCGvHdfxuhxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJM-008M2z-1E;
	Fri, 10 Nov 2023 11:04:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJI-008Lxd-38
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DIlUewqRC8fu+SBFviWJv4TSa7C02bEz1WdWfvsZAEI=;
	t=1699614264; x=1700823864; b=uSgcJeH6bJrsI0T6mok9ya/0ouZQ/KvVM6jPhm+oNsgNRNh
	6MmgRdfV8sPFe0Ss67fMhOq9aZaCJmHUTVj25gy1asEdU+nFXbm2aaGYQ2UfaibXs2m2W108q3TjO
	8hG8ODRDO60y1XP+ZWLku34mhJT5SwRAqsti/GLETq63sJTHdOPiDPKBY28uINebrsM51YbRDRjOo
	n7lOOVThxCqZSQw7Od1rcHLbymxV2XC4rnrzh9Nh2XIUE9iFlWPJDWXYTFk/w09UjeMGYE7hzPPQs
	pDfsXIYRzylogmgJAcPHQKQQdn/wv8MO4vHfErOfRGRBg7ZBhHA3Og8D09nPgGxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJF-00000002xHc-1fOi;
	Fri, 10 Nov 2023 12:04:21 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 10/11] um: Remove unused register save/restore functions
Date: Fri, 10 Nov 2023 12:03:47 +0100
Message-ID: <20231110110348.1815612-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030425_012381_5E6C4051 
X-CRM114-Status: UNSURE (   9.25  )
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
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
