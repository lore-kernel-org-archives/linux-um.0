Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2325C021B4
	for <linux-um@archiver.kernel.org>; Thu, 20 Feb 2025 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DA3uhlCDI1A8BDotF0N5GRp5MWr0V4pEHmnZHzSGNPE=; b=YC//KjX0ZISGMMstQO4MEvUEjv
	+iOLDOKubKqkqe/I7pJd70x0AbemOpGeWrI1UwAMAxpKuhd8wCs0LHyrDENvMmKr/wSRAk7cpKiPb
	XPDPvBz0IsAuYgs+m+yLp94KIVz++AEG8y/IyrQVJ6hfnZQDGol46xhTCWqcwsG4iekJimhzhtPXP
	53BNHFyd0EDVPMvycdb3jaL4yP4PrR9SZMkJ0hb/wrX/nftDsCp7hsAdbXA6/VHdCvDBVM8w4peZO
	9BW4PozgnVGF+Lw869yrx0pWhIN92lAk3RZgXFdUdWmMGaKvC2neL4OGYbU80H55V2D1KMcg+YR1r
	t/KQbTVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlFEn-00000003BKW-1gln;
	Thu, 20 Feb 2025 22:41:45 +0000
Received: from mout-p-103.mailbox.org ([2001:67c:2050:0:465::103])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlFD9-00000003Amx-24zO
	for linux-um@lists.infradead.org;
	Thu, 20 Feb 2025 22:40:05 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YzSqz1hl1z9tDy;
	Thu, 20 Feb 2025 23:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740091183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DA3uhlCDI1A8BDotF0N5GRp5MWr0V4pEHmnZHzSGNPE=;
	b=f//Vi9u/xq6akrnJWV4SMJm4ueQB4UZlcbQa3xbXHzlyKLZEGAQz5GOx0W1xoDwPY4Kk9y
	Tph0I7lxGu6YAlY4Vky1I5k5LOBTMSgQ8U4TGn1al2n6TyvnEvfmKxgZSdxnb7RTsNDjzn
	Ac0QP0q6IfRwjP7l1+QJ/v/aF1Le6BxR/b3NX587g4vCT4JOlImK7mozPKp4GzKiEOHS04
	UqvPjGGcFFastPKxjSK7p437yw6nru/GBcOyd3sZIdAt2l8hO9cRtxHVVYX0f+/iE13K7G
	97jNVI5sqImx72rfBRgG8HdI9BSGFUwJ54gU9x5gP2E7rqOgtUCL7AZXYkmeLQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 20 Feb 2025 17:39:40 -0500
Subject: [PATCH] um: use str_yes_no() to remove hardcoded "yes" and "no"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-um_yes_no-v1-1-2a355ed2d225@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIACuvt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3dLc+MrU4vi8fF2T1DRDgyRTo1SzVAMloPqCotS0zAqwWdGxtbU
 ATLVp01sAAAA=
X-Change-ID: 20250220-um_yes_no-4ef10b52e6e0
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=J57RcTCyWAxFm2umO0g+4bB4ISjq2IYkSSr7ajlq/gA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBHOWZyMk1TS3JEb0FVdjA4cTZkOVVlVU4ycFZjMisrCnVsUDExbzBzaGJ0ZTkvS2tH
 bWQybExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNLZlN4a1o
 zaWpXQ1p4amY5disvdmxXRGIxTmlSZFRxczRkL2ErWjl6V3ZVTXQrOWRVZGhnei9ETTkva1BmYg
 pOZjJVeDlhcG9WNXZ1TitGUFpqbXhiRHhpRm1tMXFUNVJSYXJXUUdwQ2s3Rwo9QTFqbAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4YzSqz1hl1z9tDy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_144003_679827_021DF0A6 
X-CRM114-Status: UNSURE (   9.41  )
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

Remove hard-coded strings by using the str_yes_no() helper function
provided by <linux/string_choices.h>.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 79ea97d4797ecc9c157ee948ae0505bcdef84da5..7f050783885a0faed0a4f334716d2532b982bb91 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -12,6 +12,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -78,7 +79,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "model name\t: UML\n");
 	seq_printf(m, "mode\t\t: skas\n");
 	seq_printf(m, "host\t\t: %s\n", host_info);
-	seq_printf(m, "fpu\t\t: %s\n", cpu_has(&boot_cpu_data, X86_FEATURE_FPU) ? "yes" : "no");
+	seq_printf(m, "fpu\t\t: %s\n", str_yes_no(cpu_has(&boot_cpu_data, X86_FEATURE_FPU)));
 	seq_printf(m, "flags\t\t:");
 	for (i = 0; i < 32*NCAPINTS; i++)
 		if (cpu_has(&boot_cpu_data, i) && (x86_cap_flags[i] != NULL))

---
base-commit: 27eddbf3449026a73d6ed52d55b192bfcf526a03
change-id: 20250220-um_yes_no-4ef10b52e6e0

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


