Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8FE8FDD8
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=; b=1/iO5v6tYPCdWq/yjzRUC9nEDq
	l0PyIoB9rp/GvH82p3nFOvB9+7OrhXBN6/h9Nvo1a7GABGVNc8/Hgis3WttgSxJt57fGG/VrI7Nov
	p2ion8U9XmJS5rmJzELhv9XHSsVHMuMAmt7CeqI8ZB8QW7ifY6CsTi6NsDayyV3oWp/4p35UvRmYD
	Vz8Dgc5slCEetGflXKIVttvjo5GWhX8YE02bXpJnL8sn99KIeQEn7nNOXl9/2uwIRCwr6zMiQ1l+X
	/l7THpfYv+ZnLZOinCntpusKXT2YZjdzlfWW+OAfIgWvqiaOt4WXP/AeeUj/YQiY3WSVJnEV9sqyP
	8jM538zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGK-00000001wzU-05xG;
	Sat, 27 Dec 2025 12:19:12 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGG-00000001wtV-1gLs
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:09 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so21710985e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837946; x=1767442746; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=Jh3YztpdpNGPB9iMQZll2rWHizPw1FzXPSF1oWaHDJp87KUfOfYKaw5PoYHHlr44se
         rKDHQzObf6eEYLFiRoqmoLFkExRrPeMZE4pL8WhNlOxtM08hiWsMKb4Kmn2Ggv7t8T/j
         FQtfbpH1iQwrDFGCbGyighfmNysNjFreOZXKQ7Ih1M0brczIyPtBRZfNcXWR+vyqDLs0
         z5Isra4x2ax7SKRVU2Bl8r9oJwsQ/pXyOPOtRzderPIi/ljoXllCXzm5OBJFkPPWS3cR
         3A2aeTqckv/pkNz0lfAep4MJBoxF7P9Up1qyPVi+9s50W6Eez9fcgkdbkkU68VOtvxtJ
         gRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837946; x=1767442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=QWcGuNMBkCdbYx+UL0pfyu/owTLC3Ac/BcKSWMDj62A5giSczIyGY/14DNXhlsgeVD
         yK9oi7K3suAXbrItG9wycXoZMndwg44cxSxsXTzy9WAEvvS6gNxbcpz1Cf/E6XsNyd0P
         4H7gtPsw/K5BsMgQvFDsq0VsG2TWvTuPQApMRSy5YOp+/5j//V4TeDIRKFKRherV2oZS
         vFgq4CdcWJd8WTdg9rRCELM7wt1yU5jpjkyFutU3/+w86S8JBPArBQGeKlUYU4CQ5Gl9
         GLGJOxc4lPNaZQGNNGj8WZ2HPkqIy4wx7TSWXyTUq3cBPUuZYVUCHhSiWVyCmqZrlAbV
         JPQQ==
X-Gm-Message-State: AOJu0YzsLBwkHCo7wnu5bi/H9HgQi3gDSF22/l24DNbTMbK554gFxJ5d
	nTQu35PLj41d4yR8oG5PZbOq2zdh2L73oSmy+VCvGpMowDP9SUu/qhbi+yVD1bYkKpY=
X-Gm-Gg: AY/fxX6JzIkWW9yFth0uhgch85nGUDHljDTEPnZB+cJRICKiKdiAoWICU6tYQxrPvEB
	H33covJOq21f+TSQohDSbgnLKP7uG6C1gLB8Fc0J5UhVOZ3THszhRNKkL78Ek4521HhCh7kkyKM
	oiZHei388JxO8a1sWT0VP7RN937uYn88NFMS0tohkQ9AJ2Y/UXT9zMKG9RL/7aYbsuk2NiWNP3x
	AYjW/iOvAOHDZOEu4vxl4dVV2P8KYAyxOtLs0FBLWarz+Q9HYCUWU9EvbtDB6SlVFeuTY0pkR4A
	LS0h5wsHimabehXedLfn6nAFF0ylxXJUdUXeOd7aQUFcTQXhNzJ7W+zaU2YwsAcE4qCUbLlk+mw
	X9Hd8UpsR+tB9R2Dq55/bwZpZWZJVgmZigPDcXhZProuukx/0fNR392rnkjIKq7l5lYycyl2XYl
	QreLmGSl6u
X-Google-Smtp-Source: AGHT+IFQPHp9+ZXnfJ9gaFXvmbmtROboeRiL3XR0blYfmQMI8wXzbSWqjXdBS1sjkb/JteTKHl2ZOA==
X-Received: by 2002:a05:600c:5303:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47d195c2d7fmr223567305e9.36.1766837946357;
        Sat, 27 Dec 2025 04:19:06 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:05 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:22 -0300
Subject: [PATCH 15/19] drivers: tty: serial: mux.c: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-15-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1068;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=8apb8xIF3Rmf3METSNa3/bIFoDSqesuSeq+cEdBJRMg=;
 b=SOQn5veC0enOSDBgUA8xgjFU36YeIU5ltm01mWbteI/FsjC7wSIvDCGkCl9Jt9bptuqtwUiUT
 XJt5OJVOiy0DmhgN+BFidqaWmVu/I5CuRGxAmhAzWOivaZFVrPO2ZNN
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041908_466223_54F0672A 
X-CRM114-Status: GOOD (  11.00  )
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
 drivers/tty/serial/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index b417faead20f..5a2d706b9cbc 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -390,7 +390,7 @@ static struct console mux_console = {
 	.write =	mux_console_write,
 	.device =	uart_console_device,
 	.setup =	mux_console_setup,
-	.flags =	CON_ENABLED | CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER,
 	.index =	0,
 	.data =		&mux_driver,
 };
@@ -547,7 +547,7 @@ static int __init mux_init(void)
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
 
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
-	        register_console(&mux_console);
+		register_console_force(&mux_console);
 #endif
 	}
 

-- 
2.52.0


