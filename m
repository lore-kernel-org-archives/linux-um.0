Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC60EE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WVQ5l6OvuwNcTcqNwKXFrwDkeL8FFp17NQ/ZoKZRdE=; b=AikQ9zjL4+EMXF5PTUR2UGWwmB
	u2RRAfIfdCGjeHvVSk6buj0VpVUskg7oPy8pPARqU5gTyUSP87xdJFbUIitHvyX50o4XF6aA0fO4F
	RFlrgv60InW20ig8ycatOYDSMoqC9W1I+LkVC069s4l7Bnvs7GXY/sv9igobnhDydGPWTP+N0TXTs
	aRHIweqxxauhNdzCNI/dB0uAvNPBUlzjwlTk8+pHAC1Jz+353skFzORZa2do9Y7q+7IUUdTamoTe8
	IhX0L2cnc6F61iutWBoYypOtcRtwj4yAXCxO82iqFfseh9nicG4C3+tnuwa5vWRetK3tywaldfWN/
	0FdcjQKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTF6-00000001vx5-1jPv;
	Sat, 27 Dec 2025 12:17:56 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTF3-00000001vuF-3DoC
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:17:55 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-477632d9326so48368065e9.1
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837872; x=1767442672; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WVQ5l6OvuwNcTcqNwKXFrwDkeL8FFp17NQ/ZoKZRdE=;
        b=TDLMdc8pAsyCDqYsuWO6quFezUM9b1Vn/I6k5cmloFI30L55wKcCxPNasicRjfYHTZ
         24XdlsLVtrC/75A+6tWiFGr5njMd8wrA/P92rRkuKJDf4G2NHzPZGKA6b2+ZNPLOqx4o
         3ZB+LH7zLH/WJywLJBHvTN3+DqaJaBcRt+DzesO6+0yrdR2aMDrhuGqfX99aN+fvs4zo
         r8cNpXjpkPz/oyG55zgXzhENPQBMQAtW/iOcZMxmvDOslj2Qa0H7BI4FpE1Jt+VXmZIJ
         btASQ4pntcO2mD9PALi32KiVdDCzGwQMfkB7uUdK6eoR4w6wHxiqhBwAVGRrqJU9qoLu
         OxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837872; x=1767442672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WVQ5l6OvuwNcTcqNwKXFrwDkeL8FFp17NQ/ZoKZRdE=;
        b=WmiYGrfj839eaCrXAal58JjFQDj3hcINdOQGso52z1y8EKZk8Oxrm2T3+Uihc2+6NF
         HwMUWqaTHfVRrm/metWSED36oMw6Kmw4w8Eec/iXMtrCTTyDO6Xp85f01buCg30wveqT
         w6wJogmzvGbCbgJ32zqqcX/Av2/u13iqhtaBx6ScDzJb3tg4UoznSpoHvJYZC7g/9piJ
         QChDYou8nrL1zlpkK2sspkkNvoqS5WpdTm9PkZnJpVpK10gLFxhXvJZcEEMxyQ6hKgXP
         1euSw/uaCmS6Sy2kwF3c9LDfg3kDtV/oCZIwrmnCzmIg/FPfCqQKXLr+CJJV1uHXT8Gs
         P9wA==
X-Gm-Message-State: AOJu0YwbPre+N8ShbfE8Ev6fFq7fLJNfVQ8TjoVK6V/dyeT7aM6HFTXy
	i7yzPn4pLJI923LRM4tTqlxQBH7pqRYT9jPxFBd1F4eic5gshqPCrinZxOU7b8Y3DHM=
X-Gm-Gg: AY/fxX5u2wYMT1bPRLDRib+VVBI5rhtbRIOMIkF0dyVkX2UbTjyE3GMxabSXWyxiJ3l
	yzd16fO38CjBdTBvrAr5zLQ6EE/m/0ejdLVUdBXDaSXhk4ZSAvMKE3Gsc7picxxXL6LC0rPaGIa
	UE49JnLdIPC+arhmKzIidgzGTdeWuGD7fOkrcOv631DRxyM9vL+w469lqomP4ktN4SLDMN/bhUf
	MAniOVndN4E2uCuAlnH6LQqibLw+uB4axltqSDBugRym5rgvW+baaysiXuQM33ANeToCYaUmDUL
	1RuCxttZN/KPdOvzzkqRCPtkiwEe7PpvlDCrAyGe+xO5Y+FZkh/ELc4K/lh+2/suMo7XNwyR2km
	q7CvsHpCnIJoywWBL57c0f2cOkTlWAl9JkvaRc6Iuv44EuiHbcaSN3byw907t95DpjH0LT2+TgO
	VJDHmfTLma
X-Google-Smtp-Source: AGHT+IF/XDCpzgWo6CWLRHeKJmnECzN+dRl41jhTKGOm6P2nA90X9/hReUsAzbYAQmyiLuP2DWyXTg==
X-Received: by 2002:a05:600c:3111:b0:477:b642:9dc6 with SMTP id 5b1f17b1804b1-47d195aa79cmr275082695e9.34.1766837872067;
        Sat, 27 Dec 2025 04:17:52 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:51 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:14 -0300
Subject: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1917;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=oiRJqd24xNJBRHp4bn2koH7CqQq/f2UmEpMOGnQzYhI=;
 b=PNCcHQvlH3xv93I4pBS5nug5ofRvIPVdGmJf0P9wllAmoEtQiq8Up0JT6yGQIvoJ3BjyCDLfA
 69PIUeecq2AAR6MO/z2xt/dsbeEPhnFU/DPDF0NwOHQtgJdH0eloVGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041753_868990_94BA76E3 
X-CRM114-Status: GOOD (  12.27  )
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

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/net/netconsole.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..509ab629d95f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -583,16 +583,14 @@ static ssize_t enabled_store(struct config_item *item,
 		}
 
 		if (nt->extended && !console_is_registered(&netconsole_ext)) {
-			netconsole_ext.flags |= CON_ENABLED;
-			register_console(&netconsole_ext);
+			register_console_force(&netconsole_ext);
 		}
 
 		/* User might be enabling the basic format target for the very
 		 * first time, make sure the console is registered.
 		 */
 		if (!nt->extended && !console_is_registered(&netconsole)) {
-			netconsole.flags |= CON_ENABLED;
-			register_console(&netconsole);
+			register_console_force(&netconsole);
 		}
 
 		/*
@@ -1917,13 +1915,12 @@ static void free_param_target(struct netconsole_target *nt)
 
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
-	.flags	= CON_ENABLED | CON_EXTENDED,
+	.flags	= CON_EXTENDED,
 	.write	= write_ext_msg,
 };
 
 static struct console netconsole = {
 	.name	= "netcon",
-	.flags	= CON_ENABLED,
 	.write	= write_msg,
 };
 
@@ -1971,9 +1968,9 @@ static int __init init_netconsole(void)
 		goto undonotifier;
 
 	if (console_type_needed & CONS_EXTENDED)
-		register_console(&netconsole_ext);
+		register_console_force(&netconsole_ext);
 	if (console_type_needed & CONS_BASIC)
-		register_console(&netconsole);
+		register_console_force(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;

-- 
2.52.0


