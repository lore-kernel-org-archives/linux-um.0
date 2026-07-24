Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C1C531C9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OI7mM3QsLe5msmgoTPtsqtS4NgoW6ylqXRwbq8QH3hI=; b=EKc5f5JcjPeqIB4mnr7uNHAdqM
	ZFK/t5iyddLoryVCitTHypWC4NhZQoM0t17CLbmqqyHi4IugJCaOwFtSIkactIkMq06eSKjCzrvf9
	Lp4UzCo7KeGOCgrHb9htyd9l50mO+4DBF4SMnwxvX4E+veonuhYUcavZw8hxEsRi/AEIXe2mG7I9u
	Ae+ErjJ4eUyPHQrRLvn7Y2PYJFz/6sdjuNbgeF5KpnAydIGP6leI5UVpAjSx7xHiviOiRIOFQRut1
	wJClkUWS2CiTlUsTzwjLf/XHrBUcGk4diEZLbJYn5MXwUk0VGZj9t1GG0JBgiVwXf7PdSq+ZK1CcY
	FwnY5YSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe4-0000000HGkZ-1shT;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.166.228])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGh1-3EXj
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:27 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9033FC0000FE;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9033FC0000FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929282;
	bh=wMjqlEZYnVh14Bap38tP88tLAFmuKutSDKQ4369eTWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZlKS5H9n0k9CSn7Quj4PBlP2j95+hScWQv203eAYsU9oldUR6byVp29DgK5cFezk
	 /b39+PjoHkoICuemlbQ8VdskYxiGL/elw4rucRNvgIQoDWoPU0W8QsKManTe46DEkA
	 E2MynffKOmid2RHm34nfBWuEgzWzaU/JVkYDXDRM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5FDE5ACE;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 6/9] um: Set parent death signal for userspace process
Date: Fri, 24 Jul 2026 14:41:16 -0700
Message-Id: <20260724214119.1066665-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144124_863627_C51104D9 
X-CRM114-Status: GOOD (  11.54  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

commit 801e00d3a1b78b7f71675fae79946ff4aa3ee070 upstream

Enable PR_SET_PDEATHSIG so that the UML userspace process will be killed
when the kernel exits unexpectedly.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20240919124511.282088-4-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[florian: upstream applies os_set_pdeathsig() in stub_exe.c, a file
introduced in v6.13 that does not exist in 6.12; applied instead to
userspace_tramp() in arch/um/os-Linux/skas/process.c, which is the
equivalent entry-point for the userspace process in 6.12]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/os-Linux/skas/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index b6f656bcffb1..cca016b0b29b 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -214,6 +214,9 @@ static int userspace_tramp(void *stack)
 				     (unsigned long) stub_segv_handler -
 				     (unsigned long) __syscall_stub_start;
 
+	/* Make sure this process dies if the kernel dies */
+	os_set_pdeathsig();
+
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
 	signal(SIGTERM, SIG_DFL);
-- 
2.34.1


