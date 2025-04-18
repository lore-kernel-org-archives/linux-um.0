Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A927EC369AB
	for <linux-um@archiver.kernel.org>; Fri, 18 Apr 2025 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oSsbi2h5iBdXyMC+7dv/7ZG1+XGOWqlefVNADp2s6XI=; b=n7VZvFzUIuWp1gP43n4xKkdRbo
	7QNG8lDFfll8KWu61JUEfyULEIstyV2SKNaqFo7hRIhIVIO08Rb8u/khneHszed1xQ7cetQwxN6Sm
	EM/w4JsI5V+7XELiO0UabtIoT1TpS8ZTJRIuPgNmHuaQFY+UpvW+YBKOkISv12pLumxqIZewmsA/s
	ysXKwXeI9kHyKnYFj2Cf+E18W3OZmeg6MJsx7p5z07etOGYyGOywpMI59e040l0hN0Od7q5Cs4gHl
	2Vy9SG85xeb49kUTUVdgiG4Pqq8RJLFVqTIt+P5bvDL2R6zqpgT9jGlkMlJgfh0E4JqYqLlQpIkxB
	Z6S3f8CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hOx-0000000Fffy-34O1;
	Fri, 18 Apr 2025 08:48:47 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hBJ-0000000FdRt-2YZU
	for linux-um@lists.infradead.org;
	Fri, 18 Apr 2025 08:34:44 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso2624941a12.2
        for <linux-um@lists.infradead.org>; Fri, 18 Apr 2025 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744965279; x=1745570079; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSsbi2h5iBdXyMC+7dv/7ZG1+XGOWqlefVNADp2s6XI=;
        b=SQtK27Pu/UOOp0nqcAjgePqseLeGoamtLatfgoC9Uef0ufZep74TPOfonf3v8+9Nmb
         Y4QQBAvrlsW/HcTPi8qjzSKLFAuSMwMCd1xe+Z0h4Ed6Zz0j2eAj8Xd102/lI1f4sOCg
         6DyoQlqSY0FKgsLATg9L8khukVeAwbFfFIf7mZKmPfFWBKfrZuj4hScyHRcqQIPWVhj5
         UZh5rw9s3QoFwGxTo+3C25v7Wx7HxZGfFulaSjXL4IiCbnhITsk6WW1cXv/ZcPIz4+1K
         ue9ud2VmRXCp5C/eWWHWAemIPjcz8XSfEBm3NWt5PAIzPhw9jnJ+11xSutdhgLz2bVMU
         VwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744965279; x=1745570079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSsbi2h5iBdXyMC+7dv/7ZG1+XGOWqlefVNADp2s6XI=;
        b=N8/K6KPDEbJnLUPYJs5xlZ+mZfpLKTH/PCVeQe4w909VCpiHZD0fobLBgyNCqB79At
         FgqS37mM+huEvWWvNSnozKnDqJenbPBVO7IIxENXLWTmvsWCIxv2v6LaWjG7kJHCtE4h
         0ZUk97b7U86QCWrAOI18VvWZId9DICwjAvk0uzPzxRDbpvf9wsMymi81GvAU+vCz8I9S
         m+AxlsG3rwvZvIh3UUHC7zh0CqNI6sPnFu5aQJhQCXm4Pn4eu2hCW23i/BWu5gfzCdBL
         LFPFsZujiI//EmCFNFXHLThHTXHlTDcY6VCg4rfKva1JLreRSUAvmH01hhKeRRGm3hEY
         /+RQ==
X-Gm-Message-State: AOJu0YwghmxWxVs1AhmdGA9kz1pjF2+IzLR9yzg5F4RmrMVXnj/wiTbb
	1yy2I4dIPo77uJud1rTWp3TF0ug5lajIyezx2lCA/0klQgEAXvITaURdeaYHwCc=
X-Gm-Gg: ASbGnctB+qgHlOGYANQP1NQOls4HM4i3K2rYpRTCENThk/b5AO/esKc0ZoLyonXUDzD
	wTtJ+qobtqvzNcj+0rMCqS1JoXpzwuzrCeP6rUENeRhvNAWWTVNDnSqfURIFW06Vk9qCgqJbPl9
	i74v0HML4Uzx4zP3VYCNIGlG7SH+N4UTw6/DR4J9EfWE3576VFxjw4NxQcMy4XMk/yhDBViagMm
	jlXdXY6ykPRmdhrL7pre13dfWImMuN4qqxYBzveMTR+k2KET641kVcvYIQAYWpxA8TwE22SfCNc
	QtG/0DKfGvgkN9/QHNRwxmot0lTPD55PQ2wmGC2UxD0=
X-Google-Smtp-Source: AGHT+IHZThepsKn9V2bVgxwhlSry+Hpg3Ap47euI0LM2zXl31mU1hs3J0coFckefEzlq/PAne98rag==
X-Received: by 2002:a05:6402:2708:b0:5e0:8c55:504 with SMTP id 4fb4d7f45d1cf-5f628509768mr1562849a12.7.1744965279225;
        Fri, 18 Apr 2025 01:34:39 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625833ef1sm720914a12.51.2025.04.18.01.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 01:34:38 -0700 (PDT)
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
Subject: [PATCH v2 1/2] um/asm: Rename rep_nop() to native_pause()
Date: Fri, 18 Apr 2025 10:33:58 +0200
Message-ID: <20250418083436.133148-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_013441_649310_AE00FA5C 
X-CRM114-Status: GOOD (  12.24  )
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

Rename rep_nop() function to what it really does.

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
index 478710384b34..d50549e0089c 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -22,7 +22,7 @@
 #include <asm/user.h>
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-static __always_inline void rep_nop(void)
+static __always_inline void native_pause(void)
 {
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
@@ -33,7 +33,7 @@ static __always_inline void cpu_relax(void)
 	    time_travel_mode == TT_MODE_EXTERNAL)
 		time_travel_ndelay(1);
 	else
-		rep_nop();
+		native_pause();
 }
 
 #define task_pt_regs(t) (&(t)->thread.regs)
-- 
2.49.0


