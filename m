Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D02C021BC
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YeyHHbJicmX42BLOtdOWs/TeOo3L3YCiBekHn9R2ETM=; b=0i2cjV+xoXoLgGW66E6TshWU0P
	2fUJOrs9yy5fXrfL7tPUG7B28JPw8mq1zket+pTLEoSkpAqIFoJAUygRJgbwCTApZl3uRTH2ahdjH
	bjKFzGUU4JMe3hwhrEi5ZAdA9pvaTJeYkpWg0PiQnfYWoJDfAqVAb9I0K3CmGZwwQrnkShq5XZBJe
	ypUXwSMDvXB/w6KIxkblHGjTSnwrD80YrD8Q3i7WBFjOzHNBraQ129i9b7BzIjCbW/z9pigbQf/1d
	KQOnztsSFNJ5n2PUCDww0M/kkv9ZlFz5GbpoQxGlzwPPBsRNtvmbCJkJdUU2ugIMpRGDisDgjHGPv
	qb6MHDbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8Q-0000000EnLe-3HzL;
	Mon, 24 Feb 2025 18:24:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2q-0000000Em8J-0cxT
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YeyHHbJicmX42BLOtdOWs/TeOo3L3YCiBekHn9R2ETM=;
	t=1740421146; x=1741630746; b=eXrxhpRhqqkKSuJNmp/6LkqSwodiJzp5V3J5euSueh0qyd6
	+yzTZa9sr0zWaankaQiLbrbSN0WI65dWZSlZJn4Cs5kmX8ReCiOY95SyR3VYAWZF97ZnRBcFunR7C
	qtcQfa0f7rT3+6rY6AkjJmNRk2VantII8EwZcu+nnM3kmAHdpRL56+jhd8uleIoUOFYCdZmU0PMIc
	mLgwynP1P3DNXjJ3linqP7W2Il6H03TQr7l93TJEQYXMFXOvtGwxE4vdkCepDx6eVMe1kWir8mtCC
	MQ+pvp3uzzUK2E9qdlczus5SaqlvwfH2T1y5DY0mb0RTLrjG3oT0m6JIaCOcLY9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2k-00000008tWp-35S1;
	Mon, 24 Feb 2025 19:19:02 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 1/9] um: Store full CSGSFS and SS register from mcontext
Date: Mon, 24 Feb 2025 19:18:19 +0100
Message-ID: <20250224181827.647129-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101908_185726_3D348CE5 
X-CRM114-Status: UNSURE (   9.33  )
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
2.48.1


