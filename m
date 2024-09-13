Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAB2FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmcRKJ8gxXIAGNxazW2q4xk7aMMnpLlckt3O58M4BWM=; b=ECwgQKeL1dddUsLhuyVMqHbKPf
	Zqf07J6b5oOn+sCmkFY34Dms0WQb1vCNPwmCYIL9weX3DlYm1xGJYbPc8crDTFtyOtLrpmtV6zQPh
	OyibLJnajMNpZcclCJ6WdT46fQJuLWXnj3beHICwm00vQo8hjV21ji0FoCetc2+CyR2Y1fSRSezHo
	PKBt2f9QQDc9I9CxUYoWJ8cEcRURejvstGbhFuWOmtXMvgMJ3Wu89TVgdSw6qn+ob5FdcUtuS3+jc
	s9Hko1thnQ6A3GxlnGgWw8c0804OXHl8W9r9r8LFrwHsaxEZiA2hLRXaRgB4vrye/aOTEXqalaglQ
	lngpB5pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c6-0000000G4ql-4Bxw;
	Fri, 13 Sep 2024 13:45:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c4-0000000G4oK-1KH3
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CmcRKJ8gxXIAGNxazW2q4xk7aMMnpLlckt3O58M4BWM=;
	t=1726235128; x=1727444728; b=PrzY6jEQmJIzcBWKBHZo3USEFsfeBMUUJ81DA5aZKlHywtY
	We7O3DOixVQ0hxbwdgjTticqJYz4pZxi6Ft30D6YSYIk6urDIveeOL7qVpHrmIC99MR7iDG+EJaB4
	whMtrajfAsk5TbOAEPe2dsOVrgrpNG2iHt899uiNYorLCL5XzYB9sbtWSNA47ws3CfAYfY6FRs/EW
	WNwrForQbWJ4KWmaWMDaOAwjDjzZ3wF50CLi1SozHQdXWIo+icRUyCnBOOASWxEQokOvZovIxPwAd
	UTlYPqv/iPfK+zv4qd/2XS+Ey9UK25Eq3NP73Ulym5+GBEdw0LJt9y5C++tP7RHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6bz-0000000GZ3W-2Yju;
	Fri, 13 Sep 2024 15:45:26 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 4/5] um: Remove unused os_getpgrp function
Date: Fri, 13 Sep 2024 15:44:41 +0200
Message-ID: <20240913134442.967599-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913134442.967599-1-benjamin@sipsolutions.net>
References: <20240913134442.967599-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064528_408371_60560222 
X-CRM114-Status: UNSURE (   7.60  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The function is not used anywhere.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h | 1 -
 arch/um/os-Linux/process.c  | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index a94093bfa5e4..e54f64f55bb7 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -204,7 +204,6 @@ extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
 
 extern int os_getpid(void);
-extern int os_getpgrp(void);
 
 extern void init_new_thread_signals(void);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index d1f5e6002805..f20602e793d9 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -53,11 +53,6 @@ int os_getpid(void)
 	return syscall(__NR_getpid);
 }
 
-int os_getpgrp(void)
-{
-	return getpgrp();
-}
-
 int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 		  int r, int w, int x)
 {
-- 
2.46.0


