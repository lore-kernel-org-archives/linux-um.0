Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73855CFC296
	for <linux-um@archiver.kernel.org>; Fri, 21 Nov 2025 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFSdbuEHlkMgMI9LKgp25jd/vaPmbZhF8IKFWk4+qQQ=; b=1ekiw//1oYYWElYgDjH6mK0tZL
	f4tCioXtgW5RJeN+nOdAi2GlzwOUzWuPRW3bIat/Gk2pneLJ7rjGfYgDCQ+3mQPYQAelwPiE2uHq+
	m8sT1cHOSZ84Z+dtbfU48YammtlxP7BThKJrw1WjYG80ltb3VaeffC+b0Xa4AuMjEI1UVHteqP5V7
	/W+AvJ1MjJvsPALFeswe56omCGOY/AkGluOQhg0oVw2hq1HrHK82ptwgrRF4J4EdIgcI5azxASG8V
	ZUQvz9zdDefHWirCMCU5rUQt/e1VRXJtgnjyq5bjK4tYvqXejyJi1FF9DroTsc12XptsBMtKtT2J4
	qknlUbsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDy-00000008s7h-07IU;
	Fri, 21 Nov 2025 18:51:14 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDv-00000008s6a-2JtN
	for linux-um@lists.infradead.org;
	Fri, 21 Nov 2025 18:51:12 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1481255f8f.3
        for <linux-um@lists.infradead.org>; Fri, 21 Nov 2025 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751069; x=1764355869; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFSdbuEHlkMgMI9LKgp25jd/vaPmbZhF8IKFWk4+qQQ=;
        b=C1a6dNUtV9UYsmAU/dF7wJQYXjnjoLQXj33YPgsbSwEOt+cecIevi2dzA8zbol3M9V
         i4vBUmA4Od9sSnoDHouO3aKyrqfgXaU8rONQ84W5yz56iaewhlgOINk+18EEUFF8CVx9
         6IAXFijpn0uqYVnx4WZS4EZcOFIOp6VFzzMYnH5iiWg2+vV+UOy58Xqk2dIuCALnItXZ
         ZwfUEExygWXuIqGfwpzIe68ISRuSXl9mNgF47uVNpgpiGsjxjKPbVdS0JfsK8whujTWr
         ChJMuuyyLX2t9P84X5Pv2A6MgVJRiy30vCsbcfXwiY991YBxDjYyJhtJMhFM/0zxYw8W
         klKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751069; x=1764355869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFSdbuEHlkMgMI9LKgp25jd/vaPmbZhF8IKFWk4+qQQ=;
        b=U60Y2zwpCc10MatVKuLt2wqOf+BS0uAqazrTQCFACXQ80p2U7nHXe8zA2u3faRvWka
         /L4RQTJtB+SCBQpuKQmVk/l9VK33PbpQsDOpWBPnXcSaeQLDHM1apK1Fps657eQYPz3l
         p5lo1RkiF8zqq/UYDk2q1vAgi5ckJxh63GKhb2nOBQn1hF/ps5TGgHSxa9aqiOK6rXor
         3V6+FRBzAijgD25rox5/O4JdN0d+7wsqTkqRzSElscleRgMkO4iMaN72tKFmZe9B84kL
         5iQVylSfndxVDy/97T2poI6R2CZh6t+PTcCWMJpQUZFjfNu/0cp3OHndt8dMNWHXGLpH
         Liyg==
X-Forwarded-Encrypted: i=1; AJvYcCVEzV14Aaj1RHLqlhLdYjwZJTXgtT80ADWfrYJ0ZI2ZnSwufuTT98fGvlYqtOpgvRbuPGkwBPREeg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZSmclKMMneuamcizpRperoUsmWDNXfqHiislBmai+NS3N5VIy
	x2kJFPUsL8bpn1hf65GX7Nk2sbx8FM44wsIjiMeBXrpCEOcZW+IBQn4QI1tGdMzNCqs2dIu3kfO
	029Dj9MM=
X-Gm-Gg: ASbGnctKZcGdfAs5ITjX/urDFeiPSxSjzZfF7gZOR4vT7EwDhkEf9MA/oja++CUIRpk
	eM5CR0hItlf/HeGINWgktgZNu5mwOjrDXT3F+b3sIZAMp7/rOnlXQUZHW3khA1DHpVrrZ9YqNg/
	PsnvZOI8nfSUN1YadgHIZYY4FvHOUQwREg3G+LCthMTwQmOsV35TWHk64TNDt1G0DLO6lTvJ1+F
	yod24dFZ8bKnYobleqCLhFXImO7KMxXEjk/mYsAKvAy0Noyq3vGhc0yuSwnCvvW/ib1MnU80Rf2
	8FCd3lz3++IUyZ8BIPQsYdHxmNYhs9f/+eFMzntOdzHuBeuPGwBiKbj+UcEhfQODPy25x4BpjUj
	YfB8aYUdJ0Ps+AqlcMojmyiyZHGnhqFjaqrxnxplvRxhnTjvXzSaBKB/MIHcB1PC9fGCVAHIqfj
	ZKibSY1dMHQgFeQMApMRztQFdYeTbF0kyc2C0=
X-Google-Smtp-Source: AGHT+IE3ueb1gfvZpdP1O8B6KsMhh0NreYclj90YAJqPRO3t3jMYj6PAYTHfKHARsU3VdjyGtVHkhA==
X-Received: by 2002:a05:6000:601:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42cc1d0cf4amr3499114f8f.41.1763751068837;
        Fri, 21 Nov 2025 10:51:08 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:08 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:35 -0300
Subject: [PATCH v2 3/4] printk: Use console_is_usable on console_unblank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1461;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=NKFHmcfiCk2EwIkTHkKYjnx6rN1uKn1am+sBKF+oi8Q=;
 b=t+kTGkkizl6U6aR6PW2Gu87Sum27bEEzl8ibey1pJbKk6zu1jVjEcA/kU+oc6YLo7Px6+PkCp
 QGPAFvKM1ClA+rzBQGG0BnUK0kRud59IVkxx67TxhQX137mqpi913XJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_105111_611385_0B390610 
X-CRM114-Status: GOOD (  10.05  )
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

The macro for_each_console_srcu iterates over all registered consoles. It's
implied that all registered consoles have CON_ENABLED flag set, making
the check for the flag unnecessary. Call console_is_usable function to
fully verify if the given console is usable before calling the ->unblank
callback.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cb79d1d2e6e5..fed98a18e830 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3374,12 +3374,10 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (flags & CON_SUSPENDED)
+		if (!console_is_usable(c, console_srcu_read_flags(c), true))
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank) {
+		if (c->unblank) {
 			found_unblank = true;
 			break;
 		}
@@ -3416,12 +3414,10 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (flags & CON_SUSPENDED)
+		if (!console_is_usable(c, console_srcu_read_flags(c), true))
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank)
+		if (c->unblank)
 			c->unblank();
 	}
 	console_srcu_read_unlock(cookie);

-- 
2.51.1


