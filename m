Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07395C3ABBE
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 03:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgnN4Domvqg2C9gUVOcTsb3vsqp3L1SX9kWq7T1Rkh4=; b=KrVBouPH1AG6Tf+/TFF/248U40
	Th+uS/s4lju5wGlrrfBi6zXBY+E/2HGGjllxy+9Sqj2U49VXU2cdsNZwQwPTz1Isg2HNoHpALbN4I
	J30TiwxKdhOc5qedgbKO5gmKZXccj+BarTzu8MQbKOUB+6XzQMy2drMYWoXHXkI5csQi+z/Vodm/o
	kGt282qkcG2DrFKixCp4fhr7cFBOIwKbwXTbLKdv2edykxxSXysApFvyZxm3obN602jpc04ilxO0Z
	vm5oU6rJspnpwl1KVGa43Z5n/kzZmYBvBgU2hODpahq6zEaWaNalgaqllQERZUCaw0B6RdkkcH3Nn
	IahDSuAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC8yH-00000009zRX-09ZF;
	Tue, 06 May 2025 03:27:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4uY-00000008xev-2E57
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:07:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F182629C6;
	Mon,  5 May 2025 23:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723DC4CEE4;
	Mon,  5 May 2025 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486465;
	bh=o6vPQm8ORAMEIjP7fhptjMtwSNq9nMRVlWGY99NWjZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJkvB/WFqaQckMsxUmHd6lyoc8jegZliByGrhww8MOaIMKFoFvRHvgyB9fev6elPh
	 XbBRLTN1rIAPJH0uVUiqqc+nQ5PSsUxWBXToTd0epH1XDlL7W8cOlvzfIULO/wTE6T
	 qMtLXi6bRpRvwvB6J5qWHQH+n5eGD6yW4ZwXrUWaG88y7KdWFMbsnhZJU1bvEtdxhB
	 Skjc6a2InmYIw8yApzGEqiX43le/CgD5+BNiX/NRnFvb0coSpF0/ui2pwV6rU7Ffen
	 b4W9k31chfqFkGCBxaB+MF4Dfvj2HEEbzEk8apb9uAL38/FdBI48zwRN/bZLzMOu20
	 o6veLcSAMc/4Q==
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
Subject: [PATCH AUTOSEL 6.1 044/212] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 19:03:36 -0400
Message-Id: <20250505230624.2692522-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


