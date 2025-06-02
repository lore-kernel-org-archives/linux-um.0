Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9441CC5B549
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKNXVLBcT4Xr7n5nchj8L9iY1mzXmC4cFVEABdfStPE=; b=kOGner/RSG4TE18wQSIWhKt2bJ
	KO71CIP+Q6N57lH6N6wkIR++tUkNuKa8LzdzNrSab0lUkI+kzphlWmew4N2ivh36ILU14zgCsCq/5
	Wx/nNVyLGYzCLZssMBTdT4pPRhI1mXqvXIKro4FsQ041T991JBbu3oV4wNmQFWALWram1mqC4H9N8
	Ad0UhyDWY07yP3q68M3MllMSuwvsv8sL0CSvg4e0nZiu8mXW3AW7SyTJNpd3eKzbaKu0dyikC7JII
	yEyv4cwxDEY/FAXxeXU6qGa2P7C2c+JnvVw5oRffoVJtIeRchjVH9rn12iT4JHIpavESd185vRrA3
	FVKomctA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4oL-00000007Pmo-1QSE;
	Mon, 02 Jun 2025 13:02:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4nN-00000007Pe2-0lvM
	for linux-um@lists.infradead.org;
	Mon, 02 Jun 2025 13:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kKNXVLBcT4Xr7n5nchj8L9iY1mzXmC4cFVEABdfStPE=;
	t=1748869299; x=1750078899; b=Ib+3+EZFN6KVV2WoBwHV5v+5nYC9P+LJk+qMSRWJH4toRvt
	DRRikoKWMfjhZARP/inrbDt5W6v2Wh/ejGYOxRIeAIdJNGdLNKdiAbu0qmDh1CT3Httxyvb1luHEp
	Xd4lMHF+pM/ss4//zehf7aGGCfdFOozdSxm/k//gqvRrRJYzzEa8N9Eenr0WMZ8lkgy+u5suINJGg
	TRmE86QrrCCponSCGmAe3G2zaqqOUKLTAWGwQuoY3STey+A5TCbuviJ7XtmgMiryYxYjfRFyX0gLZ
	Taz6SCtqjLRI2eB3KVDlxEFgXy+kGQwZnW+y0nspnpdoZ8Yv/FWbGgUoH1QgZo2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uM4nI-00000005j9h-1eid;
	Mon, 02 Jun 2025 15:01:36 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 1/7] um: Move faultinfo extraction into userspace routine
Date: Mon,  2 Jun 2025 15:00:46 +0200
Message-ID: <20250602130052.545733-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602130052.545733-1-benjamin@sipsolutions.net>
References: <20250602130052.545733-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_060141_222441_D1E17292 
X-CRM114-Status: GOOD (  11.88  )
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


