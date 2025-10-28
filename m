Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A94CCF9E0
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HTyTdfVLRcEcdUtzLzbBCl8vlxuUStbbRZ4WoJy5q2c=; b=lxLNrPBRaAYzDwat8tbNjg5/Nn
	SQvT17jtLezNXdV4W3d9mVgLPF4y9ZxtAoiKdNW8whXbcn6UrF8Y5wukQlIgecCzMcmxtYPA0dcRf
	0O4X+O93UgUhmYEpzii827IcNjNb8TIFawmlad2zbnoRBiuD8HvC2aivrN+m0Q6vcj4uBrDiN7UpU
	jrYt/t8pGdWphEhYUjI+pIPWOc8TyezIuM8uHEznwE1OmqpsMWrTjccgbZxV/RJXCeoTHJ8KxA7oh
	bkJAKak44f8bzymItK5HbA75nbrJpZg4yDMTk5eZSz0SXkChbtcLxw8YzXFETo/BFVegnDNPnjD6Q
	FRSbrrzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfbz-0000000FbW2-42RI;
	Tue, 28 Oct 2025 09:03:27 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfbx-0000000FbUC-3siq
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761642199;
	bh=oa18QKX0l9/zrNbFelaAjri3Nu2ogEOJV9SkekhMHUQ=;
	h=From:Date:Subject:To:Cc:From;
	b=gKlVBm8+5rI8Ix1xm8HYkLa0WTs+Xa9sbAw5SjORYeyAVZW1efCTXFr6dzFTvmf4G
	 y7HsaCbfkJHF6uW2GaS4ouJ/vr0ZJ6hhiUZ4hZLhXhz2J9y8gz/GpACd5hygdX9KOc
	 SOuG3xde40rXzLz1d93xLI0MMIJxXmc1C4dasNvI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:02:55 +0100
Subject: [PATCH] um: Avoid circular dependency on asm-offsets in pgtable.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAL6GAGkC/x3MSQqAMAxA0atI1gba4oRXERdaUw04kagI4t0tL
 t/i/weUhEmhTh4Qulh5WyNsmoCfunUk5CEanHG5Na7Cc5lxC0HpUPQs/pw7wSLrhyzvDdnSQUx
 3ocD3v23a9/0A7IcIwGYAAAA=
X-Change-ID: 20251028-uml-offsets-circular-64bd45b0e172
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Tiwei Bie <tiwei.btw@antgroup.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761642198; l=2009;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oa18QKX0l9/zrNbFelaAjri3Nu2ogEOJV9SkekhMHUQ=;
 b=OVVJ6XiAIwfOGNjqdKBxkJURJ81/moXtAdeO8yQBzBW9u2Vin6xW5z2/tz1VDO6XEWJVxEWXD
 Bb29WTwZKlaCE5h6M6dh02jtSGHRJIP2IiSXVbUvLiuAtiNBmGGCE38
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_020326_106996_D6E68E05 
X-CRM114-Status: UNSURE (   8.70  )
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

Recent changes have added an include of as-layout.h to pgtable.h.
However this introduces a circular dependency during asm-offsets
generation as as-layout.h depends on asm-offsets and pgtable.h is an
input for asm-offsets.

Building from a clean state results in the following error:

  CC      arch/um/kernel/asm-offsets.s
In file included from arch/um/include/asm/pgtable.h:48,
                 from include/linux/pgtable.h:6,
                 from include/linux/mm.h:31,
                 from include/linux/pid_namespace.h:7,
                 from include/linux/ptrace.h:10,
                 from include/linux/audit.h:13,
                 from arch/um/kernel/asm-offsets.c:8:
arch/um/include/shared/as-layout.h:9:10: fatal error: generated/asm-offsets.h: No such file or directory
    9 | #include <generated/asm-offsets.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:182: arch/um/kernel/asm-offsets.s] Error 1

As the inclusion of as-layout.h in pgtable.h is not yet needed while
asm-offsets are generated, break the dependency here.

Fixes: a7f7dbae94a5 ("um: Remove file-based iomem emulation support")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 1a0d7405e97c..3b42b0f45bf6 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -45,7 +45,9 @@ extern unsigned long *empty_zero_page;
  * area for the same reason. ;)
  */
 
+#ifndef COMPILE_OFFSETS
 #include <as-layout.h> /* for high_physmem */
+#endif
 
 #define VMALLOC_OFFSET	(__va_space)
 #define VMALLOC_START	((high_physmem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))

---
base-commit: aa3e6faf620b1091ae85b07c0106918d48fcce05
change-id: 20251028-uml-offsets-circular-64bd45b0e172

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


