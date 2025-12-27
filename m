Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20270E8FDD8
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ltdd8M4LmPmBXDEHAaMGtcqMVaDk3ISf2NYRX3F1G54=; b=OT4rqr0a1IMTPTRW5ktoR8nZTF
	NOOC2Q3wpKGUZ6/SndGwJxX0NUtnGHAn/1ik6c/unGfJzCr4qL5oN2UjAcL92hfegBj/uYpRcaa2c
	/wnad0gbNX3zfY0hlDAsSfWamxfsjMPQDB3BCCdC7b4h7Y07gh89wXP2Kn0DEvgliVygI6u0h5itE
	NTJjvv6NzkaFy1tfPH7tsMVw15OvZY85K6c0fXcA9Mkm4JiwePGVfySSErSg1Ln4D00/Hz3SviE/4
	LfwpEpYauswR2st9tV36xiHrTWk2NUt90dNm4X/s8W6seXlsTag3czgjq+qwPYZxYFxyjUTf4aYBU
	sbFyG8Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGp-00000001xUu-3Na0;
	Sat, 27 Dec 2025 12:19:43 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGh-00000001xN5-3s7R
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:42 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-477aa218f20so47224475e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837974; x=1767442774; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ltdd8M4LmPmBXDEHAaMGtcqMVaDk3ISf2NYRX3F1G54=;
        b=HfvCOoUkw3NJD50N5SX40vxsWG1Z0Uu9YPcYVllQfcMC6ZVgMtY3586BHAxBCYLGNM
         j7zuVIG7yiW8+7JT+TmHhjk+tkrZvSzDBolln4/Lzzty9h2B6QtXfilQwHQd75TeI3ro
         UmAk+68AAGJ1R38mCu+TZlo6eh4qWj3H3qVcz7Ri2a91p7kp4jYiAQgdRggVCwPhfJhY
         xe3cb5+6Ju9ogR95B6WdlXI7/3PDrLtqRWG6TYaZ2Objv+G+Dd8mmCUjMKdoMbN/4WNX
         gaxTxPL89vJc3UaG92SXALwe2ufaV9ihO1x6UoWWQhpZhL6o1N1jsHxLEofrYcHYO0+h
         vygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837974; x=1767442774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ltdd8M4LmPmBXDEHAaMGtcqMVaDk3ISf2NYRX3F1G54=;
        b=YrHmv/GzwArdmkm8Qo47g5RHJT8N8fK4Ym8mf4pdnAMNH4u87ATOP5BR+3SADtShol
         luiyJGvxAG5DqQtBtfDuq4i9ZllpprU7ZOfWA0XJERYF4TjLlCerMLAO7Ugn04htAMFS
         1hvf/IN2IxK5JrxCuI6qMGn7HJLigbH9F8NUTaB561VYwJp5DLj4RIygKnyrOnoZbywz
         PP8e+BpwFj42yxk9mMzHE19nC96kSHzwls3gSKjNnfAC/xqjzLYXPIX6ff+ceHE/60JE
         qn9s9pzCI6buv2aQ668cmgABThQg0L2NY1TkduTwX8PxenHzMCgRxQ1iNm51zIcxPoWH
         /Aaw==
X-Gm-Message-State: AOJu0Yz2RMoIIuYKoLDCUVuiUs24DSlhVdp/vYF1vEmGOzUhTxaTpuLo
	yeSKBRSAd8UFsH9hauWujxrOH/wNBIJEM49i823H+cy+OVspt85RRdBfGl56W0a0tVE=
X-Gm-Gg: AY/fxX5C01ieifVOQ2dYo5dSaBV+J1pXEpo2kUxNgbLOP1pBydQ1UiH7nv6dz+thSIl
	WBLIHoL7qBIoOBz+STPQxI4Bxrd1jFo87kHr30x9tgAmzphA36AjlINIuRyzaeLaRT/hqoDlXyh
	CD2mBNfqO1UFVJNlSFDSIhVii06pvmjoef2y0T4S2Zo5Kvw40ZV1zFyvS6Wg2x3BF1zVfTmMPYO
	pjz2BkOdmGqXL8x1TmSG5q8/gUNVhTFuSU0sHI5llpbOBJEMbeCIVtp8K3nQjliqr6XuM/lBhkF
	J5BPEubILqiCGs/DAQZ4YMWCmZf5IFM/h5kTNo7tGAJNW4tFaO7fMuFu4pq+fEo3eeQdrDNE6sj
	RWa27b37ugmzvb6UoO+HVbhtzeDEbI7bKYXL+dD0B21n0U+3E0Y4D+30d9pWalAkFdr+2d2bScQ
	dmpqr0GxAm
X-Google-Smtp-Source: AGHT+IHMLS3VfYivW6iZyjAkGRbHMebp8EGQujmDyd6LpCoRzo/q2pR4OLsY4m1yHd+Dy1qj+iz1Lw==
X-Received: by 2002:a05:600c:5288:b0:47a:75b6:32c with SMTP id 5b1f17b1804b1-47d19532f91mr239061855e9.2.1766837974046;
        Sat, 27 Dec 2025 04:19:34 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:33 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:25 -0300
Subject: [PATCH 18/19] drivers: braille: console: Drop CON_ENABLED console
 flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-18-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=917;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=M+RAaPiD4L8bkGcekgUNUpTeF+sJQV6vQniznC8VslM=;
 b=VNcSKbW4wn0ZJDPmlW3fCDrj2qqqMiKzMUpnoUVSmYqwNJRukKGa+p9lja5itToGTVwI9LN+2
 mQPFka3TIBIDqDnH2JmGqErVL6l4YMmEx/hbdpLg4Ll2XIa+vBtsfSS
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041936_074359_D7ADDC99 
X-CRM114-Status: UNSURE (   8.68  )
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

The braille console doesn't take the same path on register_console
that other console drivers. At this point, it only registers the console
and do not receive any printk message, so we can drop the CON_ENABLED.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/accessibility/braille/braille_console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..0b7ec68b305c 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -360,7 +360,6 @@ int braille_register_console(struct console *console, int index,
 		if (ret != 0)
 			return ret;
 	}
-	console->flags |= CON_ENABLED;
 	console->index = index;
 	braille_co = console;
 	register_keyboard_notifier(&keyboard_notifier_block);

-- 
2.52.0


