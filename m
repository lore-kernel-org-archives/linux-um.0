Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC45C36002
	for <linux-um@archiver.kernel.org>; Wed,  9 Apr 2025 06:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M5d1vrdeOAvtBGH1S7JlUf/9cb5pC5XVB1481DKZGqQ=; b=HJUIU3ljlMhxEeYQk9KzopIoCO
	ILsXhgyYrwOmRpOQs4xsHlkroU6gZpTWBn/Y/LKZZxD741V1Lb0G2Av9WIOCDlDHyiuptt6u2osr4
	vdPQGt+0IPjbdT4BPvtfx2wuuzRym+TnI/Dcqcn/6lO+tW8jmPrw7AseJFnThfzqjLknAYvkgTu6W
	bEwWUapdQ+wR9kLYSm3Hg/PzRryD7+D9P/DD9Ke/yQ+0CEpSVAFDw4PonTqa36UNeGwCmtGBL2q4+
	dao0OiUtHWn3ooIJ8EEGhqSVTX2Z6vgSTOc1NujUR/2T0oPiTzugqS+uWHMIak0PR88HezKPP9oTI
	sICS+08A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Ofk-00000006FE7-35cV;
	Wed, 09 Apr 2025 06:12:28 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Ofi-00000006FDm-0MgU
	for linux-um@lists.infradead.org;
	Wed, 09 Apr 2025 06:12:27 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-af59c920d32so4514178a12.0
        for <linux-um@lists.infradead.org>; Tue, 08 Apr 2025 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744179145; x=1744783945; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5d1vrdeOAvtBGH1S7JlUf/9cb5pC5XVB1481DKZGqQ=;
        b=lWcUiVooL7RJmVIxdHYmBYHZ3eIilkMhvqncaR4MV4Va7USF+UtWyGE6mgwnToj3FQ
         VABPFGFZ2sfmpinkdlJ812REnCUaiEApoH1+cBPd71IVZ4M8CUmBht965cuDGpriQDNq
         4qbbF50FrzLlu2GVBL7ZE96aBo1AxQU1j+Ox+AbENgyAeH0ng4loeXvxWBcsNpQWgtEb
         9rARfVxVtdVsRXtN/hKit/+xjwpDSbsuIn3YmVNuAnI29PKB0BFzbfcD5H28cf5MvMRK
         ST1j4tcAxUbBIK8pQkm4n+z2iGOJv7bBxWa4nOt2BBF/GCiKpmOPv5wqjesxUwQIWRc9
         +SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179145; x=1744783945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5d1vrdeOAvtBGH1S7JlUf/9cb5pC5XVB1481DKZGqQ=;
        b=EKL09/lppOO52EXqlyfTnw48YP9hmdHw9E1kSUg4WPUP68npX1EVcUUOeAhnejOu4V
         nMYnLdQfqmti3v7S9yYYeLcydAlelAa8ZHLMRs9t6hPruPT1iicNcpL3pbqlniq1W6Ih
         SQJU8LOHMgL2m/h3sAmZM0CsIiXBS+/f5PRsZZftTqQDZksX2nPzD030aEGsIYBPLO0b
         57K9Rg0LFB+eeMtskPNTg9JDq6iXPSVY37pQPj++Z738MxttQLUaTyThPp0rTIemw2CS
         XSaGr6V6GAjOu2EfnCRJ6dizOSc47PP0I7BYCdjfUgeuW9Kh0uM2TZm6ObGRzq7v5uL+
         euww==
X-Forwarded-Encrypted: i=1; AJvYcCUkz0xcVIdC8gdURPAAYyKCSFkWVh85bA/ODeFk2TQ8O0sGRU/qpe3OLquD0a5fXO/uvAQCxX+M/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwB9B5DgkGVqCDgDGQgOE6ijYuu8RPUDrmkjsfdLIlY0tza8AUR
	hC1R7+Qn9XAGM0La6QuLV0sgAJnbbU37LtEX8PXMAizXWyE05SmW
X-Gm-Gg: ASbGnctx+S/dCBJCy1fgUdSHWsXYZiA1+wOqum9tyDkZTwRlDDfUzY83y3Sg4fRLzkX
	Wxwh9ilEJ+wjVPYyQFKxYQEExj6HWCzgHjMWUl9JC+mnhk4ym/pTSNULAp1hr30RTFVIrhPKtBE
	ZUcRZldXhbtk8OULDhS3EQdzq6cL25Jfjm17+0PhqVjNjiZz6LWXBjHlMFfQ4g93kkxpXYQ7/2Y
	5lLVo+cdTIH6/Zr7zpjRUD8xFh97c8E3ns7OY7iRwHPdoSplZZMhaG4/23Hj/e3P6X0pgeAvJSU
	Y6UdF3LYxVEEKbBCkh7avV6tiUz6O57CXaDgEErqGPJHHV0B0pfkhivVqY72q6c9fnPzXRVUXgf
	IdsTcfouN4OrlvSXucQ==
X-Google-Smtp-Source: AGHT+IFGiqW2qskrqgDwvIQltpBvtl1olae4VZELvymcrigFhnNPIoe4mErrMW378w8tWc44LV65pQ==
X-Received: by 2002:a17:90b:2811:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-306dba7dfe3mr3160703a91.0.1744179144759;
        Tue, 08 Apr 2025 23:12:24 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a767sm594492a91.6.2025.04.08.23.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 23:12:24 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v1] um: fix incompatible argument type in iounmap()
Date: Wed,  9 Apr 2025 15:11:29 +0900
Message-ID: <20250409061129.136788-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_231226_122484_A8839124 
X-CRM114-Status: GOOD (  11.95  )
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

Align iounmap() signature with other architectures.

This fixes the following build error on CONFIG_RUST enabled:

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
 arch/um/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 9ea42cc746d9..ce0e8cf4834d 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -16,7 +16,7 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 
 #ifndef iounmap
 #define iounmap iounmap
-static inline void iounmap(void __iomem *addr)
+static inline void iounmap(volatile void __iomem *addr)
 {
 }
 #endif /* iounmap */

base-commit: c59026c0570a2a97ce2e7d5ae5e9c48fc841542b
-- 
2.43.0


