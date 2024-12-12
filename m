Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE9E77182
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=; b=l2zRe3GeKukw5KKExjZiE+Ia9N
	CLj6f7VMGftK7mi3RamkQc5LcW55HFxAbltYv65DtJrpy3DGdlqZSHXBqFnT1c9x+EKVqx5gTiWx4
	WQFP/0ifS9+wru11rPo0WtqFsGbxMC32h2W+g9BHwA4v5aIFS4/jVTVn5bTKtYM9SexP6hMqKIlHU
	aOrfs0p6Uj3tdQXmFXqCjCEvrgjnmfXwD+xuxfhPw6UaXjZt/xx5kI8MlaZ+96a0TBTciyeEZ6+dD
	sPmUWxIY34MWaYwHJ3Z35DMs9PMZnoyuydE5pRA+ceYUWyRcfphlf+NG760U5T4eRbCttG7OQ9r6T
	sKnlwQ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDd-000000001PF-1XYs;
	Thu, 12 Dec 2024 10:14:53 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgCy-000000001D3-43rX
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:14 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so353893b3a.3
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998452; x=1734603252; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=autGvvWLp8YM/jXjuH+KrIcJ9+LMcfBtUKtA7XzJqNVi6uox/0k69KvfmYQlB3ptbP
         rRob7PSEXD8RID65gh3FxI1C9k6Bexwv5hGX6wijjXnbo9lLidV1cktexvyhL80iaCOS
         gGLu1L8YpInzI165Wlr7DTcXh+WxJDeOdS2WtBwBDcYIdfmTo0tMXSUU+BwgrB9ZNBzr
         UZOqCOrGTYVAi9u9F5J3cRdw+cQ4mmuACPV+Y6apTri3Hd19+v9Cy8f/wpw9eoWCXV2z
         j4DynuhGk4Y8XYM7Tm4yKxOWUsxC0ypirwf+gnTXPmbjr6f/WA/cF81Y5V0RfEznJ2J5
         jCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998452; x=1734603252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=ioWIW/STZbTGUkVOCcqafW4m2Mqd4sW8YTPdhrVO/9QpMDNMaPsKeHBEOv3T7VNJqv
         rN0FCjKYDXy8hSPQxDjtACLLemeyZb23OuSs79PqWAuxJvCHRL+8X3Br/jVBneRXMWkJ
         7TgUBGs5LacfZHvCYahxi7WSN8lgwz2R0J1aJxOfaqFzbZ8EZbL5Piw0wnmJFZpgTTHD
         rw5AMA/qd00p64zE626UHy17VxTdrZ691FI0EURYyFNQGeiJmpQlsWB3Prf5bGVyW6yL
         gUpPS7kz2RcH9jqUkgQBs8IHRrtcUq3n+mr6hZJ/e0bJKG+IZzCYMr/c1gs8vnMsP6TB
         jH3g==
X-Gm-Message-State: AOJu0YzABnZ5jjMp92HoyP8H2BXBThyXKE5oXmaW4FqRTxVEm9NcMv4j
	Dki0sSPO17HJgDepbKKYdrILmv1NEIww+UdocPkPWGq4kjaqrTz4
X-Gm-Gg: ASbGncv6iKXKMQBnzhYl1VVR8Ou3H6YMCVScqoWmh8+zgHTp1z5WHS6dStBqyrs4OWD
	dAFcYohQV2AKFeEAaRW5IDARhvXIHcYU3/fA/9JdGdGRQNoWMGXBdVImv0hFbmuYQn2eBpbONhP
	Exe34zk5Ygk9phse/Yxvs1P97+fnQICgKc5/eMyTTl8dKi++RUICDtJ8qHj1Vs4kqMAc6fVfv9Z
	3e12IgtVkA87euvxjtVhX/s3U7fnzZqtK6Y6WvWlt4XgfURDk9swnEE6EbhDvh1SXcwNo4TP4Zj
	RWI28YR4qRJhas4m8AJ1XIhx/EE=
X-Google-Smtp-Source: AGHT+IG6PTd64CCJvSHMCzYn4d6BhC6R8rmrzsF/BpnG2ty1u1/3hKa1N8Urvwztwdj0gtpl/kXweA==
X-Received: by 2002:a05:6a00:21ce:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-728fa9b7442mr3757185b3a.3.1733998451892;
        Thu, 12 Dec 2024 02:14:11 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eb9b6efdsm7118601b3a.34.2024.12.12.02.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:11 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C0547DDEEBE; Thu, 12 Dec 2024 19:14:09 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 01/13] x86/um: clean up elf specific definitions
Date: Thu, 12 Dec 2024 19:12:08 +0900
Message-ID: <19a81a341d5e43499307b170c6cc6f3ee0ff9299.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021413_004776_D0D698EA 
X-CRM114-Status: UNSURE (   9.68  )
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

The file arch/x86/um/asm/module.h is equivalent to the definition of
asm-generic.  Thus this commit cleans up to use it.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/Kbuild |  1 +
 arch/x86/um/asm/module.h   | 24 ------------------------
 2 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 arch/x86/um/asm/module.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 428f2c5158c2..04ab3b653a48 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
+generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
deleted file mode 100644
index a3b061d66082..000000000000
--- a/arch/x86/um/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#ifdef CONFIG_X86_32
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#else
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-#endif
-
-#endif
-- 
2.43.0


