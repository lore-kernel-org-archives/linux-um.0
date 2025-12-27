Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB42E9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejU77izjbpiitWXY1CFRfcJAx1qt+ylV9tDV0w1mOdk=; b=wmtUs1j1ylQ/Hp4Osxd5VQsx83
	H4/yWcQbb93YXIVmE3P8rdAvAbhxXhoLjFPuh46ppjWT+FYcQZNmrg16CFc5io0CbQa8OcTIsF634
	h0HghLL/yM9BiNk7RoKSO8cyC4mUVXNZcHnCrixcwKE8iAXWYzN54eWnUDAmnGxSgq4BetjpRcOOX
	LptLrhLg9/ie2OY8xxcC1EjhwxImZA+a14zJDvfslz5M7kQEiOsBFRidUC4QWmPGKg4BDXaI2GwbM
	LZ/Mg4OkvQPBoxRgt/gp/BzzlSGWjFTFkbnBqIjD2VfpS/Q2gUz/PaUnghrF3KLg+weBI2KHqhF6p
	R/7o3bDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGV-00000001xBL-1FCz;
	Sat, 27 Dec 2025 12:19:23 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGP-00000001x50-23JG
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:21 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso31865755e9.2
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837956; x=1767442756; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejU77izjbpiitWXY1CFRfcJAx1qt+ylV9tDV0w1mOdk=;
        b=dpwnyajkaw6l9D/oXfSIPA3A6vGba7kPkQBao307cPC0JBGDzKe4q2SE7bvela1Yl2
         4FuRoXMIeYZZPv4d87ds594AmH7se1LC7Y+Lb5FkVFFLT50p96q3cpyrNQOU0UCMEE1W
         ah7inerA/2zWnM7P7y8SRXzi9fwBYHH9Gn731nSp6vzXCYjskkdyCF/Q0nW+aNR6Xu4c
         azNaWp26qFYDw8TH8ytx2NFz+MPx3Y46KzTHlNcto57x7zRoM6EqHyDFcevfk/lAwhCJ
         HlfdCVIcnzzR787mrSUXC+kk3cxoz5nMDa3x526a71NSGMpgMDbAJnwlIu6gWbqGl0cs
         Y87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837956; x=1767442756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejU77izjbpiitWXY1CFRfcJAx1qt+ylV9tDV0w1mOdk=;
        b=I9sJ3N1QR3nqTO1J64sKhzT1XND3VUaUBSNQXm56ogD0ikIsummBaz5v0wNBthOKX4
         K///9JMJJ57eDgDrHukg6iHYLrN4lc9XGdmYsXNF16vsIU36DIwykptP82pPoc7PT/D4
         cW15ZLRVFzDthnBRmbAbYMFt/cXMiFo8Ns+vSfWa4pu0oK7JfGjjT0ZZYcSKYIx1BD+t
         xLtO7ui98k62C01SXHDRV47GQxjFIYlcz5gpshmYA3gaHaz3fXsRQ9hs8YOqOf3p/Rlm
         kS2TDHlYL6HcOHsNZXYbEAsy9/VxczFJka1qIW/olLDxqsbUQmh7U/CpL3xYw6bdf9Uy
         nGfA==
X-Gm-Message-State: AOJu0Yy6nI6wDWNZVQMwI4EUoRq4yeQYT3EYhGuUIy1CZgBAhcDz/LCp
	OzdS4noogOms1LJvMembeOE6cdVDVZPokySWunRv2g7xY/T+Jc3lowW+PbY93CVhhto=
X-Gm-Gg: AY/fxX7c+IVCsLEHGnGDoHgHE7RO7NVAjeAHdYVn1nP+eNdLJHjkEVz+Bym5OiDf/Sl
	BDXUEZ4He8nkxoL2pmhGJ1AV9TdCquRXH+6Do+gG9vcVE9hN9R1IE0OenhS4RcNYpfyU3sqwN7q
	3GXUvO4S+q64MFXtZRiSTdEuel59JyHM/H2gYpxze8M3fyi3Pr8AnIo/7vIgeH9vE4BP3jhSqVd
	yuqLY4pJ4RW1535n6LybE+cYGLUHT55lxPpFCzBhlW7Y9AvFemD60TL2gWetXRUWAIV3UREmutw
	9dYPExrLRKLA/qew48VqWW5fZZ6ziwPoy1G8Gb7kUqjYWsCiRlvWmjDPbdIDhqBwdvxaKbo939N
	ZTIc0agWNHsF5WxzkYtLZmIUI17YhCoMi1aRrxcpXb9Y5yzr0cuKlfiR571XSpj+P1pZJWeAYcO
	l2HNI8c9pE
X-Google-Smtp-Source: AGHT+IGcVRETU5SGb8qIhgBdGnot/sm969/AEg3tWF/SLDrOBPXwM9NZtaV8oGtTOpkC0w9sxSvHbQ==
X-Received: by 2002:a05:600c:3148:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d1958e459mr275597435e9.36.1766837955551;
        Sat, 27 Dec 2025 04:19:15 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:15 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:23 -0300
Subject: [PATCH 16/19] drivers: tty: serial: ma35d1_serial: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1239;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=jiVyzdGaYwwOjViBefbG/4tnbA+IZ6VTt4S6NyPkSWY=;
 b=Y3ytKQigesyzk6xu3oPXbBS5mHTUJ1mX1rT6WRhai16pDTDKrILE6MzhKcIyuYvYQYYU9QQLY
 +jUI84bHhmDDBPQbqZ6BL7ROSTnYW/5U7XoL9eZmy1wASQ14fgiWD4j
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041917_576925_0DE8118D 
X-CRM114-Status: GOOD (  11.21  )
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
 drivers/tty/serial/ma35d1_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 285b0fe41a86..d1e03dee5579 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -633,7 +633,7 @@ static struct console ma35d1serial_console = {
 	.write   = ma35d1serial_console_write,
 	.device  = uart_console_device,
 	.setup   = ma35d1serial_console_setup,
-	.flags   = CON_PRINTBUFFER | CON_ENABLED,
+	.flags   = CON_PRINTBUFFER,
 	.index   = -1,
 	.data    = &ma35d1serial_reg,
 };
@@ -657,7 +657,7 @@ static void ma35d1serial_console_init_port(void)
 static int __init ma35d1serial_console_init(void)
 {
 	ma35d1serial_console_init_port();
-	register_console(&ma35d1serial_console);
+	register_console_force(&ma35d1serial_console);
 	return 0;
 }
 console_initcall(ma35d1serial_console_init);

-- 
2.52.0


