Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6CDC61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blYZX9SALP3mKTtW5/j2PauIX7nPWCX8bAWtr1pxWl0=; b=4/z+R1UfDOE9W0xTrEro8u0heS
	fZihtjwAAH+37r9m4urYtKYaGpImHVsTQo0+VanUislEGQRSG4rKeoZPJEa7tnouT3T1cu15wT/JK
	Kk2mxAplq/XAmaiy1eEzMsFWtiQkrpgiKSEYXKPY4cTVtmeHg0pXQod0S8C6Zh7Mf9XabES3eq5DS
	9ltNvzwm9L2ouNq+q5QFoWANHS+XK4eML7XfBPJFbM/+KqiuoOthL4kzFtLg+DHU92UzrKWWkrqZe
	U/W/tcM4jrjFpzwtxEOaQAF9Zb4ArHtRRV7v/lvY57wGQY7bAvID9WgdWNz1ulb5Q4NRoHlLyZAXS
	bsm0UMcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhL-00000001GeB-2GPN;
	Sat, 07 Jun 2025 02:54:19 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhJ-00000001Gd7-1WG4
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:19 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1503980f8f.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264856; x=1749869656; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blYZX9SALP3mKTtW5/j2PauIX7nPWCX8bAWtr1pxWl0=;
        b=eih3AUjuvYaJlQQlvOeOGi6jzIgS1Rnr5Bbvo/NfkBoRfjwsSmJNueguTrYORRBWx2
         QFt/4NrRcRefCJWfxa9xIutf6ZIqUOb9s2y04MSJQsVT0csW3V3PsWLw+boqgKrD0V7X
         uX/gj1JVVqBrFzZqkFDoFvx2w7s+o2aHWbCCg6Mlc5/8ASv6tslWa1tSssNlMq6b++Ub
         SUL+GYDrAgfYDVpKiNmZY3yZNn9N2cMmXqG+L4T5bfXxy0TMfiQFSM4HnmADa+AUAcqc
         hqqEdxpyRzcrgZ9ZxuBUbw2/FnVvhxcQzwYhia4x5636EMObRPcC6eWP/la2pKr2/kNQ
         Iniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264856; x=1749869656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blYZX9SALP3mKTtW5/j2PauIX7nPWCX8bAWtr1pxWl0=;
        b=Z0lGFmFQfWIkUMaqJmAcjfcfsst1SMjUAZ46Z5VIzNt6TLXXIyObKm8UqlmEAGj3zb
         UvWEbAMWg3oErhcRSqmS4z5JdCdjmwctCHJZ6TPFsObOHoMyCAmD1tvfht5PkQsyy1NX
         d9cg0qpEzpmOg2O7NklSe+4keCj18uTzE5GgZ26DTv7jEtS2QVJsquMKqg8oh90nCGRI
         nFzf+aSGWjiLnSWDDA7aJHhupE2xVTtrHY/A79wuR/aD/XYr76om4TscfJUZi82nPqPy
         gYl/XEJZTO7h28QR3qoJqG0VJJlaqb6sgwbKVpb8w8SoXaORXbNC7DuaU5GBSby+2AuI
         vGOw==
X-Forwarded-Encrypted: i=1; AJvYcCWd8Re24ADwx0D16N1fhL6/oKBjZA8ACbW4P9txvxEIyI0z89VFn3GQwSJSZTE4eeeAwqqs2ut2Dg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6HrmiBTtiNTSBR/WAVPcFwIp2nrN+260clyiSt9/VtEvHahzf
	4NP41/OWrtyXVEC6mD9wXDkp8Zo3+gi55rVtlPbTq0qtyvf1Xf0rIk5fXTn/j8/R02I=
X-Gm-Gg: ASbGnctXZZ0LBmx+GtbkJvjQkx/1B+TXbSmDodyrPMFuYfqO9Z14QdGC5wwXWiO2YBO
	WVAj9v3PSWJ8Fr3kcINBSEJKmzJnSmjnpKYDl2sauvSKoliO2LBUxlHnea/NPANCLLFmMn0sxFl
	4YrDPBLfMSC3lNC3t0LTpkek4LenSvwTQvImwTehurwv207T1gSegc9f0No8RN6miW9a+GEATrw
	vKYe+sR7YR3pdGHH6kEfzrUlZU8Enm+puWcZoeBKgg/XHMhKst8rVmVLQCuefV1ek9ra34S37Xu
	VYqBAoGznlMEEkQhD69tpeJX6WQ26VrX3SGt8w3FL2h4MNvn
X-Google-Smtp-Source: AGHT+IHJ8LwIhaZRKIgzpbwHMvqzg7hdB3xBlwSSNm2xX/hnuxNAGse4PY3D/NNj8BudY/DwljmTRg==
X-Received: by 2002:a5d:584c:0:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a531cec750mr4573998f8f.53.1749264855737;
        Fri, 06 Jun 2025 19:54:15 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:15 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:45 -0300
Subject: [PATCH 3/7] drivers: tty: Check CON_SUSPENDED instead of
 CON_ENABLED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=849;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9kLsFVdVHZC1/N9aRdTRVFrJ42xC1c+3yhppaJpMsio=;
 b=V7C9sb6tGmba5WbbzCCzgvis2cX9AK+EeOcGSXwItak8TkY+K+TnnSUrBrbGp4mQBLXbhFXa1
 b5sMv8+wDMXDBlakfIx+M5fO23Lt7wo09cled0jB6DCtxtxEcDyqWTt
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195417_404981_BC7EB191 
X-CRM114-Status: GOOD (  11.30  )
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

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca9b7d7bad2b6807b29d3768bb655528ea162816..42f81573d8dfc668b38cd0b1c14962a7370cd954 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3570,7 +3570,7 @@ static ssize_t show_cons_active(struct device *dev,
 			continue;
 		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
-		if ((c->flags & CON_ENABLED) == 0)
+		if (c->flags & CON_SUSPENDED)
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))

-- 
2.49.0


