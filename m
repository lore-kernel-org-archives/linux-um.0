Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1CC761AF
	for <linux-um@archiver.kernel.org>; Sat, 18 Mar 2023 04:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=omP7brw9b5HT1CGzqxQQjT5SFziJ6V9Ar9ZV8HHM5ek=; b=mD1
	wnQjzxe+vH6DLIOdqdGcPZwSuhxGwj4Z34vm1dIi14TYYErnSfhMFdAx1sGy1tGH+ilIP/sk5Fp1M
	z6DvDR8yJHRaqQHUVpXu9DG9OgvhIizU58UxMwJVzlah/D1OI08W4ADdZONHY4s5fxJU2WQFJMyAJ
	ocp9dQDTVeRX9eA2CA2sJmoERZpQZuTsLOY5aExM1PnrOiTz87VjfIPkM6ox5xslsNy4S1+rgMO95
	OfGU62RbMjQD8NHnKb6IyDTHIgsiQhIpGRWVjZgUFDUzuXWq9XA7Dg8C6budC1nSAEVr3sgyVtZBW
	68ZxSbRVy5qwfG0iJmo8uoIwzIQTyyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdNzU-0044nW-2r;
	Sat, 18 Mar 2023 04:16:24 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdNzR-0044mk-1Y
	for linux-um@lists.infradead.org;
	Sat, 18 Mar 2023 04:16:23 +0000
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54352648c1eso65695627b3.9
        for <linux-um@lists.infradead.org>; Fri, 17 Mar 2023 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679112977;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39Fefym6R4RrQjQOXnUkj5Wbs7EvPing/MjHK7t/Lyw=;
        b=lSAzuBmFZ+h8hiSzVh0biFlm455SUKogAcvaf1DponXDVrVupq8TYodfl/wuKq3+lG
         StIer+QGQznxUabXcz2df43r3hGbTAZmZFmuhtEuptxU9lRGI2GQfhVMjBHn7E6oe9rY
         EIEg8HGk++eNcDMhd150EGX8kmfrSXpRDtZ1Jmj+5TpUC1UhlNjrE5Qm5qB076rcW5nX
         b0mnyKdlSuPrmiRCFOmpwbvvLCp+sq/Z0vpQkfDRC0evcIRZsN6hp5UqmpznRXafyYp7
         1YcVKN2gtFUK/BfZcoLNkgVX91sNHKGVoiuKcaydIFpibjnyQfWUE+qS+w6SRTh1CNuN
         gAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679112977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39Fefym6R4RrQjQOXnUkj5Wbs7EvPing/MjHK7t/Lyw=;
        b=MnqjuhQuDOA5px7AYq3OAqntzzYFIJHbrj3YG5Rsbtd8/w7yD1ZZqTCkohqvwKMPmA
         xNeGgDTbGiyWY1/1lI+/JhhOYx8uL41fncUxPnpFp7xU7XsWKhkx25PqoXhUd3mA1wT9
         rp0X5K4KmgxeV3fBYJhZKPXqSlMZ5QXE78COtLHmY+8wddCa4ZkHV1sHN1HI/xHW+SS2
         OIU/Z/LMpRaFAc3LENusewYwSMlyDkbgc1yEBdJZd2LAIYhWB3Arukqucq3TRdlOTdBW
         sihdwoM9UtpiRfYBvtgdQ+Ie4QRWZFtYCoy8Dl6vqnQzM9NQxn59ADJTZVZy16tL1It0
         FYHw==
X-Gm-Message-State: AO0yUKWYRP1l+5y+ah6pZE1PdojfsjsCf2FQLTaAj4ZAop9LkTau/WSk
	gY8QcpbLp7CBfR4Hf1G7USR5tUSzoLHT9A==
X-Google-Smtp-Source: AK7set8R2hY7ySptFbksr8tOnpVYxuTWiaaKxkqJCvC0czQRuIKj/2zJ7wSxtFdQ8Yte+Avdjdb73Hxrct/0kw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:af4d:0:b0:544:b7ff:b0df with SMTP id
 x13-20020a81af4d000000b00544b7ffb0dfmr3997390ywj.2.1679112977179; Fri, 17 Mar
 2023 21:16:17 -0700 (PDT)
Date: Sat, 18 Mar 2023 12:15:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230318041555.4192172-1-davidgow@google.com>
Subject: [PATCH] arch:um: Only disable SSE on clang to work around old GCC bugs
From: David Gow <davidgow@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, SeongJae Park <sj@kernel.org>
Cc: David Gow <davidgow@google.com>, linux-um@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_211621_541651_55F50EDB 
X-CRM114-Status: UNSURE (   8.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

As part of the Rust support for UML, we disable SSE (and similar flags)
to match the normal x86 builds. This both makes sense (we ideally want a
similar configuration to x86), and works around a crash bug with SSE
generation under Rust with LLVM.

However, this breaks compiling stdlib.h under gcc < 11, as the x86_64
ABI requires floating-point return values be stored in an SSE register.
gcc 11 fixes this by only doing register allocation when a function is
actually used, and since we never use atof(), it shouldn't be a problem:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652

Nevertheless, only disable SSE on clang setups, as that's a simple way
of working around everyone's bugs.

Fixes: 884981867947 ("rust: arch/um: Disable FP/SIMD instruction to match x86")
Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Link: https://lore.kernel.org/linux-um/6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com/
Tested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Tested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/x86/Makefile.um | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index b70559b821df..2106a2bd152b 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -3,9 +3,14 @@ core-y += arch/x86/crypto/
 
 #
 # Disable SSE and other FP/SIMD instructions to match normal x86
+# This is required to work around issues in older LLVM versions, but breaks
+# GCC versions < 11. See:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
 #
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
+endif
 
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
-- 
2.40.0.rc1.284.g88254d51c5-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
