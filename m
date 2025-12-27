Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5ABE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=; b=q4keP99MTawXIBV3w6RoFpTtmg
	vaU1tdJpqXSVJXgJbNUxEh+2XBZwg+/00vjDekDCkqDhJh10NtrBBAWSDXC/gRb0mC6SHNGc5rNgM
	RwRlNS1xZWpCDK9WQQnVVIKdJQ/Ypv7J0fvlEThm7Onbnh4yOeHjDL+VLMVrtKYqB0Ua2hWLeKEVv
	Ks05ztBfA/VXEK5Uf4z6171Uy5uHOGw0iDWwMgOqha71BtYPngWCMX4lDD56lYJLQhbEtJGEBurA6
	dewZYW+NnJUTdzvIRws1xDjIgvKQqo2Yx1Nl3XS2AxbOveRVKy1VCOEj5T8rNvCeEfYVdBPeJTKSp
	Frl2E84Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFH-00000001w5v-3LJF;
	Sat, 27 Dec 2025 12:18:07 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFD-00000001w1h-38di
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:06 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13337265e9.3
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837882; x=1767442682; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=McjIkF60hHGZT80YB1qO7+FtJy23D5AVvyb/ERnEN2LSc11yhxQAHxfKq3AUFEJh18
         yAbTwLd26Jh1TPIpY+tKGG0UJCRLjW0FAplei+ocl1TUBQaklPRjEEpRDpbOg47JVumF
         4vwCSWZ+rmxc5rPshFr6x5VhxlhkS4jnzWXhuuiA0/TZrZaWW3zwFJUkL63PRZHvbdO3
         2bZnDmdGLMoq2FJC0DcFgyeQB+O1aEA3dqyiMjQQNyHPLHFrigLXVtEGED0FgeW//Sec
         9coDPjwgTQQbkvpUqhfEbi4WqqYqWrHqAbMxAuh9vw5auO3XQSNGMPbic909vxcF4N/7
         UWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837882; x=1767442682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=cveVp8I1ccsb4uYzJ2RueYHr/7+YtGsC+IjAUDDhb48DdQK7dp+BX09bKdk+ybLrZq
         uuotcrJbCH9c3ng/C4EIcjVSe282mxAszdnaZurkdo1z925OqSbDMdsqRkrcjB3k4Jve
         1nTPlDj8JfRL9ybqsFwYGYtzPw2EUaB84gsjyUIdmGgiFSD12YuZ61GpEfuLGIfhZo+8
         SOqrxRrbFiBWeP2vLOIXk0k92ddlWElbWgCv4NU0lKQuR7XMsC88H/xClmaEHyoSY8Gm
         m0nLqdSchLVp7DgZZyftt8eqXSxoPBs7obCewQixqqvwTjxXTbKi9kFYn6kAap2QN9IY
         ARmg==
X-Gm-Message-State: AOJu0YzZN7d5oymPoT998MNYaeZlN2DDMeA2VY2soVQudjE7/mGqaVAe
	hERalYMNDmSNwGCaWZXgKRGMCQgO3uOefc/zek60AzAJrOclS3zYJeb4uN6xk1rryKg=
X-Gm-Gg: AY/fxX6alyPAcsIcOJkV9uaLN+KsG0aKhizriVgBzI+uDaUVg0VOR4KKviQylFVh/iV
	9XVxgmcec9YLV2+2Bf1RoDtCd22nFNmFYZ5+zZpu/W5r5IL+461IY3i2f/FNP5Tuw97AmbQB1pR
	feqyzQZd4ynBQtjr6Wgvphbv3fl2cF7KB85WyIT/tdTPZUcamMi1Rk4tvuWoBBJ86vue3PmhMR8
	QZ1E4Dic4bpMeOaYWFM197toOyJKnT89arfyIti5OidC0JE68LtdPRvXJPF2cV0KzSF5KgQFU+B
	K6hPkUOtbVJbE15bus6XYBuMxW5jGXbIRdRvJXAU5b/OG3dLstgrhZjqEO02QyiTEv7S+/A9Nag
	CQUZJTWP2C9KkWKu849/TbGEhmWr/B3I0IH7slBQjg4OuFPDtwuNtt5wBnhpOqo9hKicASUeGEc
	ksb/LKYs7v
X-Google-Smtp-Source: AGHT+IG0mR7FQaw+l23lNeDI3HZ2oGPwNQnJRaTrq28MQwyhH5VRn+b1LrDgTvBXBb163N6NepB/tA==
X-Received: by 2002:a05:600c:198b:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-47d1df12f84mr272520785e9.0.1766837881680;
        Sat, 27 Dec 2025 04:18:01 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:00 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:15 -0300
Subject: [PATCH 08/19] debug: debug_core: Migrate to register_console_force
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1369;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
 b=frjUdDlkDnmz9ghHbQI85g3SWQC6r698VmLv/vY5BaR0ZhD0fZI/A4RKNedga5QpYNhkZRCmF
 1wOfSuqi/z5ASQwxAphrFcarhmThsZ8zA4jjeiyha2OJh22t8WzJ4PJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041803_870767_AA85A472 
X-CRM114-Status: GOOD (  11.39  )
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
 kernel/debug/debug_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0b9495187fba..4bf736e5a059 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -941,7 +941,7 @@ static void kgdb_console_write(struct console *co, const char *s,
 static struct console kgdbcons = {
 	.name		= "kgdb",
 	.write		= kgdb_console_write,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 };
 
@@ -950,7 +950,7 @@ static int __init opt_kgdb_con(char *str)
 	kgdb_use_con = 1;
 
 	if (kgdb_io_module_registered && !kgdb_con_registered) {
-		register_console(&kgdbcons);
+		register_console_force(&kgdbcons);
 		kgdb_con_registered = 1;
 	}
 
@@ -1071,7 +1071,7 @@ static void kgdb_register_callbacks(void)
 		register_sysrq_key('g', &sysrq_dbg_op);
 #endif
 		if (kgdb_use_con && !kgdb_con_registered) {
-			register_console(&kgdbcons);
+			register_console_force(&kgdbcons);
 			kgdb_con_registered = 1;
 		}
 	}

-- 
2.52.0


