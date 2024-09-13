Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACBCFA3755
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e71nPzF8D5D8mLRAjIlrMtAoygssgFlaf9Mr5QMWHsw=; b=NHE31v1VDXiZXkS09HEBlxRAJN
	FGQBo7TnScCUXnW1Wbt1LX3zKF+eoj62oDnAy3ZCdaXmUyKywJ4TDjEF9KmBjJkTQ1YAxk5+6U4qK
	FLmD/7F1ze91GZKa6DzA0M04rwZm+baR+6gP6H5rWbbuua8cnVKLqT2EohmzPhZXWOyY/dltTLSCo
	4CHUypIbex+wjiMZTfwldKFdfsiF8gs0z8pXVDST1kHPJVLS1Tfa4qgZfEN+1Dg8slLaR6fLKWBgF
	ng7csbvOhsoGSUcfMxPuhPDzM62HFJwOVjCThpUjtfYSkl194Q0Q20D6MNYVjnL+T9t5kfpBnzpyV
	BPyDlvBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c3-0000000G4oH-28GB;
	Fri, 13 Sep 2024 13:45:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c0-0000000G4kS-0Vyz
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e71nPzF8D5D8mLRAjIlrMtAoygssgFlaf9Mr5QMWHsw=;
	t=1726235123; x=1727444723; b=OPZ9jjv86TgLGEhv+URLnKaVQGP1JWaje50VFsboZMe9ztM
	+ilYCV3uRYdnyyTTmUzge9fqkoqZx2/k29SzVldp2WxUex4MU9A6HrrvzTLnzwteaDYCiLFlJz0ua
	aBjbAID1/8kHBW56KH7le7TWT6aJFs/KO/JnfsijjzzyyauZSAIK32ufUHfycA7Pf/dkM5bEJEP1X
	aD9hpMabe22gxhpH5PqyuAqTnIrMEWcVEDDplpHiCwxGKcSyK7vAm0RpuNtkMTrJy2nzZQxRAQV6n
	UA6DzHHBy0wYUeWk0YY+0xwQNamboutBb9++zq0t+3ot29M6c0ujhFtHENh0bP/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6bx-0000000GZ3W-1lOn;
	Fri, 13 Sep 2024 15:45:22 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 3/5] um: Remove unused os_stop_process
Date: Fri, 13 Sep 2024 15:44:40 +0200
Message-ID: <20240913134442.967599-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913134442.967599-1-benjamin@sipsolutions.net>
References: <20240913134442.967599-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064524_235221_B8116AD2 
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


