Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA45C19776
	for <linux-um@archiver.kernel.org>; Fri, 28 Feb 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LiR3Q3Hzx+LFjLqooUrXeDrXwUS05trGGD2104VPDY8=; b=Wv1nYsse543HBrfDA30pd43Wlx
	kPkjUQzg3cQwWXiO3PdrG0xKfI4Vug9cufHweLBX+3oDgzmL+atC8j1nKRblAuRyv+C5lJCqtuGOq
	wnpsyx4R3ZfH0FhzZqN7nhDT9Zt8j5kzYXuN/6Xf83jijla/FL4jHluOQjX0WHx/mqXlLwuld458R
	MMc4wgDwzKWv0b3sWdcZU8KezByFoxclP4wzplR4ID/+3317Bq+qIVSAXL/VpI/MA934s/+sjpaFD
	6aljkHxCMHZnzCx1kFfaEjyHOySWc+dPX/86+eMT9fLLBsfNJiHcEl0vojPUePvQNGISv7P/Je7yw
	uGQgPuVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwFO-0000000AHLc-3Nyp;
	Fri, 28 Feb 2025 09:01:30 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwFM-0000000AHKw-4BI4
	for linux-um@lists.infradead.org;
	Fri, 28 Feb 2025 09:01:30 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so3375753a12.0
        for <linux-um@lists.infradead.org>; Fri, 28 Feb 2025 01:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740733287; x=1741338087; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiR3Q3Hzx+LFjLqooUrXeDrXwUS05trGGD2104VPDY8=;
        b=lRC6uXT+iN4RnSU889iUBXS62vg2yRyU871m7zugrrw15HnodKGluMP1hj66pPx26v
         i3FRh9gdKva0ShkuhHtaK8zt88vbA/IPOh3MQnfEAuoLL4H9ypm7t5tJOkHZH52A4Mlo
         bWSYkGfmMBE5fMUq0wmqoaeOUavEbXLSP6ChVxZ8bS37pCuxVzPc0tk2NcglYDYhrLdi
         vB/1xXF/BpV7LWCI7LgggfLHxXdHBUAQ2pwD4rKAv0RI1yW3eU4hbcmZT9UFWMnczAYR
         7ufptQAogwmAW7G6IxI0icXtmpJeq2G8ODaldVLOwG0JZmk5B6/tuXMkYqv7XNw7yoBt
         6gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733287; x=1741338087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiR3Q3Hzx+LFjLqooUrXeDrXwUS05trGGD2104VPDY8=;
        b=E1RQpCM+a2iZC0Uv0Us9otNsWds0DD0MrJuPs1X6FkPKrv8Yon43i49uC8XHQ4FCeh
         iPQJ1P3z6DvsGE319LJeR0E0fsIQ6hsp6XSw9i/6we2Y2QyPqWcTJznrOGjP0K8galEi
         IfNnbSEDtDTR67EK0AIPp0D8HJ8vaJcn/1bVmX/aatsKGRGMsE1Od9omEx356LkLbSnD
         c+1yLruFg7gHCtfC7yxwBpznazyzR4vkQLdOAahoucXrU1svZJFmOC/ijQG+/TPHoEHk
         ZYkabizMpoRIu1RGBAHKHSry0l46mCiABLWz+5jVbmabO1uEJWcYGoG+i0Zpf81mdk1Q
         jnqw==
X-Forwarded-Encrypted: i=1; AJvYcCXX3HNWKipgS4BpYtkcph1XrWeNbKje7/h6wMLx//pczHLdesAkjSo5CHvcChKn4cb1Bxb1cl2/Nw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDMqiH6mcF1aIXqJg9yxPVfJNyePDxVPhSsiaO2qx0ylcUNZSV
	5iuRtlgzcSLFwv5EnrUSPjokS9B5PNSVcJk9imFQBbgh7VU+Z2c0sxVl0iwOsA0=
X-Gm-Gg: ASbGncsLuR6y47H0EzWqy6dO08c3X9p5rqQnS3zwRPHM+/1MWUodY3oD4g6r8M0NJv+
	HceNpIXisS0dglrh5OncFoNggdWvvl80E3vHm1Ikj8EQ0vPZ/8PFDxqu+jpLfbuEdzuwg9uzyTk
	YrdQzw09pczLoDuGWwt1xqPEnPuEz9by0blFVgvuFvFdasb17REETfCeOff3b7whHJH16Ayv8ba
	Ho71f8xd9wQUyjILLs8SYxsMV8y1vGWTwAjKA6rTqFOGeewa+DoZy9kgMb8S+kA9K+KBKZ73BWE
	3r3fXzLyStipqhBs/A==
X-Google-Smtp-Source: AGHT+IH7wl9bSRrHP5kWST85mxMZuYKEPvcz8cnXAvDNj4PvbvFgz3YSLxbx/1/EH0xeGLaoKUTfsw==
X-Received: by 2002:a17:907:2d90:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abf25fbb482mr252696366b.18.1740733285896;
        Fri, 28 Feb 2025 01:01:25 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd9f1sm261651366b.62.2025.02.28.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:01:25 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] um/locking: Remove semicolon from "lock" prefix
Date: Fri, 28 Feb 2025 10:00:08 +0100
Message-ID: <20250228090058.2499163-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_010129_032899_0F7A5C42 
X-CRM114-Status: GOOD (  12.76  )
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

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "lock" prefix, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "lock; insn" as two
separate instructions. Removing the semicolon makes asm length
calculations more accurate, consequently making scheduling and
inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving lock
prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:

  Error: expecting lockable instruction after `lock'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/um/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index 4da336965698..b51aefd6ec2b 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -12,9 +12,9 @@
  */
 #ifdef CONFIG_X86_32
 
-#define mb()	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
-#define rmb()	alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
-#define wmb()	alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
+#define mb()	alternative("lock addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
+#define rmb()	alternative("lock addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
+#define wmb()	alternative("lock addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 
 #else /* CONFIG_X86_32 */
 
-- 
2.48.1


