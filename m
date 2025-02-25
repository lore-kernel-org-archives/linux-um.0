Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7851FC021B8
	for <linux-um@archiver.kernel.org>; Tue, 25 Feb 2025 03:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=; b=BvAPOszOGdN14vqVjqFeHbhqhN
	PdAQlyjJjTBuLBzX6tnZNd5/h5np683T6+8Im+kwPp6GoKgzyGGGlNLwFQ1e58MU556tyFdaJ2ljd
	JLecOqukGkhJSmc9b9zaBAbt2XtjDMuzSRqo+7yOlJpQfsoAVJ5ABr4hYzuV2OaNhPs3CBRmCtuSw
	Q0MBCtVij06HN+3QZ4IY/gn+CfYw6OcUlWRQPanQSVsq9XK7gD84XroDOjMOvnG0n/4s2dPUaZ/Ng
	huPPVTJv7YXQA1zl+Lhg3OrNM0APmGyM5Sck6aRK+p1+DYoBlFkh07isEALwCqwbAPyVubG5yRZLX
	vcE4S/Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmltq-0000000FtMb-2bRR;
	Tue, 25 Feb 2025 03:46:26 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmlto-0000000FtL4-06Wu
	for linux-um@lists.infradead.org;
	Tue, 25 Feb 2025 03:46:25 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-220d398bea9so81286075ad.3
        for <linux-um@lists.infradead.org>; Mon, 24 Feb 2025 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455179; x=1741059979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=ib4kereh7XZSWkn56GvXSgdzBH5otbsgbe5YzVDNUamW6GUNQUl98D4eoOfXlaQ1vU
         kF4N80812ChJ1miSLnmDFZkYbK+px6fFEJmUYHkPn+ZjeI3AQ0wr4PM6mxM30cOXWMNA
         ZvDUJRq0jtMMahaAX+xuJeQylnq5Fdcim4/cf9SNfyy9eI297uJCtsYwtlZKU0C9RFBK
         DCp8ieSe3OceFArfDWCLtu9FefES3BCRF5oIrF2FL2cT1lZRGpavT7pWa8geWw2LeB2A
         voGNmZ9jJ1ZCANmylwRxVG1Ma4vnm861t56SyY4UssB9AcBS6/H8MWWzUdMlmcVCA79L
         fOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455179; x=1741059979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=heEDL9VTns8A6juOvACuQOV7QIZyiyKwN5/SZhIwH0wN2LcJsBPOb1L3/wcg4ho3S6
         BdT36b+BCmMXLEikxvzucFs1pCsYPBU0h4C4VzWGtPZPq+ASoj/7CZ+rOzL5EcyaG4oS
         mebEQdPzWJkXvFInwuqR10X2ieGy42TXsDbZwIL6ApgP0JiF0mXTbvGewmWGlqJJr4T0
         orew2pItd+9IOrWinyGbTLLKDSuxP0OaSXpX0hgLLRurItKrPGDsTMPvDUwKdbOD2kKp
         PFxs2cqme1Bn3I0klGJ6FH7NEDLksWolLog54w4p8wE5mREdyTVrlCqa8TdrW3/q2evd
         poRw==
X-Forwarded-Encrypted: i=1; AJvYcCXoFzcXEv0QfUD7s3FYtcUgFqPk583Aml6ZtbAiR2mmgjb+g/LvHHURiUB3ejbedPYCilMlIgmAMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXZLGvHtIvLCNIoNT6uDgkTRFiYrS12GEfsJhDeWExGmjlUYTV
	/Pwe99hY0zSusQ5TvMcKBzv37ghHUB198JM5wcKfdi56zCu7v9m09Typl84aOyE=
X-Gm-Gg: ASbGncstST2Xv9X8AJFykBTEc5S60lbYwulO5070FdquOXG7duLE8LdzQ6WT+Ya1GbV
	u381q+lk+5jp9EqgSK2pItKQkW5kmBAlHk5hlIgi6ffRKRjQo27QNASV/lkrM0cHyfpikgr+qKM
	4Bg/0TtQXpzr/R1y+rS6jZlt/lEgup5X1FCorKzEWM3Asr15lkI71C4KMB8Kq6EgiP8n+Ndb3Gr
	kxm8z1awZAR1eqIDATpfAcgXbbY8NvSiA+BFnk1hEiWV48rbEKo92lAuZlnlZB/1RlAkRvFAZmI
	GkI4rTmb4DLTbUrMaGBV1AmI8dYgExw+mZ3YKkZhEx8UEoiuBGeRsLwp4EjhXSCquw==
X-Google-Smtp-Source: AGHT+IGCQV+aaAngRw7XrsDoRTV1d2A5MeKYpMO11TDMI4tHHu1SHT60kqvv/nxGByOS3x+4jf7H6Q==
X-Received: by 2002:a17:902:e744:b0:21f:89e5:2715 with SMTP id d9443c01a7336-221a0edd8cbmr248196785ad.19.1740455178926;
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/6] remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:50 +0800
Message-Id: <cover.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_194624_240179_50FB4818 
X-CRM114-Status: GOOD (  10.27  )
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

Changes in v2:
 - add [PATCH v2 2/6] (Peter Zijlstra)
 - remove [PATCH 4/5] and add [PATCH v2 5/6]
 - rebase onto the next-20250224

Hi all,

As suggested by Peter Zijlstra below [1], this series aims to remove
tlb_remove_page_ptdesc().

: Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
: there should not be a page-table anywhere near here *ever*.
:
: Yes, some architectures use tlb_remove_page() for page-tables too, but
: that is more or less an implementation detail that can be fixed.

After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
to remove the page table pages. In the future, once all architectures using
tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
may be possible to use only tlb_remove_ptdesc().

This series is based on next-20250224.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/linux-mm/20250103111457.GC22934@noisy.programming.kicks-ass.net/

Qi Zheng (6):
  mm: pgtable: make generic tlb_remove_table() use struct ptdesc
  mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct
    ptdesc *
  mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
  riscv: pgtable: unconditionally use tlb_remove_ptdesc()
  x86: pgtable: convert to use tlb_remove_ptdesc()
  mm: pgtable: remove tlb_remove_page_ptdesc()

 arch/csky/include/asm/pgalloc.h      |  3 +--
 arch/hexagon/include/asm/pgalloc.h   |  3 +--
 arch/loongarch/include/asm/pgalloc.h |  3 +--
 arch/m68k/include/asm/sun3_pgalloc.h |  3 +--
 arch/mips/include/asm/pgalloc.h      |  3 +--
 arch/nios2/include/asm/pgalloc.h     |  9 ++++-----
 arch/openrisc/include/asm/pgalloc.h  |  3 +--
 arch/riscv/include/asm/pgalloc.h     | 26 ++++----------------------
 arch/sh/include/asm/pgalloc.h        |  3 +--
 arch/um/include/asm/pgalloc.h        |  9 +++------
 arch/x86/mm/pgtable.c                |  8 ++++----
 include/asm-generic/tlb.h            | 14 ++++----------
 12 files changed, 26 insertions(+), 61 deletions(-)

-- 
2.20.1


