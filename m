Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FB4D11183
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q9dZaDbYSBQ5/epHT2by9c4RlB8+onY6hPI0juot0Kc=; b=aVi01WNAiUMuD6nOzErPSdeJLI
	n+FBVlpAousD8k/Q9ISeiRGWbbN9+0bUCcFBYrx8k5SO02OzdWHfSgC/Pxfyg0c2ZhGn5XeEZ2MTe
	y5+sZyNecVdN4wdjouElbDnBTlojWNlXJQGeCR1w7fkqzmfb1Lg+j78Hdyx/YK2u50ymXBhdi/URr
	6BsZL5DMdzgkepbJ4NeazdoM3gtV3VbMX6YAghADLzgV5FJOen9TkCNLQIpax1B+R7CWfWjBGjSuo
	d91wj+6pg3FP7qQJITGzBO9ne2y5gGoqpKzEPV+AydqkAOH0A4x6uSbvR9xxeEi49BTbK6x5rNHCC
	vHkcebmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dFy-0000000BgEg-0wFm;
	Sun, 03 Nov 2024 16:15:14 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7V-0000000BarF-0Hxw
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Q9dZaDbYSBQ5/epHT2by9c4RlB8+onY6hPI0juot0Kc=; t=1730646141; x=1731855741; 
	b=GskpWLdjaX6cU4wy8D7n1iex2FKeS8I6rNMl7656gxfKg/q2lU8Es9XwC5byRTaf7tFCuyL8q9P
	KNYEbvQPsdZc1q74YRDVxNhid/QW8tePI3nI8/rY3WK2yMJsF9bHcVAsvDU/e5lIUo4qqHEUw/1Hg
	w1yK8/PeAfPL7yk7j0a/mpU7AYHd2BwKVgxb4oCWn622fUILwrt+EtYbqXW7EaznB1+aVcm7Psq4v
	6HJ0hoqnrEKA7PT6pk1sgPwZpqF5npQzASFJwmCqkJLo0faD49YMg8pLHl91rhGgoDZUtM4qaZtAZ
	GvYokAHPnzbMEOyGMll/M3yK5qbTAFjht4YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7c7M-0000000D5Ia-3naA;
	Sun, 03 Nov 2024 16:02:17 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/5] um: set DONTDUMP and DONTFORK flags on KASAN shadow memory
Date: Sun,  3 Nov 2024 16:02:07 +0100
Message-ID: <20241103150211.1366452-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_070225_144045_CA674B0C 
X-CRM114-Status: UNSURE (   6.66  )
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

There is no point in either dumping the KASAN shadow memory or doing
copy-on-write after a fork on these memory regions.

This considerably speeds up coredump generation.
---
 arch/um/os-Linux/mem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 857e3deab293..72f302f4d197 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -39,6 +39,18 @@ void kasan_map_memory(void *start, size_t len)
 			strerror(errno));
 		exit(1);
 	}
+
+	if (madvise(start, len, MADV_DONTDUMP)) {
+		os_info("Couldn't set MAD_DONTDUMP on shadow memory: %s\n.",
+			strerror(errno));
+		exit(1);
+	}
+
+	if (madvise(start, len, MADV_DONTFORK)) {
+		os_info("Couldn't set MADV_DONTFORK on shadow memory: %s\n.",
+			strerror(errno));
+		exit(1);
+	}
 }
 
 /* Set by make_tempfile() during early boot. */
-- 
2.47.0


