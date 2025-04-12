Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC261C369A2
	for <linux-um@archiver.kernel.org>; Sat, 12 Apr 2025 00:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t0Jdvg9bhsj2TlLlgKK4kFPCwh8w3DW34G5/8k1fXRo=; b=CsU1i6vQMnokuUe2XWNjTgwnrW
	+M6wNfORZ38cp3yj3tGW99CCfNNyIcXfikV6v3fn5Omx4EjH30E/zZVUbO5ItACjRgEZ6bK7siRkm
	g26i6H0km15PC5gBmcN2vF9oEAKt/EBDVoqcuHQCUK0O7dfMMLP25BFIOfa5tZbELRVW8sgldOcNl
	RvikntbXmpiBUlQe9Slrug8dSRTkcg8L/Ji+aUzak3wAFaTj3CQlrzgVNmJBfx3Kj7WgsHoKMrJpb
	ZWeo5JHWEQzy3ag2W/aiKoNBj5OFewY6dD20cLnHoEATrcjsTH3LhCuifau90N23lDnqISps099Ja
	tLM1Rbkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3P8a-0000000FCmt-04yR;
	Sat, 12 Apr 2025 00:54:24 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3P8W-0000000FCmK-3Fc0
	for linux-um@lists.infradead.org;
	Sat, 12 Apr 2025 00:54:22 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-736aaeed234so2167013b3a.0
        for <linux-um@lists.infradead.org>; Fri, 11 Apr 2025 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744419259; x=1745024059; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0Jdvg9bhsj2TlLlgKK4kFPCwh8w3DW34G5/8k1fXRo=;
        b=TL2nkG0foej4ghwV9gL+aOzztdBAst5fWzUYmnNvILag0xCKHavOXN/so8PpbByx1i
         RmtBuajL8hxVysfwarDaz8EvPjnP/AmZhtCwS4FkrDTZkyLsqKYYuLN+CgXOuSye7jGD
         qZ/3q/oFzJ63pGGbX4wUmMfAWw5jpnYu+mp6qGr+Okxht3JnHvUVJm0B19V/b9DEuEpE
         irm7knBNxyFiofLbRMZ5TA5Ik4KmyhhuV+8KsMe3vXkZ9xYQLL0ZF6qNzksJLpbTaMIw
         HBoLdnIx30v4z2UH5fuyXGkQ+NVJngs27ULw9FMqnnJK/siEdTv9fqc/imSjPzTcYFnl
         Cziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744419259; x=1745024059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0Jdvg9bhsj2TlLlgKK4kFPCwh8w3DW34G5/8k1fXRo=;
        b=bJ7KgJMlU9Ehgf948f3V50lBv74D69pyaHeJFY3fKcE5nsgGP6KIiWdN8L3FiS6Oxc
         s7/xbXcc+cH3AE+O//Xjl2LcQQac0Te+YZ6wETOVWSE7jK8aVbUo7QpKDkCYU1IA3e0I
         QYLoRJPcHuyVMQMC2fxA7rYoJdk/+gRhgLfapV9is4uRu6d+rKvajlDTZrKFIUehscwm
         N39YiqgOkviTkDFhJPxTRHvso8qs/04GHWdPRUsDw6faK1cuaTsa31hAfCZGPPjsCM7V
         pmqY/KBEkN5dgBi7YtrSwu4YZIYBCJ061beaT8CyR+2ehxO/EoPuiCY73osK36Bc7sYz
         9Vmg==
X-Forwarded-Encrypted: i=1; AJvYcCWIvM2e7i5SHUN2YcTujUJKSPHIiwTkiIkTS8QoRMStljyzB+3eFZdOpyxw4r/NZVeBKkeACKwSHA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/XSN71g+FMyapmRb5dLeP9sqKe3pu7ZjPM/JggwfH/9o/V4/I
	+uMTQoc0X+VjxYAl8poG1vB4bJ8pUEiGnjL8LngIALcbwStmLz/zrjJQX08X
X-Gm-Gg: ASbGncvswVRsHv9fWQkOlrytwCk9LmZrTdf3bEWEJTh33riajb/uXymbzahsO2IMlhw
	SQ29Sm/eW6ME97WaXNK++p8bR7Ud2WqfNk1ALpEO8uByhDGM1gcP9VOO87K0vavabREHdZ534Yu
	HC7PHLk20IRbsDmQQBkVUOV0wGNwSn1MtBBoncNHFmVYVx1cB2sbYIjF27rsTeB1StidIgo3BKK
	PJPSmiH7IVmXwrakJuRYNk9qBnIn5MEMDkvFwr88iudLXZd06+W/wCodZGd+5kIL1Cg6it7p8zM
	z0Xh1qhaiOGUn8RatGftp58if+HFM4MTALcXSh4kUyivoK6vSzcI1RVo5pb0P8WrZASZbj0TzQ0
	dNFpbp4FzgkxLlLjDSqd1fOQnd0Sn
X-Google-Smtp-Source: AGHT+IHe4ii2FtLn/r3QCdx0kXlhM2Ev3zMXUE8KcvJ3Z+FhF6+t+o0tbI8w0udyq3tq6NDzKeu+8g==
X-Received: by 2002:a05:6a00:1481:b0:736:6279:ca25 with SMTP id d2e1a72fcca58-73bd12a8333mr6935579b3a.24.1744419259191;
        Fri, 11 Apr 2025 17:54:19 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230dd17sm2303274b3a.129.2025.04.11.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 17:54:18 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	geert@linux-m68k.org,
	logang@deltatee.com,
	sbates@raithlin.com,
	dakr@kernel.org,
	dinguyen@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	arnd@arndb.de
Subject: [PATCH v2] rust: helpers: Remove volatile qualifier from io helpers
Date: Sat, 12 Apr 2025 09:53:41 +0900
Message-ID: <20250412005341.157150-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_175420_819309_D3CCE158 
X-CRM114-Status: UNSURE (   9.52  )
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

Remove the `volatile` qualifier used with __iomem in helper functions
in io.c. These helper functions are just wrappers around the
corresponding accessors so they are unnecessary.

This fixes the following UML build error with CONFIG_RUST enabled:

In file included from /home/fujita/git/linux-rust/rust/helpers/helpers.c:19:
/home/fujita/git/linux-rust/rust/helpers/io.c:12:10: error: passing 'volatile void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
   12 |         iounmap(addr);
      |                 ^~~~
/home/fujita/git/linux-rust/arch/um/include/asm/io.h:19:42: note: passing argument to parameter 'addr' here
   19 | static inline void iounmap(void __iomem *addr)
      |                                          ^
1 error generated.

Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2:
- remove all the volatile in io helpers instead of aligning UML's iounmap() with other
v1: https://lore.kernel.org/lkml/20250409061129.136788-1-fujita.tomonori@gmail.com/
---
 rust/helpers/io.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 4c2401ccd720..15ea187c5466 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -7,94 +7,94 @@ void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 	return ioremap(offset, size);
 }
 
-void rust_helper_iounmap(volatile void __iomem *addr)
+void rust_helper_iounmap(void __iomem *addr)
 {
 	iounmap(addr);
 }
 
-u8 rust_helper_readb(const volatile void __iomem *addr)
+u8 rust_helper_readb(const void __iomem *addr)
 {
 	return readb(addr);
 }
 
-u16 rust_helper_readw(const volatile void __iomem *addr)
+u16 rust_helper_readw(const void __iomem *addr)
 {
 	return readw(addr);
 }
 
-u32 rust_helper_readl(const volatile void __iomem *addr)
+u32 rust_helper_readl(const void __iomem *addr)
 {
 	return readl(addr);
 }
 
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq(const volatile void __iomem *addr)
+u64 rust_helper_readq(const void __iomem *addr)
 {
 	return readq(addr);
 }
 #endif
 
-void rust_helper_writeb(u8 value, volatile void __iomem *addr)
+void rust_helper_writeb(u8 value, void __iomem *addr)
 {
 	writeb(value, addr);
 }
 
-void rust_helper_writew(u16 value, volatile void __iomem *addr)
+void rust_helper_writew(u16 value, void __iomem *addr)
 {
 	writew(value, addr);
 }
 
-void rust_helper_writel(u32 value, volatile void __iomem *addr)
+void rust_helper_writel(u32 value, void __iomem *addr)
 {
 	writel(value, addr);
 }
 
 #ifdef CONFIG_64BIT
-void rust_helper_writeq(u64 value, volatile void __iomem *addr)
+void rust_helper_writeq(u64 value, void __iomem *addr)
 {
 	writeq(value, addr);
 }
 #endif
 
-u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
+u8 rust_helper_readb_relaxed(const void __iomem *addr)
 {
 	return readb_relaxed(addr);
 }
 
-u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
+u16 rust_helper_readw_relaxed(const void __iomem *addr)
 {
 	return readw_relaxed(addr);
 }
 
-u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
+u32 rust_helper_readl_relaxed(const void __iomem *addr)
 {
 	return readl_relaxed(addr);
 }
 
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
+u64 rust_helper_readq_relaxed(const void __iomem *addr)
 {
 	return readq_relaxed(addr);
 }
 #endif
 
-void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
+void rust_helper_writeb_relaxed(u8 value, void __iomem *addr)
 {
 	writeb_relaxed(value, addr);
 }
 
-void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
+void rust_helper_writew_relaxed(u16 value, void __iomem *addr)
 {
 	writew_relaxed(value, addr);
 }
 
-void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
+void rust_helper_writel_relaxed(u32 value, void __iomem *addr)
 {
 	writel_relaxed(value, addr);
 }
 
 #ifdef CONFIG_64BIT
-void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
+void rust_helper_writeq_relaxed(u64 value, void __iomem *addr)
 {
 	writeq_relaxed(value, addr);
 }

base-commit: c59026c0570a2a97ce2e7d5ae5e9c48fc841542b
-- 
2.43.0


