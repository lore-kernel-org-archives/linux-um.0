Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BDDCCF9F2
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DYDyl1jRFommQZs0Hn+zTZFO0zr3qtFmo87urpSaDo=; b=IAJZecV6AxP4zm4/SFdzT94VRA
	uoQlu7p2bmzNp7hHIipWuunm1TTM8hFwx5Khgrb6pkRKxmgrslL+2slWWHgFqVoz392QvKOBATb4t
	+V+kZez4BRK6Q2V8wQ8P0tf6xoBf/hpjFemPfrNgGlgAmK4us/Rq2UitJMBPmonJsbNOgse2dgu/N
	+BiGG5p0tBhPQJkd2yNR1IPyhbtO0g6GTkJpqLnwFqPbXaldLuGCEu1DyO43rD5YHULclXz2ZZTxT
	YNzRpN16eyOjXhBxHVftW2ion0X8C/FSAG3EXnnbGZvzuv+t39c8w3TvFbKAICJ9wjXRUPj3eFLim
	mDkRbmyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpc-0000000Fd9a-3Gbi;
	Tue, 28 Oct 2025 09:17:32 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpU-0000000Fd0O-1yI1
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=//QBJKcVdfGqAssYU8JT7yXYBZT3MIx6+94MEhcclCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RkSCx4JkyF5lLQUNeM42rFHtDmCXVpviOOcGrnETa/0HpC4Zdw2nuYjdH/4PFl6LC
	 M37gJsTtA9t48ctKGxpR9J+cgERSI2OA89fLXif/TGCIYqkwtsOm90oGVGKh+3v7/O
	 FWcQuK43JhS2hqil05ihbYlwxNee1T0QddlgMNzU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:42 +0100
Subject: [PATCH 07/10] um: Remove redundant range check from
 __access_ok_vsyscall()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-7-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=919;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=//QBJKcVdfGqAssYU8JT7yXYBZT3MIx6+94MEhcclCI=;
 b=Pyl9VMqLf2pp8Ulil0iQPsRNz8apL+lyucc74Nzhhix207oGH6tlAC45ZUnY4VWNUjWWKJQcx
 j1dxaqoDJmUBaathXH3i6r4J3xVGEUN8K6MC7Th5us+FKD8hWjRUdLv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021726_023455_F9212460 
X-CRM114-Status: UNSURE (   8.17  )
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

The only caller __access_ok() is already doing the same check through
__addr_range_nowrap().

Remove the redundant check.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/uaccess.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1c6e0ae41b0c..3770bdeee100 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -17,8 +17,7 @@
 
 #define __access_ok_vsyscall(addr, size) \
 	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
-	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END))
 
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))

-- 
2.51.1.dirty


