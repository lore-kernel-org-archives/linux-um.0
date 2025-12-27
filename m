Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D1FE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z9kNg59vMLuZUSj8msr6djkrRczOEtEux+Dq5BMshWM=; b=MFcR860RhDzneDbgqcQgJ7R7Zt
	bNmlioj//3bx0G7yJR+LO4tAi3RS9n7HKOM2BfIZ/KMN10KwEw9auZd3EL6Zt0G5DivdWEkiYhvGx
	lHTLRCG8IR02mbKlp6SANwbnbc/rh0PkBcP2necMyKyPTGY+GOPGlKWLkQNkPNH2U4dl5aW6Xc/aq
	fsvUvaHFoxGWx+bWgAH8x5Sc72djYmSqG9r+q4+KudLfh4dE5r7fgtQpk2/U3GoGgJ07D9JiqyIlJ
	xGPWsPjakMOmswqaul+lGtYa7DuohWsfTjeZywmsYsEhJd2R6gSQppTb6aM4Rbz3gZ8JNNvtapFme
	0TQKaoyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFi-00000001wRD-3RDn;
	Sat, 27 Dec 2025 12:18:34 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFf-00000001wNX-1rkl
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:34 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so46306985e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837909; x=1767442709; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9kNg59vMLuZUSj8msr6djkrRczOEtEux+Dq5BMshWM=;
        b=gVLRTswJSEQ0AZZqkazOY96t+0A2Sw9X9z/f9VCkhucHcaSORgDAnzMxMqg6ubHYOW
         p3RfmLhpdirEj1FIoRroyug52wGArhgPqxae7pKjnvKN1dKXqMHjQU1QAXU83KyZhuaM
         GhNlb15aaIDbzv8gzUCmWyiWPRBlGtytdK1LE2cGAAWsVrQmK5A7PqsdiF9Pj5fkG4dp
         Sqw0pl6RyzoB8gTKwMSVhCdOxI5TrCa9odTVeIFhJegbKGpGz1nCSJLCMfXXEYuKgxnZ
         0NKxtDaM9Bj8SD5OnS1tf/yH+71HlN/O1kv7Ar37OLlshBs99UZdezGPCHNv+o7KFPp/
         KoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837909; x=1767442709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9kNg59vMLuZUSj8msr6djkrRczOEtEux+Dq5BMshWM=;
        b=wXW2qX7RIqKoUeDoqaHibdg8YT6pYekhCPssceiQjgkbYAgNyOJqoNySuMQG+REb+G
         vRsx+7h3vdQLlxnSWlQmPkAJvn+yTTCXLr/poOcYWuuVHbbh3pDX0/mSt3bsldPWUTh0
         ng6fpu657zYPBNNJT44OGj7cGecPWZCt8Oa3mgD5QEwKaaN3Qo5uG2QEds6Cnk3oxHEV
         D4gtmlsMCuFG8zuzC0nq8/MlGds0s+ba8zSHx00mx5aDRgPNxE2T02hN5Fs5Zaua7I7k
         C/TAMgwe5tq5Ga0a1PgmFBwhbROC3QNM3Q01BG6NHv2czRFP4+RUKv5R0TakbYj8GpYy
         39iQ==
X-Gm-Message-State: AOJu0YwqtDMGI1+bbIhvG1EfQpYvf0IRgjCZV5SXRe70HzuWE1YXKqxl
	hQpLlDO/7UWTKdeAFAsl5GyqaikqPOolEWAt0bbPBl+uLQJJGr0+4HplTtUEJ33qkW0=
X-Gm-Gg: AY/fxX6j1sd54xXBzgTBLiavMrd5s3EO1xkTeYczGWtfv+YzM7VuBPh6ml/Lt2HWnsR
	x9kdOiLh7LsgWFUv2987QG9SXkmTIrl14ghQ6ylDA/+sW5dVlDpZUIG6arTbzZmNPOqf5v0pvAM
	+CFlvFdF02Zjy/lQLDqdTRERAF089OzlTi2CySZHeIzZe9qBHUCSm+hTsdzQkkTdpnkIL2SRhUA
	FZLwfChBPJxl4XgeQUI/WLcd8UhWi5rBB7uWx0dJqwzXmpv47YALBc+OJJB0U48z5YHBqMCA7Da
	5QBPlJETsWSo7eDV7Na8BXdkXegg9BDsgR0hs0E1pcFZyfY5y15uUfHbZUwIQ/xYzBqKqZHIcsg
	ZJe1+G0MGbmH0U2yUbOTb/gDQGZN6vWav4jLpQ9ZJvQ34MZuSVfUv6NO/yvxHk26wQTU3P/oHL0
	SQ78WdUaMxlPWzmSGpZUc=
X-Google-Smtp-Source: AGHT+IHrtEPOGW5HpG0S0h+CrpgwJd8+zbJNmNN/crxl7Vk2Gjo34WfIR0WT0TkmrlMgn1CALEr/CA==
X-Received: by 2002:a05:600c:4f4c:b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47d1958591bmr299387905e9.26.1766837909421;
        Sat, 27 Dec 2025 04:18:29 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:28 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:18 -0300
Subject: [PATCH 11/19] powerpc: kernel: udbg: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1180;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=EzMaKsRNP/XrImaDzG6owj2ch5Rre3nG7qKvJVZXc3k=;
 b=4hRgVgEFeE8Kfjdb4F4yho+pOLOr4/h5Rv8YKsyU7Hs44mjvTHW9sE+Wu4jBIqif6kS1nJWUa
 QXrCwGXn4DFCsUQcLd3WwFDkthhp5OOtTZ3i5F2rVUBtIHQVlS2lOkg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041831_502233_AED162E5 
X-CRM114-Status: GOOD (  11.96  )
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

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/powerpc/kernel/udbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 862b22b2b616..0f88b7697755 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -142,7 +142,7 @@ static void udbg_console_write(struct console *con, const char *s,
 static struct console udbg_console = {
 	.name	= "udbg",
 	.write	= udbg_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index	= 0,
 };
 
@@ -163,7 +163,7 @@ void __init register_early_udbg_console(void)
 		udbg_console.flags &= ~CON_BOOT;
 	}
 	early_console = &udbg_console;
-	register_console(&udbg_console);
+	register_console_force(&udbg_console);
 }
 
 #if 0   /* if you want to use this as a regular output console */

-- 
2.52.0


