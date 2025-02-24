Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B599C021BB
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0USjN5RINaUVYcs/Z4i7nPPq+FheWxZN7RV6SqvVUQ=; b=l56TKZXfZEHZZaBUj7UputT39y
	hQP+agI/sAgRpf8xd89BgRBfMJ2PV0DUO+dunjeAV9sJ1hWWzJ1FzLXRm/3AVCg/o+xkVcmT18qo2
	X2NxgST5dnYTS2eBoWAetT5+2QyaUfBtdqOXUEY1R+zRhMYEpBwnIY5com4sCq41+vUxZamtC8QPK
	o7ii2X5Hw1VZe9TA3ZBkV9UkPPqahFc/+YvgPm0KAr5NDZaui4NCKogKqe2vxjkAVnTGDkejDKMa8
	qAIqMkfdSWyvLWaCu2yDOssVPVG6XHSxmQREB7lJXlkoHRMq31lrSGVP6Xc9wQ2BaMniAxWimbmsc
	g1p4guSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8Q-0000000EnLM-26GL;
	Mon, 24 Feb 2025 18:24:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2p-0000000Em8L-17I5
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C0USjN5RINaUVYcs/Z4i7nPPq+FheWxZN7RV6SqvVUQ=;
	t=1740421147; x=1741630747; b=Kpn27p8dK/dn9kXLYmfcVucx40ItitcsWWR4NMfgQxUlYlC
	kN8XTnVrkesnhc8yikVAhSBMts1PB+wToL9eopTlizFecdTqAFUDR3jy0G1Qw4r+fNObKLP/+Kb9Z
	I2jg/HfFjZ+ygePK+b9II7ZFPtbLXlgp5UIrc0/bVMRrGrPjH9vLier2H8azEVG6wkNOenTkMJoJh
	6OrnDRa4JA3ZJJu3eGnoHEYcaiL/LCUDwlxZpfuzEZMlrlK5nYPrUym+1AV+TVS5Ww3Zz/rR3nV26
	CzLDOqobBXDDSpgyrUht+F15uBwjzj9cvN3Unku5R+rWjg57j0ujxKV5nRULhy4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2l-00000008tWp-2uDJ;
	Mon, 24 Feb 2025 19:19:03 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 2/9] um: Move faultinfo extraction into userspace routine
Date: Mon, 24 Feb 2025 19:18:20 +0100
Message-ID: <20250224181827.647129-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101907_303363_119D45F9 
X-CRM114-Status: GOOD (  11.47  )
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
index e2f8f156402f..b9449f175684 100644
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
2.48.1


