Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B603FA3758
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QG5hErAujsu+pg/xUUQALAwExiMQEHr8pgtAkpY0F3M=; b=M+ians6PX0OUtietHLOXkEp+W0
	PSeBWjaUi7ZPdwqYjQIcFRthmh+Ez8fOzYC9B7bpuI6tPyjNFRwF/4S5+BI6gHO09vCfT1S6wo2g3
	iKIHwvnACBFBBuhAFkyp39oUR8Ev8K0EdJRiohaNjGcZnJ7cuy1qPpKCTd9H15Ck+heID87kJl7kF
	DKqUmT2e9/i6ysIyQL++QLh+MTeRxvdbhANHz00mTiBVcoL4oDw+6FcaL9sIjC7a/68pGmCwK7Ups
	j73JF/sxa6zrj5yzxLnq0YewM1q4wVZJY5DQgZeLjFhtPnUCKWF1X5+l2zx/vtCW0DqoHzIs+1yQN
	tTz8c1Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Td-0000000G3By-2PCR;
	Fri, 13 Sep 2024 13:36:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6TD-0000000G389-3qmL
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QG5hErAujsu+pg/xUUQALAwExiMQEHr8pgtAkpY0F3M=;
	t=1726234579; x=1727444179; b=bV32Be/wBVWQ8KUe0fkKQsP1kEDhTr4RXgh8pRO4Aip6zS5
	wr1hOp1Hns5e52ap2UiRlSeSjn5I72+/VH+byQdJ64871sR8nqhsJqjccXYqzX/CEPSSXfKIpG0mL
	hvpMpQtb9mTyHp22GDgZtxSTkNaxeiO7bOR62HPFt2cZLTo5CUnhAOQ/0yqDU1QIlW2LLuGR8Vswk
	nPypbhfcf9OtG/YtBruipTOOPL7aOlz+GUNj3edKN9Dp9JEPii0QZgFKuaXvTlrraYLp+GR57CLwK
	vDiDPzv3AVm62yeOynkW1WypurluL6Nh39FE3WYSIEEHArdvi7Z4iuT4P+8qOAQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6TB-0000000GXf6-1w4w;
	Fri, 13 Sep 2024 15:36:17 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/5] um: Remove unused os_stop_process
Date: Fri, 13 Sep 2024 15:36:00 +0200
Message-ID: <20240913133602.963167-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913133602.963167-1-benjamin@sipsolutions.net>
References: <20240913133602.963167-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063619_976187_A45A4ED0 
X-CRM114-Status: UNSURE (   7.41  )
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
---
 arch/um/include/shared/os.h | 1 -
 arch/um/os-Linux/process.c  | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 4bdd4fb5dd80..a94093bfa5e4 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -200,7 +200,6 @@ extern void report_enomem(void);
 
 /* process.c */
 extern void os_alarm_process(int pid);
-extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index b25c226c5491..d1f5e6002805 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -23,11 +23,6 @@ void os_alarm_process(int pid)
 	kill(pid, SIGALRM);
 }
 
-void os_stop_process(int pid)
-{
-	kill(pid, SIGSTOP);
-}
-
 void os_kill_process(int pid, int reap_child)
 {
 	kill(pid, SIGKILL);
-- 
2.46.0


