Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47134E77184
	for <linux-um@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7D68RzS3aDMea5rHMJVmyfJ9DYfvHvk9VNugqZY76I=; b=i7QzFeGGT7h92wOYVgyTBIhAI6
	D19JbQI7rg50MyjhmgLYL0NHluxL64k7gxULuHAlduQYmyEl3OUUHKkMcjbrp7+ufz8DEcjDukxSF
	vbj+/WbH7nubjGF2YF1KPIcWYSWwQz/y1sZjMpvacsoqtQhRSz/6tWFUzLYoDGSIh2VsM7B0ZkGZk
	Gb2GPzRXTUe+4SwnVMWsYscHrel3eBAFnWkVKQBe7yzo09lf9+M4c21ao/9PlEKldMaYCU0KgxXvc
	/ExrXgw0TyHHUPTnyMfbOjXFPMKafb+LW9ioAnFlFNY/j+SmfSsp+5XZxcPajVrc8MGWBezMjzznk
	8g22rjFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCn-0000000EkhM-09td;
	Tue, 17 Dec 2024 20:30:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCk-0000000Ekff-2mI4
	for linux-um@lists.infradead.org;
	Tue, 17 Dec 2024 20:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V7D68RzS3aDMea5rHMJVmyfJ9DYfvHvk9VNugqZY76I=;
	t=1734467404; x=1735677004; b=jO+xzm3ffpNe05Io26XWUFGeIDBOF+lg54asZnoqIkAAPCU
	0+egI34n/uE1xySJ/doln7yo9OYWiCjCHKi14mTnjF5NXAPoW/FHBw5Ltyjq1vK8Vns76eGhEnc34
	820XCcjrWxVN5q77920LtEeiKOCczRfmwCLG2bFa6UTff42zxUp4igessK0l8vWJ+BZUZTcufUGze
	WdF8Q2I9sPvjNCGKqII4uP+ZNISGHZCXKaxjeJSKbOegnIvRUqJ9AKXPJSRqqWvy0Kyes7aeR6vCr
	nIhAFgjv68/UJTwfJfofS08jpRAnxwHjJjppAin/v0bAXtzRqCU5YN1bYjc5rFcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCf-00000002NwX-1yDZ;
	Tue, 17 Dec 2024 21:30:01 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/3] vmlinux.lds.h: remove entry to place init_task onto init_stack
Date: Tue, 17 Dec 2024 21:27:43 +0100
Message-ID: <20241217202745.1402932-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217202745.1402932-1-benjamin@sipsolutions.net>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_123006_697992_81A49953 
X-CRM114-Status: UNSURE (   7.12  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Since commit 0eb5085c3874 ("arch: remove ARCH_TASK_STRUCT_ON_STACK")
there is no option that would allow placing task_struct on the stack.
Remove the unused linker script entry.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c749..8cd631a95084 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -404,7 +404,6 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
-	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
 	. = __start_init_stack + THREAD_SIZE;				\
 	__end_init_stack = .;
-- 
2.47.1


