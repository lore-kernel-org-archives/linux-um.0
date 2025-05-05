Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A77C3ABC0
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UisTZzEN2Lis5/8Lo4ceIvk9YL/sGjWoGM9bwQgVKFI=; b=sWv44tH81mdCcogl5yt3lbJFmc
	vqS5iJaacO+BxcVbEqF+yDb7baWDm2t3mHe1lVpe3X6Vdh9ebs6RISRkg4TYDN56wSWbRjThjJgrE
	5aGkJwyoxLVF49kySgsfSGLMrk0n1t1dkMG64XawE33moQZDxWBGkYVvP0VNiN/SLsJyER/xhRWeq
	S9hwA0M0tBRQ4JPIY7XcHF7gY000RjEAvdndl8RIiny2Ux0At0uspOrsSYn8IUR5GfK0ECdRCkoxf
	c/FdoZK1N0lcX1GzFP6QqBlGEd4E14kZCRTvbkAOmtZk1cLiFrAJwblv+gvoFKlHpuefBWi9LHsDg
	KqZzM4vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC6fG-00000009PhY-3YHW;
	Tue, 06 May 2025 01:00:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4W2-00000008q0j-1U9F
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 22:42:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0FFDBA4CCAB;
	Mon,  5 May 2025 22:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A3C4CEE4;
	Mon,  5 May 2025 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484945;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0JIAJ6K2O/McaKT/B1QQHdMVTaQFecF5DCLtOfC+xz3q8G+U53zygMuH8g6QF5Wv
	 nybzDppBBlX/EYPT4qofgS8MgKGXHoaWUM7jQZZuDDzjDDPRvaxZ8KjTlqCMfbhYBz
	 tq9A12LreBMTIl8gyNz6PehNTAZENKEhAYpUSL2lAkJQiXBvObu0VwBy3DeDZAaaC7
	 W9Ns1kXSCPd49ZajU7tqLBw8LpESXgQIjTFNlp8an0MYgmCPG1yWTcqssvnfPRZh2U
	 cJv22t7zU1wtdU1SIgAEr8iyIM3EBOx6ajeltcVm/w9DD21Y+F5w4kvMS+XSOJj4de
	 c90iDNzKP/s/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 089/486] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 18:32:45 -0400
Message-Id: <20250505223922.2682012-89-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_154226_460282_88B5493E 
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

[ Upstream commit cef721e0d53d2b64f2ba177c63a0dfdd7c0daf17 ]

Doing this allows using registers as retrieved from an mcontext to be
pushed to a process using PTRACE_SETREGS.

It is not entirely clear to me why CSGSFS was masked. Doing so creates
issues when using the mcontext as process state in seccomp and simply
copying the register appears to work perfectly fine for ptrace.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Link: https://patch.msgid.link/20250224181827.647129-2-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/os-Linux/mcontext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d281177..1b0d95328b2c7 100644
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
2.39.5


