Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EC7C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lxN+4gdNrJ1UBFwPlgMDFswgviauMXXJAfbU1iBPqlI=; b=tGUSF77CO/yNU2
	SzLxW6xEi5ndC8XAC1lT1x4gvfeqm0L5NEP6AmiG49qIJrZAlFCi6fCHUI9EhgbShEAta4413nnHB
	LV2EfS4IxdpzOLDxNtOXO6hcFTM4xuwk7DOPQt2/apvbS9DYWDE2b09Ds0Rw1dAa8keX8mRyjI0NC
	sLqsHHpVJ/vJoplejd3h8Ous3p7cat5oth+wplAknw+QnUMuBbwhM0xB+dWunk4CdG/aX2KjZY+qn
	WDBb5cDsW+PhRBVIJO/VFhVkpG9JoiinZuLgNCFp5EueL+m34lkWq/idtYX9E1vUSGPfWeWkqWRrG
	VWeWaBt4dzxJWh3lIoFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFI-007fvO-VT; Tue, 22 Nov 2022 10:11:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-007fe8-Cz
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KjpcFBCKEm7c7UxV02u5j7zVfA4fomToklUtlIPzpis=;
	t=1669111856; x=1670321456; b=GyvxCbnvgW7YHJ8mMMsNwvruzThXJXrH0qrp1Mvg2abqM6y
	hAe7pkhg4DGoJ+9kmMijp8RASCh2OSJJ81VOjXODH1eHP0hFsxYL2XoWLhtD9m4T4HriCM/jRdCPx
	JgLxyKF+QBz5SKudEdrid4hjcn8YstjUkrSylWa8wL6RtdrSXu2ccuE39rsLA8xiU15BHe2/3fzWf
	GzCkyqtYwCQm1gMaeyt2skVYo3Ld5FraCx721vTGR1Mz1XqmdjHbm39iq1+KvYdlk02BQNe0u0NcD
	wR4mxXnoZBe4YgtFigxWOMu8V1qTEBOVfCMqlx+b8GZz1UVItLNeaWAwIJ6+4sig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEs-006IGn-0R;
	Tue, 22 Nov 2022 11:10:50 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 20/28] um: Move faultinfo extraction into userspace routine
Date: Tue, 22 Nov 2022 11:07:51 +0100
Message-Id: <20221122100759.208290-21-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021059_571510_2631E284 
X-CRM114-Status: GOOD (  11.93  )
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

The segv handler is called slightly differently depending on whether
PTRACE_FULL_FAULTINFO is set or not (32bit vs. 64bit). The only
difference is that we don't try to pass the registers and instruction
pointer to the segv handler.

It would be good to either document or remove the difference, but I do
not know why this difference exists.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1e1c378588ba..1bc7e5aa2fc1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -171,12 +171,6 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux
 	}
 }
 
-static void handle_segv(int pid, struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
-{
-	get_skas_faultinfo(pid, &regs->faultinfo, aux_fp_regs);
-	segv(regs->faultinfo, 0, 1, NULL);
-}
-
 static void handle_trap(int pid, struct uml_pt_regs *regs)
 {
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
@@ -422,13 +416,15 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 
 			switch (sig) {
 			case SIGSEGV:
-				if (PTRACE_FULL_FAULTINFO) {
-					get_skas_faultinfo(pid,
-							   &regs->faultinfo, aux_fp_regs);
+				get_skas_faultinfo(pid,
+						   &regs->faultinfo, aux_fp_regs);
+
+				if (PTRACE_FULL_FAULTINFO)
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs);
-				}
-				else handle_segv(pid, regs, aux_fp_regs);
+				else
+					segv(regs->faultinfo, 0, 1, NULL);
+
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
