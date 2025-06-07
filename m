Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFABC61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YhevvUMxwyVlQTogYhSNRf8D9k2NBoggWts0KZ88AYA=; b=G5lmNHEjTfpugSZSc0fe+iMydG
	rEONkWlpfF5F7wrjYE/neBBhevPUNwKO7U7aMoMu2euCR9nYIaQYwiBtqSSyFbQPKxlMbek/F2+LY
	lM/YMxn66SDpd+a2q//zLfGm2U3RCTnDWoLjWUwK67kjKPk399ZJS90REO0kviShogENa9bPwLXJn
	k2NAnJr+pFGKP7mjR6eV0cDflhqwQHLazUa63FQnuxcP0sccX5IFAkKt0qVU4SUBDD0NiQC4Yc0GZ
	IFOVlbGQ/cBZeGwC+SVy/J0jRcA2AeJrUcdsGpjrl5rN24wnu34/wdDEwlYaxEvoVv2b7d7EaYUsO
	HXXMpHyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhk-00000001Gme-00Bn;
	Sat, 07 Jun 2025 02:54:44 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhh-00000001Gm7-0U2o
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:42 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3a522224582so1651008f8f.3
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264880; x=1749869680; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhevvUMxwyVlQTogYhSNRf8D9k2NBoggWts0KZ88AYA=;
        b=BumHpBhsqUvTZJuFjzx7mCzlFjKsbdu46xtkVJAomGH3kRu1+ebnMj/bYlmT3ZbeN7
         +VZqpOtfm83Hgaw/pZRlLMlZyuhWTUI5f8IX8ZybPvtI8Ayi20wpN27x/pPMOZvc4Oxw
         Gd4979yxkriIQcHhCYdY6LaPvHygGRNDaA8mdGp1OEXmBJlnbTkyBlCYfEbtQGXQnXPo
         aZ/agkUydoP24atOamg3YZBlz2t4WbjEoABzWvp9w6zmaufiw3RO1b1TqWsYl/r5lWMY
         zn8nlN85V8uU9gfxLGVnFteFIy/b56YAh+udQaPzT7PWPLiRYgY97gMi4IewnF0Jp0MD
         inVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264880; x=1749869680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhevvUMxwyVlQTogYhSNRf8D9k2NBoggWts0KZ88AYA=;
        b=DgH/vcmJQsXXOlbxtLet8DN3YXPkqn1e5GEwbdQMqN75j4+gyFF7YmCYL4j6Ung5f9
         tDKqB6qO4LTGVHIp0sS+U2ba+R1Km4kNgTBQ55YCDzCeqnj+QsFTe9pq78ikU6XPr6n+
         tKX3ZhiE/U4uIqyVnbdc+VgL3jSm97KrrL8ayJiJcQWhVisi6HMDVq/gPkjUscsAaHBK
         XYAbAIW5z0Yyn3fd2yr3cInS0tB7rMSW+zUPc28mzVLeSZjHkkBe1ZQ2K+gqqr17EW4S
         yWGjrG8pb3JcWr5ZOlg9UW3rHD+1vAwOpt8NLnBgn7POfDRf/Y+bbtMFgIGnDrFhWb/X
         La4A==
X-Forwarded-Encrypted: i=1; AJvYcCXrNqlec8VmlPE9R4AzsycmXH0wf+rPy6qT+wCPc/uR+CpVNVjlIharTEBmGwUeRR01aI12CkeSxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyU+CY3e6NJqiJPsQpkax7PIALXSLiqYVfn2iI8KJhAko+6nk4n
	xPQybAyJdcCycc+oMJPmJxbJ6NQM2wyIcxekLRmzB8IRa0ejnO26nb/lMwIiMCvugi8=
X-Gm-Gg: ASbGncsmsmcyJUdxTKtq95sxvDXrGiVyLlx+8V3icrmudpUp374nNS+LieNClBsVgSO
	k1bkZOQRWmWa5O6S0eYF3ZtsnYXgVFp8Qz7y3jORT/gnVEx5IPze71yhPsMFqeqI4W5KqIqqoM4
	tLpiBBHonYUk811OdrMF1AVu6ehZaQK8eoZnu0gGf1DdLtgVhGYQIMCEW/5vppJm+rH3mZYmoMy
	Y5jUAntQls0q6v0+cG4gWndZBnCcxYNQK2cL5+wPdnpVBRhwQWZAYPXTO4RMKhB9KsajvwV1JIp
	fx8sLC6Rs2N3Z5IxLIhz8O7q/YVDRpJf7Vr9Yjs7NAOlGJTBNrjaRwMZaKE=
X-Google-Smtp-Source: AGHT+IESa5LLq7OFr0HT18MGGSGcdVKv/63HG++r/KCtTOueAXQ6KBohd01OZ9//J5xOfwZkn5rCSw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3a53189bb71mr4901248f8f.23.1749264879655;
        Fri, 06 Jun 2025 19:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:38 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:49 -0300
Subject: [PATCH 7/7] printk: Don't check for CON_ENABLED on console_unblank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=938;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=KOAUnN3mMocWtW+iziCjb9nXWoqfOr6DrzuAgP6VLcQ=;
 b=GzfZv5dsvZ/BfI8fHIsSyKjTfbS5OZlYtux/fj2GG7XKCatBH6tyzKUHv0GzkPE/uoQqkVILv
 HIUpyd53iTgDChm4XdkV5M0tDGRMvQF8qArv0LcgKdpzVAZ3g/sR/hJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195441_156741_5B80D4BC 
X-CRM114-Status: UNSURE (   9.96  )
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

All consoles found on for_each_console_srcu are registered, meaning that all of
them are already CON_ENABLEDed.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 658acf92aa3d2a3d1e294b7e17e5ee96d8169afe..8074a0f73691cfc5f637361048097ace1545c7c0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3360,7 +3360,7 @@ void console_unblank(void)
 		if (flags & CON_SUSPENDED)
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank) {
+		if (c->unblank) {
 			found_unblank = true;
 			break;
 		}
@@ -3402,7 +3402,7 @@ void console_unblank(void)
 		if (flags & CON_SUSPENDED)
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank)
+		if (c->unblank)
 			c->unblank();
 	}
 	console_srcu_read_unlock(cookie);

-- 
2.49.0


