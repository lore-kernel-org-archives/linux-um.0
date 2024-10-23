Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7505DCF538D
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UKgcbu7+ClKIOUysraGmTC6PtT8REnzRU/ItTMjpu0=; b=fJbFX1En4ON+T1ym/rMOm7ZFf8
	eeI80RdGgdTWlhb87BRkpWLdmA5oGsZKecSV3yV+UKT/cnloPVqQkoZD0z16nz3PZfxmnrnpjnjuX
	m72Mr+AS6vTn3dzGwjrSIvOFWojS1/zZEwt8zBNMh+kfF2V+Li/nxXvWn0WLa6nRjLoChEgNGd4KV
	R3QU3qLVKYek5xlZNH3xH5ItT+rEIWzgkTDzkhn0ZmImaYZL9clihl6+RdrNu3/JNJ9w6GWc8XZfm
	WLLyrlJELGFgE2qsaAYSQGxHY1boYx34QRSRy+/sk2fDaRhLuhePze0S1vYFK8y1R9UszUSZzoife
	ysulYX3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c37-0000000EeIM-0NGk;
	Wed, 23 Oct 2024 14:09:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c33-0000000EeGI-153H
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 14:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0UKgcbu7+ClKIOUysraGmTC6PtT8REnzRU/ItTMjpu0=;
	t=1729692557; x=1730902157; b=qpWmuDTnumPpieTZTkFexSSo+vU/wCzWSyFijHuqZlPwgdj
	DHtT/Bo5APIWhJpIXiRgMR+JdzURZgdwCFuqV/x/bk1odpEPjbRDJQd96Kq6NucG4L6uRQlvUx8BM
	tK8vprw4ynNXZkTjmXGIAPMNr59xgu+TrVx3vQmFwtjxn56U5IvqNiOSW7RjkblzFePritFmO7IoH
	e5FZPZKqdGT9lIrBLaDwF3TQYv8w/kO6jiPHiy4m3FIkYbUvVq1JCR6vJN7n5wRe0Y/IaGXIvPJWR
	V5BrXCHKhw7ki9Qb5/uAgz84ZoJcGNR0s6wlceg9Ju5bfmeCnr5RNQzlg9PiXGLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3c2z-00000002hDF-3OIf;
	Wed, 23 Oct 2024 16:09:14 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [RFC PATCH v2 1/9] um: Store full CSGSFS and SS register from mcontext
Date: Wed, 23 Oct 2024 16:08:19 +0200
Message-ID: <20241023140827.136550-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023140827.136550-1-benjamin@sipsolutions.net>
References: <20241023140827.136550-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_070917_315974_80A0FC7D 
X-CRM114-Status: UNSURE (   9.85  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Doing this allows using registers as retrieved from an mcontext to be
pushed to a process using PTRACE_SETREGS.

It is not entirely clear to me why CSGSFS was masked. Doing so creates
issues when using the mcontext as process state in seccomp and simply
copying the register appears to work perfectly fine for ptrace.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/os-Linux/mcontext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d28117..1b0d95328b2c 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -27,7 +27,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
-- 
2.47.0


