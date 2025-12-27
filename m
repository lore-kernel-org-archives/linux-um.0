Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FE0E9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=; b=tK2cSgL7FMwJVu+pP/OIQ57SBr
	rQSvS4PX/3C9wOFUfP0ll0H3hZ0lxrzzh+W12hPzhU3Sd0vLNYMH6mAPSTWzzjFL1ngxCniLECurf
	dKSMBvQKtuVpRuyROSh91Pux25VqdZFyqXaumxE51NfozYoLJTQaeyVbYvKzGmplcSVZyDMcbiGfQ
	RrVgYVdsnsaeMoEOLD7kA1yNjfXZPutuxvxDvXfWuYaLByjBtQMG6JAZFenk89ST937LYI8MB5kXK
	vzqi6TomjYUYSvJnrw5RMa2J2aFO+9HRzAfPbc6qeKT0WH6IlJZczNFZG+mC+u4T50l88kV9qd1yW
	t7jSBrMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFa-00000001wJy-0AbF;
	Sat, 27 Dec 2025 12:18:26 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFW-00000001wFZ-0uiA
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:24 +0000
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso42194355e9.1
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837900; x=1767442700; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=HhydajcNOQ0pLUGIwIk40N0nQjI7dIxRUpI+z5P1JunZRlDUPi7URA0lqyI5hkeI0f
         FuolxDWIT7DH/mJ58gXDYxJw9Ve0smsHt5qMnA4/vhKYUnWSO3Zk6GHHT6WX2ebPxCUh
         SMla85ImZyyFNXnVzWrCC5wyySXkzySvcKC2XJCZscMdlVr1OByT8PxA6WI+Ftd5b52u
         WLDArRQLT40fX+uu2SriNkKGKlo6YWYsvoJkdtJi36W7GRiUj9Y2Wo3PRffloMKL0ORS
         fx4GliKVOm5k1B/04WBn/B2dpP0HkTCRwYCPcFc2V19qiTrM+V7LNOc78g7Lk0aCbUAE
         Ytyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837900; x=1767442700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=FCzJ2RGLdqGT4pe2595JFNE6C0Kfh3Ge7i2jJAmRB9zW6TIghIEmmaQuqSShTlKjMI
         VQGkWIDqwSxCKm/qnRwMPV8eONIx6V/b6mcJK+cQ9LKBVuwjL0qkj23v+B5W+q+yrYcb
         BrPsgziPJt+Aydxbk/A7wM8bhuA8rKNNR6sN8/tqxmF8CufLFVJGQAkimDGPql7Pj1JV
         rF1PSY7fW1T7wqIguTvTuH6zHaimHeSXEKEOCYVaKiXT4RKuw8kC7GVE60U/80jg7TpO
         Y1CsFcJFPTEiXTC7XQA7EONrFYDhXgy84sFp8NdzZi23xZT6ydaitSdyvNbAaieTwIve
         5DBw==
X-Gm-Message-State: AOJu0YxxGqBVBnjOF6j64hmQiv9dh6ApmhSHkYcgXfZ/7Fv6z3rH8F1F
	3Fy93MuOEn1Cmdsy+j7Q1MHz9R+bOsbuVUIIgq6KhpKN/nZaDNGcf0vTEn7lXasA1PI=
X-Gm-Gg: AY/fxX4hKFcjqiW9TNA8CMF03UsvnJ3Io5ROz47lRINcVdQE+AjPF0WGaJ0g+92WqQk
	m+5prgGB80sos13AH4FAjlVbjOAcFik7J4sqQtlcX9lbycsiFUxL3hbs52ZviLfGUV6BvZwYPcK
	jSTITKq8TqPUAwtGXAj3t7Yxm9E+AVucLU5sk67HiD+lm48HjlXMoyLpUwzKYe1gniNKABzwPDY
	2T0hjeOOoCnSMXz7IlMMEMIHoTOHHy2oTXprB1RHsa/1cTVjuJmkpQOfmTLC7PFW5rDzDya6fer
	jAzMUkWN7V1nsmTBWdFkonQ2doR36OyvreQR3KORPqwvyFUNqWZ+gRcJj1t9MgyVQ1DzGV5YJLm
	BlrI3tnfVQaEhN4BwdbCSagKp+qWxjpfUCfQp1FujP4u+Pq3wC3j3hNyZ+/7xbJ/4ka64KwS6eI
	K+M8FC6IcM
X-Google-Smtp-Source: AGHT+IFXI+q7UVcETj2xrgWEDOplaD2DQfL+z5FfnKK5mI2lAjBc9EF1caRTkYKVAlNOUIoqedA3Qg==
X-Received: by 2002:a05:600c:4d98:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47be29f362amr221645875e9.16.1766837900191;
        Sat, 27 Dec 2025 04:18:20 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:19 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:17 -0300
Subject: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1079;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=3dvgtN1V/Te+qiB9DfrS6Ouyxfyny3L7qK8ewpooDVE=;
 b=vEVEr1V/PLyTXU5DKxPct4kmpsEX80YaTpb8m+k5Ll/RykRPcPf3SC/5piYXBTRWgZnh2jkWP
 FQP0jQiJpLBB9Qo/wJGJV1aoieFgYcnUso9xzkOCnscVwaYm3IY9A0b
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041822_709906_1D6CAD20 
X-CRM114-Status: UNSURE (   9.91  )
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

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/pstore/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f8b9c9c73997..9d42c0f2de9e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -418,10 +418,10 @@ static void pstore_register_console(void)
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
-	 * calls may have changed settings (specifically CON_ENABLED).
+	 * calls may have changed settings.
 	 */
-	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
-	register_console(&pstore_console);
+	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;
+	register_console_force(&pstore_console);
 }
 
 static void pstore_unregister_console(void)

-- 
2.52.0


