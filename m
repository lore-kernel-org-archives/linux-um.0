Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7F5C3ABB6
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UisTZzEN2Lis5/8Lo4ceIvk9YL/sGjWoGM9bwQgVKFI=; b=voejuHClz4RMR6viIkXpB/W2rG
	xTC8kf+mzOLFkyn3URVcAyw9+fI0cmBCzEgvqRVxtdJ/UD3L27W2zHJyMB2cn0yp38odr5Hqqvftm
	1rPRt4Z981tZXCOEhz8J79VSA07c7s1h6gkpDDoNY7WFhl0UI7YzXEhpXPiRtXKVyn0b/ckpGGPRj
	SPflBCoXMgBeLSMnkMWqggOW7SdjV3mFVV8CBODsHGl488H9C6oHGKU6fVcmI4r4UVhJfdVdV9A6w
	/NHuOaBPf+TnlQZ20dl4V8+JKlWgk5EPY6rEtiTZdkkU7UGoqdXOh9RrMGERnnmH6DmWoridHEMR5
	oqE1F9aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4fG-00000008syO-1V6J;
	Mon, 05 May 2025 22:51:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC49c-00000008ikr-2HSW
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 22:19:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 00DFC629C8;
	Mon,  5 May 2025 22:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3DC4CEEE;
	Mon,  5 May 2025 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483555;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNulUB5AU7oz9HvkwOwQ5rAhGoIE+OrXEy0iQgktSpwJNv5uow5EKgRQOx6+Mfeyz
	 H5nrD5zZKOqaKLJsDNoF1X7I6fTQ90gCDChzoLPgMfTftMBnuRVuu9WFMJoE5bHHdS
	 yThXZMzUDgSWjBIahFzgtk1Qd1YnMevDR5vsU9PUFl4U4OmwaR0s1IzDaL2b27pSzj
	 Qoo7i/e4XDxOod9hFwuPkbRNt3dtP+LP3QGqsXvFOTzLwsjOoIU0jEnzR9HeRMhuT3
	 YW4qyCGcxoEac7PnUw4+obMiJQz/9ApR3MjLgE7D/B2pW+VkwHaKyhzSlcfLlIexwX
	 YMu+KOy7a++Kw==
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
Subject: [PATCH AUTOSEL 6.14 113/642] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 18:05:29 -0400
Message-Id: <20250505221419.2672473-113-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit
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


