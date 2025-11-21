Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05D8CFC296
	for <linux-um@archiver.kernel.org>; Fri, 21 Nov 2025 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeiJZSVEGGN00WPtN6lgqyU6XWLEKHbZMZ9rjX+7HGY=; b=qWCIdsB+b0A5vjSR8Y5S8zlPGM
	NrBFJEQeu/LR5DYkRZTMMTirKCWhH8QN+Q9y4zywnAmA8JZT2JrmCEMJAiy/sGkHVacLLWnkxcjCZ
	5JB7gy9UVF5hlgck0+/IrVMytj9vAHhwDsb4EYXUElbmTqvFeRV01nVeqYvXwI6zI9uZTGFqJ5/Au
	p79MeJR3eZ3FdMr4UaLhp2E+r5ZAz+MiXMqt/dGL1O3TQJNGWAlSsunIFhDlXc1WXYADyLN6N30BW
	BvI9BYZJHQfWTB8/N0nAgMFaDPR/cjAW0t8jvU8JBCOZjQacLSRCb30QJQ9u1mJV0Coh0u+Fo780+
	FTYFqJTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWE1-00000008s9N-2Fqp;
	Fri, 21 Nov 2025 18:51:17 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDz-00000008s83-1xt9
	for linux-um@lists.infradead.org;
	Fri, 21 Nov 2025 18:51:16 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1296727f8f.0
        for <linux-um@lists.infradead.org>; Fri, 21 Nov 2025 10:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751073; x=1764355873; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeiJZSVEGGN00WPtN6lgqyU6XWLEKHbZMZ9rjX+7HGY=;
        b=dmwoit4+JS4lP7YwuRv7uKV4cpWzwQCr/Ap2G1RaW8I+G6sOyf1mjEmxIOwWqFRIJe
         bPs+lLjvtqIpzOLvieQ51hzV4dboaYgme1Vtzy1kqVELwBD11RaH6acjVYY1nULViJrB
         LP9+kQvwIOhYYkk79laPg2bkGHSywdLUU6CO/8zq8VoPzgABrPldgXqY5Q/MGN4CWcIR
         D0PCl3GUD4XBpEkJfeSFR9RlW0rVIPCX45dR2ZYTkXT2CThId3tZ1ZE6QMqGRzDPvAo+
         Bp2+m0nTq4WZdkE62frFoObW5bMD5Kpk80CuGtlhtSsg9tuqW7FeXW4pg/nGE75wWOlI
         THIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751073; x=1764355873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeiJZSVEGGN00WPtN6lgqyU6XWLEKHbZMZ9rjX+7HGY=;
        b=NPGPr6ah+B4yjIB/6ZQ5QcOvM3Nu+l5eISUHr/5gMUrA4pLJrNqkHMzCNIdrIwXbNR
         /y/hchQ+wzzvwOs/4hMnuLgPYzrGo0+3Xj3Hv766JJZArtaLYxccbxhTt0Sx3Kbpr0hY
         +hkgJuaZoHSMVm6WAWKPn94w+us5xnguYtVz+AKFF6id0qdaD886uJ4kREvAdgp98s1I
         bFY2eBkDdwuRLYRWfu95fM7WS5sAFTLux+ZNIbzuDh++53ICyqRumjWZL2PF/QDMkk7j
         8VK36XxkFQ9eIYhD6K2fkyxu6MgLJzABzm283smoBTBxhkBFyyEv4RqHwAawZ2SiGBnt
         mjFg==
X-Forwarded-Encrypted: i=1; AJvYcCV+TUfKxB5s7abVQ1G5iHkSv+PsTHhTJHMU8ppgBy83d++AHAMLolq3cDaSoXOnqul2Db8/zRbsDA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRojL4FFtv86rsJiCIyotwpfuBmSrvz7WxhoBl/idtAoREzRm8
	SMsUfgzu08YOkLuoiIY9JlkYMXwNj6xUC6rRrtK3S6NDySR3kfhYauwo9oShEvTdLq+veNu76Sc
	7p2n+IMc=
X-Gm-Gg: ASbGnctr45SMdIhbFXgk8V5SaOkpwJvgEJuxhJmgyp82PXEWW/g/ClEGpwWpLYgTNLM
	Edj0E6RhL1JkdlRkrLNlRSUpH1/d3NFhrNa7t5kCB5L+JUFNxvzLeCwrLiEkshLYM21axJ7hMUx
	A5ieJi0etmFKV7S32rW8gePEo2V5K2KL8tha1JqsQlZUuKryootdFBQWhWOZo6dmIF8c4ou8MWg
	nUBbDMmeays7YHnzs6RDZyv3AYt4/aJQjJ8IKzlY7jUD6ReMedG3nyHYd/qN05aASJ4ct8i9XNE
	8DrA1VPvammXtMzmBg5TCeya0VvvDNw9EBWNTQi9zArv8Fu3XmuTBMhCgIzBfoysVE60tdHkZZ0
	pPGm5xPVLvUgOdimieiWqOhBHBQEVS2zELsLzyubUtAHfQlDEdfv3Yk/eOsK2gJb4IoP+yJCZcM
	/7JpRQjk9Gjc/CN6Dvmnad0sSup3Fk0x23k5s=
X-Google-Smtp-Source: AGHT+IENN61/obhbDbsiWgswns0YOtLZMBMlnpiskqZW9+NCINqWoGwYz+8q1vTBc1WOclyJO+Metw==
X-Received: by 2002:a05:6000:4210:b0:429:eb05:1c69 with SMTP id ffacd0b85a97d-42cba63b646mr8898226f8f.2.1763751073426;
        Fri, 21 Nov 2025 10:51:13 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:13 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:36 -0300
Subject: [PATCH v2 4/4] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1998;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Me+FmgCVuipIeMGIOmW7VyWb0ioSCEd8yB49PjrkFbM=;
 b=1f1XQPksSyg2y3pXUnelAzKyzaedaVrzMjIzV4D5cPN+kduYUUNr7nIbIGu3SdlK+vY1dppDR
 WrcjcRwmPvCAZWS/IHHAlVNhq/wnrv4ph6Y5HplOAbeUOE6cjJPPdGD
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_105115_526952_CCD61B19 
X-CRM114-Status: GOOD (  11.18  )
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

Since commit 9e70a5e109a4 ("printk: Add per-console suspended state")
the CON_SUSPENDED flag was introced, and this flag was being checked
on console_is_usable function, which returns false if the console is
suspended.

To make the behavior consistent, change show_cons_active to look for
consoles that are not suspended, instead of checking CON_ENABLED.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/tty_io.c   | 2 +-
 kernel/printk/printk.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70eb7..1b2ce0f36010 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3554,7 +3554,7 @@ static ssize_t show_cons_active(struct device *dev,
 			continue;
 		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
-		if ((c->flags & CON_ENABLED) == 0)
+		if (c->flags & CON_SUSPENDED)
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fed98a18e830..fe7c956f73bd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3542,7 +3542,7 @@ void console_suspend(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
+	console_srcu_write_flags(console, console->flags | CON_SUSPENDED);
 	console_list_unlock();
 
 	/*
@@ -3555,13 +3555,14 @@ void console_suspend(struct console *console)
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
2.51.1


