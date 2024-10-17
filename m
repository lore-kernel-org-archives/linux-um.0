Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A15CD3C533
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fr7LkEYEQ2i7ItvFzGynv5JHdOaDwJd+YsSvx5gsy4M=; b=x5nBZIYyhht8RSLFMnI6CJwc+1
	Uh0LGnJhtRq1RZkNoUy9x5gsLOsT8VlTsdmUMCLqjIo3mNlxZ1IaLgICl7Ibns5HeJziSb1gRz+Hd
	TFHYX46PbdxPLdo/60/kcSdhlqB2S/CQWQTbI49R2gPpLfYJiXbP+CuYjS0SUPtjGy61BIr6RscUI
	EmukSAQT+JYCFOGZo4nlEew3/z+c3YuWSizYrb9udU4QNl4NB3yEF1FH5RuOokFikmQohPdKWrG56
	EMpmM9Poi3xdT76ilZrr4hLelHAxmyk++IT8Flv3pQ/0JDV6ME3hFqTyJq+JeTjgx8etWzCw0+ln4
	6GnPy4nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ZdR-0000000GOsm-3C9N;
	Thu, 17 Oct 2024 23:10:25 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ZdP-0000000GOsK-0SdT
	for linux-um@lists.infradead.org;
	Thu, 17 Oct 2024 23:10:24 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-e1159159528so3840198276.1
        for <linux-um@lists.infradead.org>; Thu, 17 Oct 2024 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729206621; x=1729811421; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fr7LkEYEQ2i7ItvFzGynv5JHdOaDwJd+YsSvx5gsy4M=;
        b=skCDSgj3RcUMcYp8KVH3o6SJyK1dpAiUwhCRw3YFWkvGPnbjAqcTO8sm0uOqmL43WU
         pUKqD1bJWaMycyItIujfugY3YerscUT6Sz1kMNb/tVUwIwQrIVLsVLWt7UYjsdo8vmkP
         6VkXQcI9RLCQ59JXBgiw+4hMbMOexpXBS470ESgzDmAa4A0/WqbHMTXh5pkvugerczt/
         juaB3s+ONCHmRuYtC2WIYkTgKAgDJCaMml9svyzNtU7xctHOfM/XyYwXacqRWI0WuBG/
         oAAk7GPpWXluJa3lWbnwETIoi9cA3x7i995VOxp2AKWgQ1NLzsFTGGiqIJVkwf0LQQrU
         anlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729206621; x=1729811421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fr7LkEYEQ2i7ItvFzGynv5JHdOaDwJd+YsSvx5gsy4M=;
        b=rOGn5xE4Z71/Ii0zsADJFkH2IP1XzGImPBGaVdEomWIrPbikLBxp6QHXzGn5C72ZVY
         8qLW86EexNhySFdwRgaJMA93AxY3mx4PurS+xr2wiPYRSJQeh7JDkc15W/lYMq3/5Jwh
         s8UadO/uQkin9FFzeEjcfd70SNrGOWPc+gkys7IG0uOj4Tsq6FhBZRwnJ7wXobxdk/uA
         tyBQ7taif9tdWLTHzhlp/g1gu/swiiLQt7rcAqJT4988qlHgs866TS1YPuF7KOgAfXxi
         VY9lkV5PICGPu3ZhjM9SOUGHUyEyMDvE1kOfi7wgSaJb2hhSQeq/c8fnB+BMWgR3LT13
         SctQ==
X-Gm-Message-State: AOJu0Yx7tv8L5nsbnwXZ6wmHMaGDRDC5wlAa8BQA0UfL8i67EOJwS3el
	mc6kYUq/JttEKE4Ct3pe9tVj10paQAJHfi4rUAh3g09GcHCDi3e5EdH41hVxyjKwfY3Igc6cYWK
	Ict98nY3RZw==
X-Google-Smtp-Source: AGHT+IENKH1N57vAuzezME1AKL8ZcgxjFf76kHwETDmIM/ia9x3pCbTLwMe9I3IJxACLuXxxmv0ADtZTtlT+/Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a5b:648:0:b0:e24:c330:f4cc with SMTP id
 3f1490d57ef6-e2b9d04de9bmr11384276.6.1729206620705; Thu, 17 Oct 2024 16:10:20
 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:10:08 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017231007.1500497-2-davidgow@google.com>
Subject: [PATCH] um: Fix misaligned stack in stub_exe
From: David Gow <davidgow@google.com>
To: Benjamin Berg <benjamin.berg@intel.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_161023_176480_81E16A57 
X-CRM114-Status: GOOD (  13.18  )
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

Don't generate this prologue for __start by using
__attribute__((naked)), which resolves the issue.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: David Gow <davidgow@google.com>
---

See the discussion here:
https://lore.kernel.org/linux-um/c7c5228e9de1e79dc88b304e28d25f5ffd7e36dd.camel@sipsolutions.net/T/#m90c1c5b6c34ebaaa043b402e97009c5825fd158a

---
 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 04f75c577f1a..722ce6267476 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -79,7 +79,7 @@ noinline static void real_init(void)
 	__builtin_unreachable();
 }
 
-void _start(void)
+__attribute__((naked)) void _start(void)
 {
 	char *alloc;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


