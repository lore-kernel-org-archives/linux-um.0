Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CDEE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zBuTaAePekdaKhl7Nr4xkMCH+YbgmQZc5bDJsdsSluc=; b=pNPabxpEaGYQtXscJJfWqHCqQd
	uZmU1/OA+vWSCwNLYpOB63IQ34KZmoBrB+R4DeRCjeWGHKOaYTh2tIkCFYkZijmBLpNxkAwew1sNT
	DvRHcM0lXnGeng469MCg+SHMmj6i9YTBqjvl3d3qtB217cbAdrKlwqOi7R5nmy/UphZXaAl37tbwn
	Iebh/IdxrbAZDAL0qnHVS3kt15CcbRuw1Q4Mc2fGiB6LssxACuWAfQhPa7iXlHcAmfO8rXblCWr9v
	KPNyUyOcwt0QzTLeOL3F1W3lS0A5teH7LhkwTpNPqvTT9YuonJ+ABD+EatR0Ax06HmzjULoEucc/s
	ACKF3y6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFs-00000001wY2-1e2v;
	Sat, 27 Dec 2025 12:18:44 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFo-00000001wUv-1a7Y
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:41 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso43703935e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837919; x=1767442719; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBuTaAePekdaKhl7Nr4xkMCH+YbgmQZc5bDJsdsSluc=;
        b=IJ1Tlrh5AJdr6dkcc4kcuYbxn5yVBWQWUrTMTk+RvEoHyeZtX3j1a46LdxF22nI79Q
         QJntt27q7NIwsSbr12aGIzZ4XC/u01lDviemkDUvLfzlrxy9SugbqfvNXRMRBdDHino1
         lWbRQwBtxDtxxdCBfqZJemBxhKxjGmbs7ImvHipGRiXnPCXu1DsIIlCGKui1mHvUmQF+
         boRMqjxFyjjmBEmKs/DUD/CCyQG7A2Q38XYMkyRLiZk0Ik0CQZM4WZfbj9mtqUyrmyrG
         UhRT+Svj/Bc95NQUV9NsvHUNKoV/cpCrXNzwH/yY5mi4od1fVazFNBNAJv0cO2Ss7pIy
         oM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837919; x=1767442719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBuTaAePekdaKhl7Nr4xkMCH+YbgmQZc5bDJsdsSluc=;
        b=Jo1XTOjZB0hEn70xvVriTj1nFG7xohh74mDbbP4HVZz0FOE/w+TVoMO6Paci3dqrse
         8MNrivdtK6hnnOp47CJNTybUHpcIuuwOIh33itWhmDha+vQQ640VESwy+DlYjmfdWmy5
         UWhzpzOoEOvzDhjZtw8j2A7JIF3xMWwP9+dNZktdoVQ2idcYFeqMW8Vk8UDkjdZE8ngY
         4+8ospUwMwlKAJs5QORAUJUIQJntmJ7bEZwj5kqlLaZZ7MlxirpanpH3oDNFZDyOCZW6
         wfLhRuROJzP+ocTbtpA0kOrXWsc4+4IuUV1eXNEw1TfSvwupAHhRZ0ZTmysaFnBW7oFG
         MmxQ==
X-Gm-Message-State: AOJu0YxtnwlyjON6rctHdlbvMYoSjZqqqSJ0Y4DhzEJej0HPWhlbpPuD
	gJVrdT3uP8u55N8pxWidl1fO0XL7GE+q8UEeL3xuyPhjpy3p4ggNXvInT1maUOnEvpI=
X-Gm-Gg: AY/fxX5PKNBiN3Ar1pBhEpaMMkB+ZaBYTq8/uUDavc0AFE+JYV8dw1fMJGv9vEHASck
	BLLFU/NMNC9GEhx7sKyYR2e0OwVQbxSYLNN1gjnGnquAKg2/NE3sCL5t7hwRuScKTwuJj8uohVh
	geJP+jHXF17XV33WaMAa8fkj94bnShH8a8lqrhOmDwhrQhLY0bCrAeTyreECGHsJvODHbmotTOg
	dgBPpiiryHLXNtXg7mDo5ypfkMwAiHbzl6A7YZE2pZYy6hQhZUAPz9Veu6CSb+iYapN3GOLQXXp
	2gRRDhF5ZeNmRCPGS7VAToIWbzfHmXUgh46YQUaQAYLU2ONoLxNV8Ny4hFfPeUZy5cmSMlIlSqt
	XKLB1f4nILAq1xhHyRNURqFlXO6fg1nGhBgCdKZpPIBvBzpF7wlupZkElYo9lsTaOub1bkLgTRz
	2JV9so1HSY
X-Google-Smtp-Source: AGHT+IEaiNWrbXUQR9Xr4SWeWCswjY7G2xsTNDPKS34qx+Z9cd/RVKqDItuoVsaN7WK8NMfB3mQH/w==
X-Received: by 2002:a05:600c:3799:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-47be29e87c1mr231953365e9.11.1766837918587;
        Sat, 27 Dec 2025 04:18:38 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:38 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:19 -0300
Subject: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1119;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=rI7fN9M4UYBhm41SNkDmrXmROIuX+aCv9rIYYOtlo+M=;
 b=bcNrmzf90N/BodrKZ64tr7qsRPh416urxDwc2BxCBqWgNmTslPpP/9rT1ZURe+mv3PmWaFnbq
 xnM5PWTrVU8APb7FwkkZf2fGZ3Hw2PsJVWl1KwMiIyJjzl33goH6hX9
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041840_450171_A93DCF31 
X-CRM114-Status: GOOD (  11.32  )
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
 arch/sparc/kernel/btext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 2bf558a0c568..951de7733632 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -301,7 +301,7 @@ static void btext_console_write(struct console *con, const char *s,
 static struct console btext_console = {
 	.name	= "btext",
 	.write	= btext_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index	= 0,
 };
 
@@ -320,7 +320,7 @@ int __init btext_find_display(void)
 	ret = btext_initialize(node);
 	if (!ret) {
 		btext_clearscreen();
-		register_console(&btext_console);
+		register_console_force(&btext_console);
 	}
 	return ret;
 }

-- 
2.52.0


