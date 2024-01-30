Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE0C47DA9
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4qfvAxKYQwmas7ZTwKJIX5GnmiEr5J1LW/P09XlO4Hw=; b=pBYj5HwGyk0IrhVTGXZyzYOydt
	hsNFZgmsCiK6T3d0gD/4KE4Il2g+x8ZPI7YTFA14H/95T29fVNxwv0RAU0WL0LKZO4j5VMws+Gsgd
	bhE3cNS1895IY9Lf1spwgTBiBSJOLB31iO7QSpD4fnG5/k4NrklV6ZEelsXR+FAnZrzI0dU6qp80D
	DVTWhvZo6x4hW5ELNA7acyQwSx77g//DheBWwkyUtA5LU73RYPh1Y2vQDv5Bz0dInpMrpHp0R2mTP
	f87JTwfpSDMaXbXp8LdhH4hHHLew6xOWL+D5TJTYd5CcI31gmEdTxIcbpzKqHtgFesT7JT4umtyyq
	U6Y8lD+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFi-0000000EjYt-3YUq;
	Tue, 30 Jan 2024 00:45:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFV-0000000EjO7-3atj;
	Tue, 30 Jan 2024 00:45:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 21D53CE16B0;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15EFC43399;
	Tue, 30 Jan 2024 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575511;
	bh=VXgzDqWTdPwPLTS+PDtQWtuCy7mpsGpCkHXI8WBQloU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXXuBRXIKUnxuty7JtrN6gOE8EGXiTS/vVocrxqVOHD9u8eXJPZNAcWujnPKBxo1e
	 VxixGTBUgU4e8M27QVG7vbXDPLdWyZaI2WBJ0ie6g+nRygM6aoSBqy9s3cPhVrF80A
	 8e+ipwBOhmcCAq5w1f5FrzEifL/zkRxhhz1IOxIVxIqv/LbCD5pKRoRECjmsxnJtXD
	 sEpg7dYiG5yiHGRPRji5Q1tD2vIC8GqNjBHLc+xPsuJe4rNQHxIBu+qlp+KZuRPmx8
	 /9ZHH+fgKf7RppPgtpnyzdafGQ5MHgepOcTqIXjk+DAG6R0tsKb3gAD8EnkA9cxhuV
	 v0+sc6RClMpTA==
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
Subject: [PATCH v2 1/7] arm64: Unconditionally call unflatten_device_tree()
Date: Mon, 29 Jan 2024 16:45:00 -0800
Message-ID: <20240130004508.1700335-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_164514_127513_1A14B8D3 
X-CRM114-Status: GOOD (  12.44  )
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
Override 'initial_boot_params' to NULL when ACPI is in use but the
bootloader has loaded a DTB so that we don't allow both ACPI and DT to
be used during boot. If there isn't a valid initial_boot_params dtb then
unflatten_device_tree() returns early so this is fine.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/kernel/setup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..ffb1942724ae 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	if (acpi_disabled)
-		unflatten_device_tree();
+	/* Don't use the FDT from boot if ACPI is in use */
+	if (!acpi_disabled)
+		initial_boot_params = NULL;
+
+	unflatten_device_tree();
 
 	bootmem_init();
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


