Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6C3C61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=079G7lwbZSdbFJvvw8wIKqroIeNsEJYLRsyPP7yIsHs=; b=rb5HxeHAK+rDgEVMOfA4SrKU0c
	jf+O7H1rTSncJJReP4+dGFc6SFqmpiDIT5TZrpmgnumSMbJIbuC8Dx+i+Vg98ZzFe2y23r4oJv+ZB
	0RlYK2ysTF63yGlUnZTZVWFmvmZfLSw3s07U9tlekyyjV1aZoRBYaJv/6WLhJrX4LUluH8lULzvKY
	TuFiJ6nOQ+lrGkIgzmTuYLo2hXMs/G1j1PXAovjSZi8X+nIBF60hfiUtgei7v9g7XZ5kJRc833RfS
	beBTGDYqU/DS4+AopwPMN3X6uxj7HCPk4d96cOgYMU+ISyuIfSyMUzv07lUkcubAsNCmuuyNcrzrd
	2lx4ghsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjh8-00000001GZf-2vUO;
	Sat, 07 Jun 2025 02:54:06 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjh6-00000001GYq-47j4
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:06 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-450dd065828so19508605e9.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264843; x=1749869643; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=079G7lwbZSdbFJvvw8wIKqroIeNsEJYLRsyPP7yIsHs=;
        b=DyvLro4yxteswQGKEcV6Y7mLIPaQ0j8IgsTT1fG40lqtIrN/DCW6oIdp1xp3XSCo6q
         wEZpp5nZfODNoUTwThElq3Kg8uVy6jyohri9/jmYt4tdQP7HC7Lxl7d4UFlALR5sGWZs
         MLmmHCvpJMnVMW0M7iqIjZgjFMVZGwpFjTt5/YYO1D9+LaYWdbhe+GUi0kB5LxwAiQLE
         LEkeahl3VqQBcTR1gx5U8ZpUZ3gcn8uoKCfpej6IoF80k9W8Fun6Ct0Y15x8xIUeq0k0
         SDzvq0MVylGEPlQdM3DRzsuwQLq0NqzxKHi4IC0tePAqA1iRszS6bmm+xK/x83+qr+xk
         xHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264843; x=1749869643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=079G7lwbZSdbFJvvw8wIKqroIeNsEJYLRsyPP7yIsHs=;
        b=bKbka7ojJ/yigufu3jGIHr1aEAXHpr+5bboY7/mrCI8J7skKo7ltxTyJodiPhxr0mi
         9gxmRYqkWqLstQI7UTjvmFPhJvy9HKT+OiqVdmLDmls15AtpRcRQHIWkIE5aUSOvMY2l
         gG5ra8R61+BzV9sHrxJo5jDkdfRl45SF/Zp+YNEnNvNUYxbYiA1QJI4R+qf3wJhK2WUf
         BmVZ9ztoOWvUBkvThzFrCGts031DCy3UGD9AUO29sx0LTBNH1opAVvLW81GQxaZzxgco
         14mOz/5d1YyksIisvB3m5zTJjwHtaOW8kF5Q8lnXQ1lfPJz/QvBZQeBqjjQkaHeNZRHR
         SsYg==
X-Forwarded-Encrypted: i=1; AJvYcCUx7DPyW2GqM/uWkT7lFg/psKyh23pZzazLywN4trrbUpUrYjxZhPsrYbnZjm6+9E5iAmgeD3OS0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMAgCda3P/JC/UuJgXd6gJ1F1Mrpe0Dx/gBCIkllx9m4ygnpGp
	tOGIIbfOpb68aUB+jmBaYo37iFX0EuQWW8kaEq7KyIG4pa3aqMCGitrI0MiwS0tOWUk=
X-Gm-Gg: ASbGnctDeG8s4xqo1o8h4UfoiAdXww5EC9uiPqU21l4UVHyZUBHO67BzhC9NjkizdJI
	NbxeaqIe5IPfDpcVgxHrcs4C+yYjLu2RO76R+LXZHyGx3VS76VI6NvYsKcSniV0SyQTrECzifaO
	1JGmcBULk8iTUt+zjo5eMGG/cqVRm9xwDHDL+Ba4u/OT2mn/ZlBTYYjRhFBhXcn3pNC9dwjTGyR
	XKUF/iamfs2AnFEWYLnuHDiIjhuWtyiCowxMJCNIA6beRszh+7jw3DI8nW66UQA/f062j9/LK3f
	OPUKYWq7ZcFMBhsyG6dJc3Dfpwt2SQ+8tvRZTiJuK2qwEPgp/a0SX1iUGWk=
X-Google-Smtp-Source: AGHT+IEFMaOycz8paZH8Dwc7eB8/xeQCEwaltIN87YJjZdoV9BEkV0ZK9L7/PCQxBolImcH3wDz9CQ==
X-Received: by 2002:a05:600c:8b08:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-4520141635bmr68757385e9.10.1749264843376;
        Fri, 06 Jun 2025 19:54:03 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:02 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:43 -0300
Subject: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=1467;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=8VuAOHFeqx5UMsNpvlh7ZAQit2VLidP6PcKmMQI0hl0=;
 b=T3wYMARjrMBrnSS0B53XQkjL8a0KEFURCPDHgsLUslXubhtqe5kSsdH3AVNiC4itsQepzSKEL
 bCiOgTyAtZ1BpRW6LdXAAFDz3h5mWwilxfoY0pptQZniRHvG6Kc9OCL
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195405_026871_9D6FAF8B 
X-CRM114-Status: UNSURE (   8.58  )
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

Since commit 9e70a5e109a4 ("printk: Add per-console suspended state") the
CON_SUSPENDED flag was introced, and this flag was being checked on
console_is_usable function, which returns false if the console is suspended.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648ed3583375cce3dfe60407894d659c..6d3cf488f4261a3dfd8809a5ab7164b218238c13 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3530,7 +3530,7 @@ void console_suspend(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
+	console_srcu_write_flags(console, console->flags | CON_SUSPENDED);
 	console_list_unlock();
 
 	/*
@@ -3543,13 +3543,14 @@ void console_suspend(struct console *console)
 }
 EXPORT_SYMBOL(console_suspend);
 
+/* Unset CON_SUSPENDED flag so the console can start printing again. */
 void console_resume(struct console *console)
 {
 	struct console_flush_type ft;
 	bool is_nbcon;
 
 	console_list_lock();
-	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	console_srcu_write_flags(console, console->flags & ~CON_SUSPENDED);
 	is_nbcon = console->flags & CON_NBCON;
 	console_list_unlock();
 

-- 
2.49.0


