Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166D4C5AD49
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yF8FpTtagcV7Kwh1mn8c83YxOz5Y2vKGfOZjELVv36A=; b=qOqL1vqs8B4Bt6gIs3JyIsG4BA
	OcjykHmZ1neZxJdaZg1nKcKjk8K3EIveBfn+yE/WlH/WOQQeG/R6jFdHPVoEey+powxt0R5/vjHWV
	N3uZtxzI6xsJkHk+hM2yan+z32opHhR1h8XHNN3ikTmNrUOCq76IWzgZSBzqs7JvKt/+Xo+i3IoPV
	NdorpAsJw6qB7ZP7O8HSO0Jl82gNAWWjKsxfJyYIay3QTRX6HSgMeYVEtLPaWjff37Pth3iY3mteO
	2ig2L83T8Ds5hRHgXPBIWfPghk4+Iu9keuKHyCu3CKohcRt1z+kQ57LCZ0UQ8LLZ72LtOmOtlJdAY
	PrNBMCcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhR-00000001GgM-3YRN;
	Sat, 07 Jun 2025 02:54:25 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhP-00000001Gf4-1DCZ
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:24 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1869967f8f.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264862; x=1749869662; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF8FpTtagcV7Kwh1mn8c83YxOz5Y2vKGfOZjELVv36A=;
        b=FCg19z+Y1AnZEIdoRyPP6Oyn0p12xEy4OGl59FACGlijsuNybDXyHoFEzbincfjCGS
         +GaWymM3LZTNCjqMgrZAFKPYPXw+tQZnvxh72GBuU3FUCAaE4fJj9D3Tey8UuqzYhLkZ
         1GxNMw4HVn1hTDrvPqzNQGIlasoEA18pgQMmQZ4bhRut/F4a79roPNcDVPyxfiqbWo7R
         qJ3O/8W5wpzRa8FtrVfS3JxZ5yXn/3qs9of7MXDMZpzYgfVWZ2VOFLWmvVuFB8BbGTl0
         d/643Kcd3ewRWbZ4E4zgPOTiWKf8a2if0dGVMyqs98dgtC2rNLGDjwIjApMt/Ke0Hsex
         A0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264862; x=1749869662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF8FpTtagcV7Kwh1mn8c83YxOz5Y2vKGfOZjELVv36A=;
        b=LMhCZFv/xhoadpJebvc1+40dghEz93qzpO0gr2Gj3vPQ/ke90hyJdEhgCWgxVI6C+x
         485CU15A4UhTvUPqZ35kcLrptjfCU4OZXIUWUryrrAKDxDHnaufecOJZ/H0m2ge1A4db
         8ZMMCsOG0/C6ZMpLerozhIyEUk0+4CUDh9y8CSO2Mn7wgHWwCTyj/sC58QT/CbKKiS1r
         NqnXusZXymo1NLI8dobx1xLRJy4V+ga7GL8IMLm/EnkHMfEkKijdrWLx71iNkg11gLxe
         Vu8b4cddpcJxpvM8Godfv5XOZDiKUBbroFfU9pDXJP2xe5qLYl339lOtGyU0sQxIbzQU
         WkiA==
X-Forwarded-Encrypted: i=1; AJvYcCXQNQRB5LNu+WoRIr3FBoF97McoJNCAN0ApHt8Zo6Q1g0kMh54AOY1Lop7i8AK2OgFScvNdsB4osQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxye+5gOzxPaCpWxyffSfdqToGbUjyEiRgreWxYwMlDFQr6JKo0
	zV4OKymlgvZFAnEH7d6HGlsmacBf8vrHJ28P54GAz9o8kQOY+9bClkIeiaVpoNQH/qg=
X-Gm-Gg: ASbGncuNQXMp5moPuuhHXzyjVkQMjhwj9d4fuYYsn1VrVvppMh7sXhXVjWR1YJKVLRK
	lM8OqM3BGzsnwKwHBJRNopRbG6lFj5BdoAsAUTr5PkA1liT5tKrqiEnamk1MbFGsLiEGeq3eN7u
	plJ+jlyK0MmhfHIHq/lITDWyP85whcyY3JMn+x40BAWt3vYan9zzO/Hp3Iqfzb2pIR520mOS91I
	2clqJmdpYc01RByEO/3dOVpoyNqULZpDY38sw88G/1AyJVZbaYOCAVSvcKuBv9s4tL2E05K9hRO
	dOjJib8y5W2Lr1QJslVyKGFfb/2q+gVcyFsmUz6CgxtFPVH0d9WHItXuXcw=
X-Google-Smtp-Source: AGHT+IEkD+heqmJq9m8IHeuM06OadoFmpx1jvpTqHM7h9oaBrwao22/Hk/I57LZwA/2jHABWh1ERAw==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3a531786a6cmr4798069f8f.22.1749264861807;
        Fri, 06 Jun 2025 19:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:20 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:46 -0300
Subject: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=966;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=YnwRdm6I1xYkzMWD2CGBnm+ACwq/qI6QghdxR3iROfM=;
 b=cqiZ/O0p08p72ACNj+Qgo78sWzdqazBUHR38ZvlGqr0UR3ruYfxho4i+1leIYi6KW5or2wglX
 aqm/XqqSk0/Dl9v/iYzwAQDXRcTlLt/HqbQYzkxp32RFtqmxiFoy6EG
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195423_332346_0893AB18 
X-CRM114-Status: GOOD (  10.38  )
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

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/kgdboc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b006b2923583a0d2 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
+		    (con->flags & CON_BOOT) &&
+		    ((con->flags & CON_SUSPENDED) == 0) &&
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}

-- 
2.49.0


