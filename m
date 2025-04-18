Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D1C369C9
	for <linux-um@archiver.kernel.org>; Fri, 18 Apr 2025 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwc4mfYSXYiH4MmePOdLJBQ3MQuMPTvYksMJAz49SvQ=; b=V6Uj8LlT6eFuYeqfUiWYtu6BCR
	sRxr4yTwJiXxPwn8hy9GwMR4XFT8i69mNqjXPweiZ3Wz1iI+1qlUKAqTxmy8nD36PsyBPyIMWIHCH
	j9ZWTTLr0+Y/EK5FmyscYI2FV+sjpD8e4XRfU1245T/JOtNzGzJX9r1Msd37sajJSTVW+/sq6sF4d
	Zm9M0JNCCt8jvkwykg9yeb6nR+nF4t8/Tx+aFwz7++BpMidOFuowXmOsJHv0ZFt3nUaLlF5lQ6JNm
	mZtqAQCvJJCnzSzX8qrwxMdyn4vBzaisRSMVc9a3P+8sGJ+mHmbnOEPmU6a8o8ln3JZPas4tgv+Lh
	ndTR7pEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hOy-0000000Ffg8-04KU;
	Fri, 18 Apr 2025 08:48:48 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hBL-0000000FdSh-0DW1
	for linux-um@lists.infradead.org;
	Fri, 18 Apr 2025 08:34:44 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so2496343a12.1
        for <linux-um@lists.infradead.org>; Fri, 18 Apr 2025 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744965280; x=1745570080; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwc4mfYSXYiH4MmePOdLJBQ3MQuMPTvYksMJAz49SvQ=;
        b=TxKDAvdVNtPw+/JyUGl58LMgolRl5ZhggBHlbVf3y0sVwbHQ5iM084fAvCdXDgLMSs
         N0EBz3imtQbZYEnnHVirNwZgWnY2DjRKG3LS7/nUR+PfVsokj27brKNwOo+6XX01GGI2
         RiBW/wWm2hMpzI47HKwIvFbjEj6mzghPL0M60S6ut7MsIFbJqjxqDm5HE2LkpDlYLyTa
         YzAltvkfVucIlEG2Q4l3CrlGaVrKi+SCSlWS2VeI0w3yWyrKTexuWQdc8aHYdoh7C7S7
         ohmueDmP3f/qlFCl6oibd2arSieeRJZRfoREwsswTZTkw6xoxE8lemtFdn2JcsQBVXgv
         NnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744965280; x=1745570080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwc4mfYSXYiH4MmePOdLJBQ3MQuMPTvYksMJAz49SvQ=;
        b=hMc+y3sSNg7ESlQNmyEfiD7ZshfuHn09D+RnsUZsddieZ+y8UcBGowSRdcnYTlII++
         BqHW8jLzZPwwfGXnKPZadCC3QIj25pLzVjjk5ZG8fEnbY6GpsgrZ6QLeFeHDrzYMqSRr
         Cpe6+7hNS/Tv1BJDkt9Fa8R0Oubvx7nCELtHrelmlTKbjUIOcfXbNIBfEUlTvJwOA23H
         ESsA7qC+S5a90f8MdQcW0ljC3wyc+Zx3VVKtgXkHcshEiEzOh6F8z41sUGHKR8NlrRYd
         2r1k6qn61TA8xoXut/Ok+PbZDOJ4+LshuCnvXMP3ass36QUlFRYT9GBVBEr8HiMssEjz
         Q4Mw==
X-Gm-Message-State: AOJu0YzR7MmLSlS/DnJVCpJBlddJ4rJSDrAFpLav6I/pt2z769R3Q90b
	Tgq7Et81zDRcaMkeN8Q8JgXtA5SEUeI7NaGbzGFVwQN3jgilkwFUtd1R+346kq0=
X-Gm-Gg: ASbGncuubX3/dU1rOI9xT029/d/v0g63DgerjNpouaMC6xWzqY098bwigJVnMeW4V0c
	GkwD9JqCltrEmD2pNIVA3aPXgUSu+3oLoWR23kDjZN2iL6pFKZDEJXO3d203XU8YGyz9uRS2cK7
	RLyHwkmer9VQJYhDGQq3aCy5uB5W6QQU9j+/rep4rcc9yckbeqZw5qzAG1LSl2UhAuroJGm6B8B
	j6nULCFEleh1A5QqpQoF7rUj0bxi5l66FRMBXdnD5QR05GJssTyQcwcZBij25JfxJv9c5SQIz5Z
	/GFvvKQnyeVIW3PN8LtKNzrNqRMCUlEw
X-Google-Smtp-Source: AGHT+IEA48lUG8wBLPhPExAjeHlOBbEVqFiNpA99DqGcRwnr+5seRmJHWexkbH0GJZj2p8x907eLbQ==
X-Received: by 2002:a05:6402:84d:b0:5f4:d4a7:dab1 with SMTP id 4fb4d7f45d1cf-5f62854cb97mr1415586a12.18.1744965280426;
        Fri, 18 Apr 2025 01:34:40 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625833ef1sm720914a12.51.2025.04.18.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 01:34:39 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 2/2] um/asm: Replace "REP; NOP" with PAUSE mnemonic
Date: Fri, 18 Apr 2025 10:33:59 +0200
Message-ID: <20250418083436.133148-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418083436.133148-1-ubizjak@gmail.com>
References: <20250418083436.133148-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_013443_095645_D1666C85 
X-CRM114-Status: GOOD (  11.74  )
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

Current minimum required version of binutils is 2.25,
which supports PAUSE instruction mnemonic.

Replace "REP; NOP" with this proper mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Laight <david.laight.linux@gmail.com>
---
v2: Rename rep_nop() to native_pause() first.
---
 arch/x86/um/asm/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index d50549e0089c..e222d2ae28fd 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -21,10 +21,10 @@
 
 #include <asm/user.h>
 
-/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+/* PAUSE is a good thing to insert into busy-wait loops. */
 static __always_inline void native_pause(void)
 {
-	__asm__ __volatile__("rep;nop": : :"memory");
+	__asm__ __volatile__("pause": : :"memory");
 }
 
 static __always_inline void cpu_relax(void)
-- 
2.49.0


