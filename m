Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE071C636D7
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+kimHcfUf0HFTTi9gJKiwqbd0zKHj6oKbdP+WgCQMk=; b=VOqWUYEI93wjwP
	CNQShpcGMkQQs9zZPOtRN2MetMtUcx3PqJ/8AN4PMMzW8aXrKDJgaI+AyWChoGKD6j6iZaZx3P9x1
	X6hXnBYd5May9DZj8PgZKb53srtJc/T4wlVXRhRqCCK/dbWedxzUBt3owD2IXS/oaip6rLsKUkjpw
	EV+SSuVXm3k8AumJaDrREXwUp4gzho964HLbPaw2lX1x3XBeDVgEMlsgCkzpmqIg1WEEibXAbAnHU
	yVM3tOeCBE7r4CDdjllmNbQ8kcsIEOOo4Gnr96HoAp9/kMn2XcC6Nl/nVgPjZEEQC8ko+hSy4Qaqy
	GAe84hKm+0hCsypc0kKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQagk-007aoc-NN; Fri, 10 Feb 2023 21:12:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQaaG-007YSx-Cq
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 21:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tLscv6nbyuCDp1Q+111rbRhLuirLd9JyPkgvXYPPBkQ=;
	t=1676063125; x=1677272725; b=e3FdZMSamhQUpniMG4pYErS3tFSOer6lec3hxcEIEe1X9Z0
	VOrGwahf+wGZrqJEIP5Tc2m4iirPl650hNJBGZxrqaxvvowXhqdniTVkOdtuf5OV40evrLY0HsM5/
	CDw+3I0zvM+P61umMlcBDSTbJSM3Drlxo+BbJdKxO0uc6Se+zO0M7Z+zZIskp+iLvUybyiIrPLAKS
	fjwOiEdOtLudymEw1Z/SxOToaS9R4Jf8BCcghZnm0GEvolaZXjKlWQBhGLsqmVMEUBUP898rUGpuf
	AmMy+XfPlu3+8s98rh60hnVhieO34hIbghZ1rQPUSldp8Fyq0TaLsei3niVlg1lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pQaa8-008R0g-36;
	Fri, 10 Feb 2023 22:05:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] um: don't export printf()
Date: Fri, 10 Feb 2023 22:05:09 +0100
Message-Id: <20230210220511.d230e7374dac.Ib7df1cfd6f3b55ad7fe4f3a931e4562ba9d6edda@changeid>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
References: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_130528_490030_E9A8F7CB 
X-CRM114-Status: UNSURE (   9.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

Since printf() cannot be used in kernel threads (it
uses too much stack space) don't export it for modules
either.

This should leave us exporting only things that are
absolutely critical (such as memset and friends) and
things that are injected by the compiler (stack guard
and similar.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/user_syms.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 22ed13a9b3e7..1e9e92740b32 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -18,7 +18,6 @@
 extern size_t strlen(const char *);
 extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
-extern int printf(const char *, ...);
 
 /* If it's not defined, the export is included in lib/string.c.*/
 #ifdef __HAVE_ARCH_STRSTR
@@ -32,8 +31,6 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
 #endif
 
-EXPORT_SYMBOL(printf);
-
 #ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
