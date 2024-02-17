Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AACC48BF5
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6Ys8FPEhgXvqlylTOVJOo7KlGjQhGaUKR9xz0jyv0I=; b=jQUOShZpEkzp34lmQzkfL6RZAj
	arJtAWQ7ofZFZIv12wu8/8QCDgcfy2MtzxX+BuKyQfPb36OFiFLnSIqZei8AgJVgsXBfsij/dG6UU
	tbDNq1X4lnbbVHhdD9EzlgkL/3wjyDVp8B8eRa1RwmHHLlvvUHjnRyNe672tn7iA22PU1iFiHypCF
	waOXAXhpBbyyF6SCZeOdT/rBP1kTyYy84Fqv1Oc3xYIYckO6uhy7R7Z8+hc5qQDjiomiuuavhC2JZ
	nYVOrx+Z1RD4volAzh81AgUKbQvMOG+ADiMkXTuuCRzDIwB6NXD+5ykF+Ym3H23GLQRMQ06zs/86N
	qKfRwnJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99u-00000004LyP-0caa;
	Sat, 17 Feb 2024 01:06:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99X-00000004Lht-06Nt;
	Sat, 17 Feb 2024 01:06:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F430620F4;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68291C433B1;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131962;
	bh=1HWmL/t+ml480s8rBnTxQKeWVgi/0Mqu3CbJKyMEIU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLu/fetqM+cb3tFtOHS4DOL5HzdsL62p8HCA7st+6zWovNRgJDBAgQnu6PXC1+c9G
	 HFZmLUhjJAsUY3SYQrxRX0DJ51MCTu7WUqyLaRDBYT0p7U3hhqasKo3LofYMLnFUmS
	 wyRODHMZMXZEjB75NprcfvwHNV/GncU03JL5Uh+3ni6KVVnTXs0sqEPcJRHZZ5VUhZ
	 KDwZy/JMZPFcz3N3YG14+nEDcPwAloywz+fsCh01BgyNBj0GdXEtQLT9hc25xBrUQB
	 JooWdwLPYjQZABiqq2n0BCu5ZwpDE4wcww/s7bAxn5H8dLXJcIiin859FkSNqXFBMd
	 ex/bdl98FQEGg==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 5/7] arm64: Unconditionally call unflatten_device_tree()
Date: Fri, 16 Feb 2024 17:05:54 -0800
Message-ID: <20240217010557.2381548-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170603_192472_EB36F86F 
X-CRM114-Status: GOOD (  11.23  )
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

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a firmware provided or builtin DTB.
When ACPI is in use, unflatten_device_tree() ignores the
'initial_boot_params' pointer so the live DT on those systems won't be
whatever that's pointing to. Similarly, when kexec copies the DT data
the previous kernel to the new one on ACPI systems,
of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
one) and copy the 'initial_boot_params' data.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..0d210720d47d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	if (acpi_disabled)
-		unflatten_device_tree();
+	unflatten_device_tree();
 
 	bootmem_init();
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


