Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF5CFC29F
	for <linux-um@archiver.kernel.org>; Fri, 21 Nov 2025 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLWRSgS8p73WSC4ZXf7/hoyNCz/96zbrBiHTXVpyk3k=; b=uMVju2sehFkh2ZM4zkORVyZe9o
	iOc2I1PeIkD34ED2qGGQ/u33Ld0u+9UkiGPVQRuyqlXp+iOg5TTJGbBmWhScSVn7xKYSwOgUzPSaE
	Gsi2XFt4R37JopRfpzxuriYsRPeTvemQWw0gpKdgI5BY8vJQqwX2WXYpOBTgpnSJ5eEIAuZO0iIpM
	I0hrN9apwiQj/rYfuVNafWSLFPt5HY8qASVibB6zMM7VrxQK6wpZnL99dUfJyCXV6VPfI+hF/+kcq
	jq6L/UTsQNK8CeRSaQw3MeHSY+8kKhSAgq7ucdawuTz3sOLkbWea9d6TINW19TjDyzo+ygff0YjHA
	o+R53m/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDs-00000008s5o-3AHT;
	Fri, 21 Nov 2025 18:51:08 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDq-00000008s4Q-2Chx
	for linux-um@lists.infradead.org;
	Fri, 21 Nov 2025 18:51:07 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so1378460f8f.0
        for <linux-um@lists.infradead.org>; Fri, 21 Nov 2025 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751064; x=1764355864; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLWRSgS8p73WSC4ZXf7/hoyNCz/96zbrBiHTXVpyk3k=;
        b=NVOYT7sVhAQM+JdcRdc0vXlcJ8z/5wom58lbYqWKYTv5MzXDvq40f5HywBOYarDDOZ
         CoVevkOPJP6KTtsefOaxpkiC88NhwaDQRd70kz/C1tlnXjG5JswHUohMd/YpUdvZPYus
         YiJpWNWM47V6gRBoQBZooggw8SlNu2m2vPr29PL8qnz9SULfq/sKqeTFm1tSo9L9Tfio
         36rBE9FMiFFndFvfjE6RldBfm9UK11E7/0HWBUjXWEB3ycC2m5+vPXViWRafwkfJQ7Yd
         UL/9txMHGoNDR3CgdEMbNz142XnaBOz2UDAtD7cAaGIiIGbU2cI+SWqm3n9ZUJshgP4i
         kZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751064; x=1764355864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLWRSgS8p73WSC4ZXf7/hoyNCz/96zbrBiHTXVpyk3k=;
        b=Br2cq78FN+FzcsfuRUJDaefJ7LShsHAGbGGau97rtTZC+PDKKsqNxO8cGYkkhO0Iyq
         JykUE1MKklCEQv14L3h/VsBgzUc45UXhy1pi2zsF7UNgSm8jrfjQjGLHd0S6mfQFCm8L
         j/zE2VRXOTIubrhM+svtfZRa5lylIpvrnpXmehLP1B/7rssSAvzzbdm7Sez63gJ0IOh7
         gA7YotlIjrCukB82IhdEtJ7ZkqfxTmxBSWqrB9UeEpdDZYvzOfz30uQ2c4pE2uFZNAq1
         6BotB4cUn0sBSW/RnsLdxAjEtfzcQ8YclrMvzBHcqEfNxhSiwzeVrpRDpAZ2z0XEDNEn
         mWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCViZHWYaiHL+b5wba/8z5Tsu/rX4aJMMVH3oKeguOAla1SLu71QudZS5bxoHtb28HgyVUCHoNV48A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBjyJ4mvgBvTBkZUXm8itI2TQb63uR0mhYCKBNVyDwrbkFbfMp
	CkTRsPtb1E4kRmEE2qfetvNrShv8N6oA9R+fHgt+zNEljgIkYw13uIZxFObMaLFEVsYf8aNINaF
	AnyNUHYk=
X-Gm-Gg: ASbGncvhaQpuJG2vYZJa30Kfb1Ckhs8asg0oHD9A7sd8P+aeyaiCr8BFJ09B6wSXObV
	XYYBXQqPNdZNt/BNaAD8cdW2JQIwoKUJSXDCk6gq8Buo/N2VqTjcxuO7iix3sEZDuA4cH3jaVz+
	hvLLIElXMFEa8EPPbkh5jC0azu/UN4hq6GqAMMLQVj0dWmbhqkumb/mZjkOiTRB0KEm7C4PTIfX
	0OhrJF8ThzykgMWngd+okYCnDSsPw8MWX5hNcm+bgLw+16fbH9irStceXYMd9zJnfWoMmqpELlr
	4sMdcaa6k767EmQD0bayzfaBbUy10h4S55Qk5JK7oqbUh3E5GCEGudm82WAwNsw7rBoe1SmnCEQ
	1BohLy0LogGVWMwIfEx3JWT4a62bOVhLgwlD11x87Qe1NXCCXdOrckNLLtXXvH05jRcu58RRxj6
	JMVOeqfN7nx4QvnatJkpMb2ora2ja3fdjivts=
X-Google-Smtp-Source: AGHT+IGFg2pBnIYtz+jUx29u1lZD8eVRjQQpeMqBKI00tlwv+iTZw9tV5Wu13Zv6ZTnAW9KrThP7uQ==
X-Received: by 2002:a05:6000:230c:b0:429:dde3:659d with SMTP id ffacd0b85a97d-42cc1d0ce1dmr3746531f8f.47.1763751064299;
        Fri, 21 Nov 2025 10:51:04 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:04 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:34 -0300
Subject: [PATCH v2 2/4] arch: um: kmsg_dump: Use console_is_usable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=947;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=OUGnBzAKcXkW36Da9OkzDufBeFjxJOoOBfhwdvnkuOI=;
 b=NhgxbcLWcMIXgHoLmIkuyir16mphjDmcWSS+twRF1KgkvMiTNw7Q71Y6gddQptkBeT/ZV7ybA
 7aK6FXimEBMB8iP+Lld4HVVYCnfUvIZlIMUIC+Vdjx4lrgmiiIWXdaA
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_105106_587960_B2851AE6 
X-CRM114-Status: GOOD (  10.06  )
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

All consoles found on for_each_console are registered, meaning that all
of them have the CON_ENABLED flag set. Since NBCON was introduced it's
important to check if a given console also implements the NBCON callbacks.
The function console_is_usable does exactly that.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 419021175272..fc0f543d1d8e 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (console_srcu_read_flags(con) & CON_ENABLED)) {
+		    console_is_usable(con, console_srcu_read_flags(con), true)) {
 			break;
 		}
 	}

-- 
2.51.1


