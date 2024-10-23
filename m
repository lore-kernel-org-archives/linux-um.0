Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA0CF538F
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wK1nqYNUInYwR8ifNkqsaaIRbk80RigQCWgHEn2zGAk=; b=gVT7pdyzwJvSpUc9gTnGF5btBE
	gWHcrhs97GWujT8KhBEXWi7hIZpWrQWJOkkK/yKEYZlQ1uYENawfnUy/qS+I7hp0DKcC0L3YzRzuT
	ZGptC9LYlU8F4S64qXUXLMD5oSg0b5a7WxoEebu5001wzn+cX9KW6TkaUYOR18Z9pIoZKyTp/E59j
	aC4DIkFFqsu/evvTkxCtUyPuCjJJ8UUV6XSzvGways8BAmaZwSUa/Eg0SKJWWpSHDDKbQ2Nz5l4fN
	DKsPEw7vpleC/Aq+aCRhXWyesaxnsw1bxnnPWbI1koahWRQVvK2gLqm7UKLxCr4Qx5klj0rqwI6FL
	8KuaDoPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c37-0000000EeIZ-1lXG;
	Wed, 23 Oct 2024 14:09:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c34-0000000EeH3-1iHh
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 14:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wK1nqYNUInYwR8ifNkqsaaIRbk80RigQCWgHEn2zGAk=;
	t=1729692558; x=1730902158; b=LM5EwnNvFzPzb5Yccf8udtrAY8grdBJJlzachtc8KFhyKL3
	SeLsFzN6jOgriXhtbDL+MxRKuSJtuhMhmJvKGR0l9AH6bqgVtXqZv7adQ58VSGkAAMkHzWwXMWpJw
	fH9KqohGhF/JtpM5MytGiXhR70wkEH7U0Vc+liFG2blL/cBTdOvWiONia8VJKzUHC5NZnZF8LgrGD
	lqHTcciLCh8qGr8yBnsMEzD8HrynAIuz7Eda7obeXRjsiOFmaRZue1RQESQb/9k/8pBvRVnwQBI+v
	wyshX/uD0N2iFjsHord+aDYqOq/9KgFatOQ/PDG5d4gLBlXvc8ayqF+tdNK5k8xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3c31-00000002hDF-0VsN;
	Wed, 23 Oct 2024 16:09:15 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [RFC PATCH v2 2/9] um: Move faultinfo extraction into userspace routine
Date: Wed, 23 Oct 2024 16:08:20 +0200
Message-ID: <20241023140827.136550-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023140827.136550-1-benjamin@sipsolutions.net>
References: <20241023140827.136550-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_070918_466280_E10A769C 
X-CRM114-Status: GOOD (  11.77  )
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
index 97856955e892..e99fdb100715 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -163,12 +163,6 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 }
 
-static void handle_segv(int pid, struct uml_pt_regs *regs)
-{
-	get_skas_faultinfo(pid, &regs->faultinfo);
-	segv(regs->faultinfo, 0, 1, NULL);
-}
-
 static void handle_trap(int pid, struct uml_pt_regs *regs)
 {
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
@@ -509,13 +503,14 @@ void userspace(struct uml_pt_regs *regs)
 
 			switch (sig) {
 			case SIGSEGV:
-				if (PTRACE_FULL_FAULTINFO) {
-					get_skas_faultinfo(pid,
-							   &regs->faultinfo);
+				get_skas_faultinfo(pid, &regs->faultinfo);
+
+				if (PTRACE_FULL_FAULTINFO)
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs);
-				}
-				else handle_segv(pid, regs);
+				else
+					segv(regs->faultinfo, 0, 1, NULL);
+
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
-- 
2.47.0


