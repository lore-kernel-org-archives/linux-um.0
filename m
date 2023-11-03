Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F410C0032E
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=237A+6I4WyB8jbNgd9Tfx4yfOPVjlQDagmaSDqNGNww=; b=WXnZlmsZwKgMBc
	p04qO8AuuoxBNWejqZCQkA7FoBvLX7cOV8785teyCC73Wsz1HTEceh0UnjXFCAGZlAItcKhAZrcVr
	1tQWtaz5Aqxbi80BZ4FzsGB0vKwsVgrYw1/TCTDlEBJaQRm6RnJt407loctk59vObVSt0yQBudPPE
	bMcTrOLUUcaXmiz4LVh03Z+4+0byghU8g2IhPV8HQxwiwVo1mebFXKWM8wrHgFvUCvMR3i/+giXTE
	9hUfzFrnINmiccky8UrtNjX6P1kpJil9d6YV/vUDl9EH1LUj5UGUwV8Sx6tBmtdv5beyPwxjbvp0J
	6TaTUOVylWM4+FN2ddlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFc-00Bnsd-0Q;
	Fri, 03 Nov 2023 16:42:28 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFV-00BnjU-1R
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:25 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029727; bh=LMMvyrqtbqFEhkufk/o5JrTwDgy68ORlN4vpGAREsec=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 hEgBIOQP+ETk6nk+EMguD3zmMvb3+ICyAERfvnnV9L5BQB8+yzgN25ZhBUgzkM74lNdBEtUbLvhA9WJw6e/QBw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029727; bh=LMMvyrqtbqFEhkufk/o5JrTwDgy68ORlN4vpGAREsec=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 cwmwueceKMlq8MHrdSKKKXp2BV33FJFPX/7LKBS6IV5ICah4ba0kPTyvofF/x/TJSMBcpHeUju2WevOaaww/HjwjBFxTmwLoZm+HrjEc13UDdcxhrGJxh9KZPCBZQcp5uVimrgiz8iCnlhDRO5hchZTvIgKRiMyGKUXB2pgR5Xc=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:58 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:49 +0000
Subject: [PATCH RFC 11/11] um: Remove all TSC flags when using Time Travel
 Mode
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-11-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1331;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=a1pxx5yM7G85+ua7gwOMOgNcOG3EHWYEgMlINwEg6YA=;
 b=aoYk9ZP9BEcxBOO09GqIsFUlw3PhWpKkP6huEzmon+A9KqF9YyGwpmb7t+VAmnWAe3PYWRI7o
 4doD5MeOaJUBZ0xOVOYPvyRQEWm1+QjgV3uLU+DNXkgNeZycQjekP5Y
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 040BC8943490D5F923B9FC337F883CC19014F798056282B10263A1824C9577212000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094221_787995_96392B28 
X-CRM114-Status: GOOD (  11.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

In time travel mode, the internal time is only advanced at discrete
synchronization points, while the TSC register continuously increases.
Although the TSC registers remain accessible, we remove the TSC flags to
indicate to programs that properly check the TSC flag before reading
that the CPU lacks a proper TSC register.

This change is primarily cosmetic but may encourage some programs to use
gettimeofday and similar calls for time measurement.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/um_arch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index b1bfed0c8528..6bfd531b5f87 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -30,6 +30,7 @@
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <timetravel.h>
 
 #include "um_arch.h"
 
@@ -284,7 +285,8 @@ static void parse_host_cpu_flags(char *line)
 {
 	int i;
 	for (i = 0; i < 32*NCAPINTS; i++) {
-		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
+		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]) &&
+			!(time_travel_mode != TT_MODE_OFF && strstr("tsc", x86_cap_flags[i])))
 			set_cpu_cap(&boot_cpu_data, i);
 	}
 }

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
