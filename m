Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06981CCF9F0
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KysYQJEYX6mkJORaKH4woAy4aN0wX3ajbyMpeUIWgpk=; b=E69fHP6IgfdUA+nXesroCvxuEv
	89VaZAByPORwsk4IAPZNHoAq8Q0Mc7n2TIlhbuIuci9PNvA3trWuRA1jJy53YGK2cCOcsQfRfKvRp
	w8axXl13c0vHbaFQYSLFs/ODItfgXCYHetqEpUo91+nRbp6e2qa0K5Gsu89Z2fN67ZtbAYKtAziiH
	Qsv/nMhDFtgeadytlVrZeFHCY85btMAkDw1x9Up5UwdvqXkXczTB9c4Fj5ShT20ZYqVw9PR5S6JRV
	SXYn9Z42YfNtuPORSzGonFjyXa/I2PNI8mYUsjqnqwAwVQrtY5uscSRaBKLeUM5wsmU5pFwaHqh14
	vf5GZXiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgw-00000006V0U-34pX;
	Wed, 25 Sep 2024 20:32:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgt-00000006Uyt-0wbE
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KysYQJEYX6mkJORaKH4woAy4aN0wX3ajbyMpeUIWgpk=;
	t=1727296371; x=1728505971; b=B70J2Smm7r40TW/njx7zA0vvl/hGw0H5k9nJ4Hd4VvRwkdc
	RUqvhJowDO/2gVvVXdAR3K9/cRsoZZSvYD0pLiG4RH1anjNjyxnjjCnrGqwAA7Ja/JAxsuV+HvHvs
	pbJmpi819GGBcEBryC6WPb5EMOVLilIu4JddMw41Bh3EkhIh5pdnHM89ubnFPaGPa59aZJ0DwDkCw
	P0yo0Fv2tALjdfbjw8Zpta09eB6nunzJWUti/3HrSiA/2ZfkFIHGUmesik2FdvREDz4fvGh0WdOZk
	5TQeDrUf5KmjoqF6DqoCCoqAss884AjXF7SV4PDmPA4ed1fVgO5GOQydUvmQrjMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgp-00000001A19-3BHX;
	Wed, 25 Sep 2024 22:32:48 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 2/9] um: Move faultinfo extraction into userspace routine
Date: Wed, 25 Sep 2024 22:32:25 +0200
Message-ID: <20240925203232.565086-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133251_290211_A66B1F94 
X-CRM114-Status: GOOD (  11.81  )
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
not know why this difference exists.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/os-Linux/skas/process.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 95376357fb17..24a09dc3c83e 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -176,12 +176,6 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux
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
@@ -525,13 +519,15 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 
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
2.46.1


