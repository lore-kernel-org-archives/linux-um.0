Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8935CFC296
	for <linux-um@archiver.kernel.org>; Fri, 21 Nov 2025 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKpU+JVEo8jImM4RsWriqSa3YyacHuZk4xRkxS0guks=; b=gLdyr7l8xC2e+4dvRJmfBeNSu+
	bwyANJRNxfcaw5EV/HLiBdoyuALXeHBH9f1JQOQEnjwyCudPG8yzA4S/xHMpRiiM/PWkawannq4T6
	6UPDs0hC2EoRf6fBu9b3ipz/dHts3lXXWEWlOdCPv0eFY00TQ5fBTWQle9xxZX2HJdFASbv9Rb3xE
	G+foyhddXr5B9sQBu2v92T1+Pwgjyw8M3qbePUYsDsSWZl14r3hKo/FqRmVZ2Orbn3J32kpIsFg5t
	vXga5XNdOk1Itu+D94fyPJHT94G5uKia4+1PB/2PiczHGKkbJxVfxBf2Q63qPkMMAic4mOuNBKYwK
	1MCunNfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDo-00000008s42-263U;
	Fri, 21 Nov 2025 18:51:04 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDl-00000008s37-3IlP
	for linux-um@lists.infradead.org;
	Fri, 21 Nov 2025 18:51:02 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so2035320f8f.2
        for <linux-um@lists.infradead.org>; Fri, 21 Nov 2025 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751060; x=1764355860; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKpU+JVEo8jImM4RsWriqSa3YyacHuZk4xRkxS0guks=;
        b=CIniQ0VWwt7lxurzQVNAkOmmaL+oIH7WpnVd7s3LK8kbHXQyLtkeLlZX/tHRAbHg08
         W1EYE1vHZAhuLPBqqAAwL1OpNxrKeH8l0pLkFmDA3otdDyfswZ7HSBF7YnAgRcKVhlJq
         3BbAE7/HhV9PaftBYp+Da1zzZXCDEcrwvu1rv8DN178+TtTR88YDMjjUjkQygYi0szMv
         EgyDTNfLWx9ANcwkIxyMEmDenEvDE27pG9dtd8dSRM4renkz1O/070UN8OjrYEZkmEhf
         jHqD785++FoIJR6S0WvlkVYyW57hbNJTi/KPxUrKlRl3PZ4Rl4wWLbtvJZ54n5yvH1uB
         bNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751060; x=1764355860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IKpU+JVEo8jImM4RsWriqSa3YyacHuZk4xRkxS0guks=;
        b=XKcxNFXBV6DDql9byK5kDdhRuv22+Y+8NvCZuMWO2mI5D+CYGey7XBKqNHSZ5doLeb
         fUc6ksL+nEj3Ih6dcVTiIHPplOIP+WHMPJ9pATsoz4ay+FUsWfFspxnR5tPuXPnkPnUf
         6TBZCPDBjFAcPjSK1XzDp47+g/Qs3ceXyYQDvxPsIJnbrUbjbCgfUi5D4laOrHfSZJBv
         YC6IJ9mBaI0sP7rnoONcnvoWq47n3/+9A3ITBx5jCPL9g+rI6V/RBLPh/gDvH8CIzCUo
         3N8gD0otB3bXZELntHbCbXd+gXzYJqux591JZysWdph6TDdyEHnMRFcWYVCAA6GbFXIY
         c8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUZeZlIhUVIPHkRKydQLrLt/Mq/pN2j+//k/jETio5oYQga04OtjMM9qyfOLjemFbfsCrHrXPLCXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEmlXUUcWvEJfT3ybVwuzt4wxyWC8WAvSg4ClPc3jO5jGdHF0F
	WInI2Lp6uKAevPrYu1RUMrk/OgrPR8cpX41FgupAfLOtpoA0ONGyBXZSV+/zAi4OYKlY4srBMzy
	yUaTwHUM=
X-Gm-Gg: ASbGnctBnRSV/OuNb3RDjVbZbB28w+GmDyrar9jHgWXHN/ujMXkPjovZX09XVYiWEzf
	3YCKLyeskshXV1zbDAKVne2epkH31IAKllFJexUse4Nlf9ebN8ja+UkvdWYSBmFjOGz8ib/0lj4
	Acl3i4t71qBl03zguVRJFqya1Tc1lD7CvYR2lvdIAD6uoAT+JEOYJIiVR692T7+5gDFggSnineb
	EbvB5A4H5FAsV7XZ7cZ9ldSnxBoToJc647kFdJmiO5hlq2+XcK4+hPG0M7N01wAlTCTVv5gmGro
	j+LjNSaywEgMWT+ecBOJAYI4mD7VGw7/wIsPv4xicBQI9BJajTBCNC0355zr6/QBke1N3X9umYD
	DO48jxSxQc550F6c6AQCgFAtSPq/kTNxCOCCMmUFpNwH+Miu1UcPfIvBS7l3opUsFvPdxcNmn3+
	YYa+goSgQMZ3drQgInXd8htGLUIeCkQJXLlVAI6wWSdhXlLg==
X-Google-Smtp-Source: AGHT+IEp7w0ciNVkPyG6KJveUGftNTpGrWBeH1bxscHmBcc3IXgFsFDEhjsS1npeT4GimD56otbUpA==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr3544639f8f.22.1763751059776;
        Fri, 21 Nov 2025 10:50:59 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:50:59 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:33 -0300
Subject: [PATCH v2 1/4] drivers: serial: kgdboc: Drop checks for
 CON_ENABLED and CON_BOOT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1305;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=TNAGn41MV021H2aUeZwKlB7H00LNs29SUKDaNMAUfzg=;
 b=44EC1mGND1ysTRERb+Is2jw0ncg0VNA7gddxT3UyAFKxKAz8occNwGH/6zo30HTuKMjRMAhop
 twSzNFMCXkUByZW8HmxONIKjpn1N/Dp+wJcwjrr3eEm01IAp44DV16a
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_105101_848639_616C1AAD 
X-CRM114-Status: GOOD (  12.19  )
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

The original code tried to find a console that has CON_BOOT _or_
CON_ENABLED flag set. The flag CON_ENABLED is set to all registered
consoles, so in this case this check is always true, even for the
CON_BOOT consoles.

The initial intent of the kgdboc_earlycon_init was to get a console
early (CON_BOOT) or later on in the process (CON_ENABLED). The
code was using for_each_console macro, meaning that all console structs
were previously registered on the printk() machinery. At this point,
any console found on for_each_console is safe for kgdboc_earlycon_init
to use.

Dropping the check makes the code cleaner, and avoids further confusion
by future readers of the code.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/kgdboc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 85f6c5a76e0f..5a955c80a853 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -577,7 +577,6 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}

-- 
2.51.1


