Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61642E9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=; b=CqLnjthoqUXVmQfOOSGYjUt9Pj
	uMO4fcwgFHZotG/7hPJramWQ5x4O426SKZRU2XwV+yis3ic9ikF6giUvRx6oQOBCybXrN2k3yBF9M
	Sm30cPgcFsFr7nZ2N7A2x0tjPOSeBzfqxgB1HjvWeNm5aT85vmIVzTpvZnHG6kQ9a7RUkGLez1tAU
	H7N2g1u60iynSqZLC91Akp9blNxr1QwfLhtr+KDm1FqTIlGGa+wlpoA3OXdC9/6iWk9nEhgH8LRdu
	DwKBbxz/i1hAzsaAW6MsrKAc3HxBibDI+3WziBuEKUGSS6Agw/9kbL5jHqn/ZQ/lTozwYC50w2FSx
	dOuc1aGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTG1-00000001wfa-36wb;
	Sat, 27 Dec 2025 12:18:53 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFx-00000001wbm-2eyF
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:52 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so59045985e9.1
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837928; x=1767442728; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=Y1jxErn8TBO31ogXkHQQp/6Lu5eALAh4fdIhBAOvgLcJKpcvG1gm3MclKY3tMcbubL
         d35iXgvnR644Yi8imFNag6tnj7rX7p3hgZnQKbpZGxWRwAc5I03hOjH/VXNOZT5Ls/WD
         7pKJTpCHPVlM52J9C3vDU6g2azG7tjMUEWAeVbt9rXKF3TRHQ2/qzGYkk7Ae6XJF6xcq
         MYVzTXfHkoEl3SdGxJ3oHpKniVDjJwAXgZCvj1Osmd47tv7n3b9c43m+YBH2EYa8cVZ0
         GRXNV9HbzeJmxK99KtrMA0M/FicKX73vcOuQaY61xGtJhtMojNGtePkxuJmBTdy3jiWB
         wUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837928; x=1767442728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=VmFpa63fQiSvl2CruGYq9QO7JRnmskzG2cKQKOreevSOJ+eHkLrXPcxWayw5wmnXyf
         MECUkhY430ndN+SHgnIe55voNKtkZPsAaL9hZBexgLaglqAvPv4MHm04//lAAxe2SCiB
         IT1OdVYZQXd9vFo7XB11tBfY/BgGbZBgbEJp349J659RBCbj5bNgnaK2xT4IMK9xKdih
         +XHNjPiqS9g7OZ0VXTCmOwUZbWOdNcWtFnvO9DHWCkDq9ybOd31lCnuFZTP52zxn7t8u
         Iw/XL+k7/XFMHsa7d30rS0C7bS5ZysRJWwtYAZ0+s6YMaJt1Nh+EMhW+9vMrCy8d8Ikn
         NtCw==
X-Gm-Message-State: AOJu0YyciYeEvhzXDMidFbC+bmzg4Z7eJOkCYz42PJdUuCKWBq3GVWoM
	dQdoZWR/9jU/yxaTnM3ZWkDrO658tQwXZiBR3qo4xVmNdWULDKLc74wgORJyMyZJgp0=
X-Gm-Gg: AY/fxX4iXfdk7c4nOVWXiK3eqIdh0lYluZGa14w88wbDdQYC2uxB1rjCMlY7qB7/927
	Q5mRpfNbQPYIYxNyrtT4rXQJJEhVaYBhP5K3PfXLEtRqfbG/OOpWrsfp/7b91Gdi2fnFDZIbmR8
	YNgTIf2w4fU9iXcm5fJCZ4jRyLhReRIRpzoWcmxUke8VmLOs1OMSy9AE226vF/FQTxJlDAasPOC
	6Hj04yljm84NjrPJvLeHuJQxSntsY4mRogAMryeUyIyugX3pkWRX9o4Kg12yA68FLLJqjUzIaTB
	X0nhNeXpvx9mjY8laxzvcwzoYwcs8AjqbvP+acNHsuf0wdieCN1ctu9PS3bf6ybBao9yOxQOBkT
	bA4IFUWLaFX/4DO37vfPgG7PCATG/RRHf+0NEqKUoky681MW7Ox6XLO7f+MmSwkqCYUT+3AkHbr
	wHCA3GGXMe
X-Google-Smtp-Source: AGHT+IFbCGvkCxGExFQLBl5yaU008gmiVvRdmeb7k0sjyaCh7Z1nYJocCXv7ZLYKC/Juko66305eyA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr270395745e9.34.1766837927833;
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:20 -0300
Subject: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=961;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
 b=gNLF1CEZIFvupLFUy4kgNSgx2QLue8Fjf3sjVi+zSBhpSIWUfb0laNahgF6qahlq6x3pophwD
 dRykPPu3R/nALZM8P2pCpkq//4oDFgsmNLGc4Tixc+Z0JIXH+9rAGGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041849_747536_8CD73EA0 
X-CRM114-Status: GOOD (  10.43  )
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
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff4bda95b9c7..ce4f4ceb7f27 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -582,12 +582,11 @@ static void console_write(struct console *console, const char *string,
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	register_console_force(&mc_console);
 	return 0;
 }
 

-- 
2.52.0


