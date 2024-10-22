Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F60D1CDD2
	for <linux-um@archiver.kernel.org>; Tue, 22 Oct 2024 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4evqWcCKtntX1Xzr/IbjfUtruIcLXYCqTru+K/PxlXk=; b=cLxSsuoXOb42ba2poj6p8PmYV7
	j7UDLOi8w+3vOiQA7WxuKbmmNDoShiwCN5pLYAzf2FDGD6yc9v3w7RTaDGatO2tW5/JZnBBLk8NEC
	AG+FoMyJV8ZyHQd1wa5SykbgxoV76xTMExQoZC8DGtRxkHAAHWJ0EVeyDLgsO0dQ2AiCnC/ZbT5f6
	lV2xx1NUdK8M5MovFAxNnLAB/tddC9mFcgYAo+uNlDALG4y3X1GfRj2WWGD7+vUmXTwkue+ph+PdZ
	ciWHjDLUmYqXGlEs5X27JRC1sdHkRT9WDnuQQkIoM+qlQHMJxJDgHe/AX0xvRodLxo1aY8Xwt9j3E
	4WwDelyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Bwh-0000000AVIV-3b6a;
	Tue, 22 Oct 2024 10:16:59 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3BqV-0000000ATzC-0cZ3
	for linux-um@lists.infradead.org;
	Tue, 22 Oct 2024 10:10:37 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-e293150c2c6so11293269276.1
        for <linux-um@lists.infradead.org>; Tue, 22 Oct 2024 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729591833; x=1730196633; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4evqWcCKtntX1Xzr/IbjfUtruIcLXYCqTru+K/PxlXk=;
        b=3uV6/vVY+XiiK827oJsyYF8Tm2ogLrwtjBimo+BOJH7NHNA83YG8QflWZ6u/0c6rhz
         NKMHf8KzktaA4jITq/bh5AfOdIhmhKgRnkhm92uujZZBXwYlAM/sJzSD43FQDf+kZgIJ
         TbZCTCZwkMt8/oQHVafbJj8HgVppAsehryB3/KJ4g8zVyKKcvnxbfzguChLi4lX59elF
         LoenSuLauWNFiaPF5oFf9LMwWnPvdyrRXqMSbtiZneyaX7G/Es5Sd4Ews8ETnna7dLXw
         weTG1xhnPSVK/r1WHGvAR1UNMiQjQzYbpriAeMVLe/RtVPey4EG6xh5cMxZC8pr8BxWV
         6I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591833; x=1730196633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4evqWcCKtntX1Xzr/IbjfUtruIcLXYCqTru+K/PxlXk=;
        b=chK8ejUMjy8haW5fupzt+1za8oh26YtySxbYgX0KJwF4kFs6vG2W3jlgSxfxVIUmS4
         tmJGZ166eMseNMUPw7v99ObquUp2dzpu42rSq+Wkr8Szt4739yMvVuh4cyfbBei9O/bv
         jKg61/DVdFaspAgg2jAcGw6otMjeiIrqZemuz7xZ3vbm2ccwEDjSkmowyXP/fbtLjr3N
         JUkbF4Ax1Af8ck4ReLuIJBDbYZf2GuPDFe/2oZqbVo9AU9a5bRd29qFm8FoUhy5iRHFG
         6XhhuEA0qlGQsTC1BCRJENFNBkJ8ZMZH8OqrjZJXjRO+2lEwzLZ6dP1tB/lUAGU81uiM
         VeEQ==
X-Gm-Message-State: AOJu0Yz3u8q5Q50VwLYFYg/18Bp40wSnkEcbqNQfLm11T7+HNry/RZCM
	g5nTZ202N3bRAMSD8ySPTSNq87hLud1c0ksuVoYu3lQIbTNaxohP8w1F9XvafxObwgEbLdih+Hd
	e7pJdfzabBA==
X-Google-Smtp-Source: AGHT+IFyN2RsLo9pg/6lwITR5zdqym1uZ8LIP79EcuE7xlsum0X4k0qeoG1BtnS4XQ1CrESKB9PJ3BQm+Ms0Jw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:e0d6:0:b0:e28:f302:3582 with SMTP id
 3f1490d57ef6-e2bb11b09e5mr8383276.2.1729591833214; Tue, 22 Oct 2024 03:10:33
 -0700 (PDT)
Date: Tue, 22 Oct 2024 18:10:17 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022101016.2565249-2-davidgow@google.com>
Subject: [PATCH v2] um: Fix misaligned stack in stub_exe
From: David Gow <davidgow@google.com>
To: Benjamin Berg <benjamin.berg@intel.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_031035_230136_4BAA4A0B 
X-CRM114-Status: GOOD (  14.76  )
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

The stub_exe could segfault when built with some compilers (e.g. gcc
13.2.0), as SSE instructions which relied on stack alignment could be
generated, but the stack was misaligned.

This seems to be due to the __start entry point being run with a 16-byte
aligned stack, but the x86_64 SYSV ABI wanting the stack to be so
aligned _before_ a function call (so it is misaligned when the function
is entered due to the return address being pushed). The function
prologue then realigns it. Because the entry point is never _called_,
and hence there is no return address, the prologue is therefore actually
misaligning it, and causing the generated movaps instructions to
SIGSEGV. This results in the following error:
start_userspace : expected SIGSTOP, got status = 139

Force the compiler to emit code to re-align the stack in real_init(), so
that the generated SSE code doesn't crash. This isn't necessarily the
_correct_ way of solving the problem, but it avoids the need to rewrite
__start in assembly for each architecture for now.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-um/20241017231007.1500497-2-davidgow@google.com/
- Use force_arg_align_pointer on real_init() instead of naked on
  __start, which works with clang.

 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 04f75c577f1a..50fded2384e6 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -6,7 +6,7 @@
 
 void _start(void);
 
-noinline static void real_init(void)
+noinline __attribute__((force_align_arg_pointer)) static void real_init(void)
 {
 	struct stub_init_data init_data;
 	unsigned long res;
-- 
2.47.0.105.g07ac214952-goog


