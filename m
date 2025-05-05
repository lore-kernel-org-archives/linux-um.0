Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F16C3ABAC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 04:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgnN4Domvqg2C9gUVOcTsb3vsqp3L1SX9kWq7T1Rkh4=; b=Mfa5fGu29tnKduLYeYnuVeYtpn
	Z6PXgicZR4BMGRqucOQadHBzpn+/Y0Xo7OSMGQTLBq1RXd5/I+AQv3sPq43GtBvXpb1N5Tq2gF8yF
	2RBPXNORDXD3RcJP7iiMJwG0XbOhNv9cBxIcBZQ0qiYyiY5aB90exgW219eutOFbuqBpxc06cqpxr
	7FevY2jOzZ4atK65o5VMpt1Mf5YBG8N9LZBs3fWIroFy7kvExaI9LFBskDVjaHnluN+c77jnY77sB
	hm2vCbBDHOIrmtfPE8MYJIOB161tFNcBWnzymrqhmZe1QJgNZlpzuErLnAXcZ1RAQI2AXVA2IMzc0
	0hih1o1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCA2q-0000000AFU7-0bsz;
	Tue, 06 May 2025 04:36:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC55V-000000090so-2mur
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:19:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F2D45C5AAB;
	Mon,  5 May 2025 23:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F2C4CEEE;
	Mon,  5 May 2025 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487143;
	bh=o6vPQm8ORAMEIjP7fhptjMtwSNq9nMRVlWGY99NWjZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSrc4YGQXNcraedU3V9MzwlkEmcOiZF+MaSYYjotDqktpWMZFN++hOvTMeNeFmfzh
	 2yA1SDlJ8HruqWDIzeSgNZvtt28MIK/m6tI1AakTe/KaW0Ot9soVf7kaFjJ4E+xdF0
	 OE5FwOBc1uUzOLtl5W32o/QBSbXs8tZJaXiyco81Iw5TAYC7LGEWOtkXakoHTAnBpF
	 SBQGUL4GQBLvgSOD+j4qWsmY11aR/z6at+dMXoFe4eKG59COieSRzHO8REmMNLl6gQ
	 JHKbfsn7H5L7e7VLUe8vo1Lk5xab6OR1NgNOdW92+a3K+DDAkLI6I2WrGwxd7tvLVu
	 oKDXQOTTM4a2Q==
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
Subject: [PATCH AUTOSEL 5.10 022/114] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 19:16:45 -0400
Message-Id: <20250505231817.2697367-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_161905_762130_7B75992C 
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
index 49c3744cac371..81b9d1f9f4e68 100644
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
2.39.5


