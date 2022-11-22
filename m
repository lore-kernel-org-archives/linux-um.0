Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68186C43217
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=45ugnTrNlARdig66R/E/emCoWuzgdIIWRE9gdG6+9bk=; b=Q7pAPpwtDVBIM8
	2STFPLwNp0eio6Ca0AyvBPG+nLiJYjDWuZanerlAEOfAYo9fhbXLH0TPYqA4otCn/UhNaY+cxO8fe
	hCSaEVfTAH3GzPe6zm9IVsW/WKv0ZRFFTpF+YFGBVzWVMVOzpr/dkS3yZnkrOCZ9b2tlhym2GHbq1
	r+TmzPj5Wp93yjT1TwSm38LHyMjFNglYql7pDSqHLik2GJXAzbA0b9MgiuUe6mOc4x5skmDfzCyOH
	sHsj1lud8YaIBzZRT7B8H+UzSdEIcIPM3GfTHMycAoQHOW7H9VtHz2c3rQsMn8a7+WSXty8trSOAV
	A1Tvam+BOx/Yw0pO5H7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUb-007o3G-AA; Tue, 22 Nov 2022 10:27:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTN-007nM8-EX
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VaZRcxGCiKkWxdH1yaSZCOEj93ggLPfi168EByH2/ww=; b=NXlcKiIeyhdH+zN1N3DBs0QYHu
	6gT0Uc8MnDu9RVxibgQi1Dz2Yt4QwuAYByAQ3zGHCH/djNZ5CtAyQ0e2vGY3vIaDdFhxWDSFmDPuR
	mJoDfMdZJa2b3+rm6xTYOQzNTv+buoMQz64PCUI4Rv02RCbVMS+eXZY2nqlwIgOgl9Se5jN4IJBcZ
	pgeKocjaMWvBWSM/NHD5cZBDLBB3aUI5o9wbMLN8zya+hpf+gwMjKR5OUzcmL1zldB4IWdhbr84wn
	Z+jl1dbAu0/TIcIRDMN4dZg8WHq+tEA3YtHQB9L0z26W/C4IVcd2Q3kZUoY7DBHMWg6LfNQ6K5G+M
	HsVe0kcQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF0-003P1o-Vc
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VaZRcxGCiKkWxdH1yaSZCOEj93ggLPfi168EByH2/ww=;
	t=1669111857; x=1670321457; b=A+Q3nuLznSN7O4vD2pTuybvbpeaIAJ3JU5CtVvNI6NnH6ha
	NNTOKVARjtErZoDaHT22UkAR2xEHj/EcaAEi5GbqJ+n5+XAsn5noCQa9qP+Ft6gjQbPK8pUrSfBbf
	IiVHhhcAZoGhT/e0n0aAEZc+IVmzl+Zut1gySWlTVzm5IKWLsYJGJWzaoQFIXuZ76mpyGOR0P0Qcq
	vTCtV8guU1YM1YGDWFUJgLkWPY/2Snt57HqShfISAqjdBJxIaxU2vPcSfUWw1cjxdeQ8iOS6IeUN3
	jZAziRzJkqylihh7ysSsR2uOMTuGPTk2xuYaPcflydDaH9bWyumT7CHSbpqnXdtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEq-006IGn-1v;
	Tue, 22 Nov 2022 11:10:48 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 18/28] um: Store full CSGSFS and SS register from mcontext
Date: Tue, 22 Nov 2022 11:07:49 +0100
Message-Id: <20221122100759.208290-19-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101059_209989_95065165 
X-CRM114-Status: UNSURE (   9.90  )
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
index 49c3744cac37..81b9d1f9f4e6 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -26,7 +26,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
