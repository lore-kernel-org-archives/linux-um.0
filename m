Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C45AE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=; b=WI98do5ZkJKAgWZ1u9O7EqEX2z
	c1fbuz8Y3J+ZJTHp5wljukZsQvf7RgI6fTgHhhsRBRBDSyz7oExkQImnARNW8GcqQLwggkeOCzwm0
	+wsufWIUNg9zU/+Xb77MFJKWJBcOr1aispkhFHvdFwQI9vaHsowbnXGcL2OooVBX4Xk8iO/Qgq8Qr
	yLXyMfR7RmlrLFTgW58YdPJQe77zg4f7IXfhoTbT5usDRXBevlYwiiVH+K+2CJxWNNQi3flYLOIpi
	PYkED0FV9ibtZbDpa12KH/3J0JivapopQnLVrevGAZBOW3Ae9JqcrJYRiRh/OfoWRXy6zKq6CKSsV
	cM7AFXEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTEx-00000001vqC-0yGR;
	Sat, 27 Dec 2025 12:17:47 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTEu-00000001vno-3Uic
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:17:46 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso43702015e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837863; x=1767442663; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=CUXnHGyDj0H+y4bjuiijpjutx/f+NQN+YwXpuVi3o7EKK2hNoG5WiOfobE7Tc9/BHI
         dj0ERTTY0Igl+dK0BHK0ILF7/ZGjAVEdDMOZlNsdeitXZCcm9yiR+RfEPbEpUv0XIRFI
         CcY2lzUwUn1WqAALDRWktab35keOBaz71qYT1o8z92Qyvivc6l167dVVJnCOF3qu2ZR6
         V4i7SQzsxlNVwys16TIcZ256AE95lWaLkUJd81+hbr25s0eD6iLqxys/NJfO4QgVay4j
         BWWpPRASPwoxHu5sMx0WYhb4OZ4tQ8SsB0v+9oj8SaLhEKTpu8mg/oW0AalSs7Spx1TF
         Sh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837863; x=1767442663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=OobnIr/WnJcVUJpI7tBCZniKWXU+wj6+4E/wFM4ezCFYFpTej5uvwWWCZuvYBmWgJU
         eUY/tDvZhpRdT5g+XWZlRnLGReH0jJkf75SM0q1LOTOaP/RcZkOZ827uCvn1JtZ14smj
         oXJZIVigs8AlATYl0TtsiIvsb7ZCYmkIpUHciFNWNYfASCiTUGA/LV5xeJhyJPPevu52
         9Na3ngLoTb/jaEhT6f7rt0+6x9iLHJbWsYFLMhfS9yokE0J/CRbSpaGZSZbGW27KsQiD
         U/UfRSu7mL9PLwthvgeAbflxFsvR7wJmi5JZncPm6SVNyaQEWkT3xiffRccErN+npEa2
         Uy5g==
X-Gm-Message-State: AOJu0YzAF9PQsOgyQGwG2qF23Z0WIcv4UrFL5vjC/sEM+iEdhOcjRgSj
	reN+QUVIU926vK2f0LN6rnD3izfpMPL3a5f9MNGmhenpgQdrqkxyjrCiQq2cwlop1Uk=
X-Gm-Gg: AY/fxX6QwcApRTI5Pu1QwyXpuRCAZlbcoGEqMHcCoYxZtU2yilp/aYiuOhfOyFEloqz
	tJdhEQb77TCEngAaUZqtMuvUE77FEDHG9xWdyHMDaM5SpaYYGIsxcVXi7i822nRiaUzCqYgoggn
	7fcN/0bvE3GGTc04mXHrYMskdm7Y2eMvN1gI5sWdFOmkrKTHt2aY5JffWQ6UHqBKX6sHgegmVZM
	zRmvAlayxMsQcy2GN+RnfuJPYUUiJK9LPdVn17GXhaSYj80z2o93FfT2OgGwps6tR2uolVODLMK
	oxoA2XkXVTLXfVbUCmZrPReN22siebzFXgLEynLssrcLXilHJgt3POwt/1g8S4bxt0KPWxLUI1p
	p0KhG9KSeBQ4RV9/aAO6cAlz03tK+nVCU2rRjX1nnDRViSSB2ayTMZnSGL4cMuRIDnCwdQhBq4X
	cRIwBcbNw5nJD4jjAB9YQ=
X-Google-Smtp-Source: AGHT+IG9JI4KghQQLO4JoQ5Zx3PCxaurUWQYnoyI9pepg6l828D4iHu4xsQcwAkRrVG/7RHQ7XMpOg==
X-Received: by 2002:a05:600c:3397:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-47be2999657mr224830455e9.4.1766837862676;
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:13 -0300
Subject: [PATCH 06/19] printk: Introduce register_console_force
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-6-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5702;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=yZ/nvvnmmkaNmxpD4iXjZtoziYkh4kvSpXf/WZXovX8=;
 b=Bzarxjf3B7CuE6yunxTz81Z6xrtzP/oSyuvyRHrm78aAxtHdfrdz9xczyh+zQMNScnR1tQowx
 BZmWRp2B3qfBQ9NUKyPZEo6SC7UASze6iocMjN2ThffW7UbTy1hRyur
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041744_934202_3516620B 
X-CRM114-Status: GOOD (  21.66  )
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

The register_console_force function will register a console even if it
wasn't specified on boot. The new function will act like all consoles
being registered were using the CON_ENABLED flag.

The CON_ENABLED flag will be removed in the following patches and the
drivers that use it will migrate to register_console_force instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 65 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index caf9b0951129..7d374a29a625 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -792,6 +792,7 @@ enum con_flush_mode {
 extern int add_preferred_console(const char *name, const short idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
+extern void register_console_force(struct console *c);
 extern int unregister_console(struct console *);
 extern void console_lock(void);
 extern int console_trylock(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 85a8b6521d9e..c5c05e4d0a67 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3858,7 +3858,7 @@ static int console_call_setup(struct console *newcon, char *options)
  * enabled such as netconsole
  */
 static int try_enable_preferred_console(struct console *newcon,
-					bool user_specified)
+					bool user_specified, bool force)
 {
 	struct console_cmdline *c;
 	int i, err;
@@ -3896,12 +3896,15 @@ static int try_enable_preferred_console(struct console *newcon,
 		return 0;
 	}
 
+	if (force)
+		newcon->flags |= CON_ENABLED;
+
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
+	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -4001,26 +4004,11 @@ static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 
 static int unregister_console_locked(struct console *console);
 
-/*
- * The console driver calls this routine during kernel initialization
- * to register the console printing procedure with printk() and to
- * print any messages that were printed by the kernel before the
- * console driver was initialized.
- *
- * This can happen pretty early during the boot process (because of
- * early_printk) - sometimes before setup_arch() completes - be careful
- * of what kernel features are used - they may not be initialised yet.
- *
- * There are two types of consoles - bootconsoles (early_printk) and
- * "real" consoles (everything which is not a bootconsole) which are
- * handled differently.
- *  - Any number of bootconsoles can be registered at any time.
- *  - As soon as a "real" console is registered, all bootconsoles
- *    will be unregistered automatically.
- *  - Once a "real" console is registered, any attempt to register a
- *    bootconsoles will be rejected
+/**
+ * __register_console: Register a new console
+ * @force: Register the console even if not specified on boot
  */
-void register_console(struct console *newcon)
+static void __register_console(struct console *newcon, bool force)
 {
 	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
@@ -4080,11 +4068,11 @@ void register_console(struct console *newcon)
 	}
 
 	/* See if this console matches one we selected on the command line */
-	err = try_enable_preferred_console(newcon, true);
+	err = try_enable_preferred_console(newcon, true, force);
 
 	/* If not, try to match against the platform default(s) */
 	if (err == -ENOENT)
-		err = try_enable_preferred_console(newcon, false);
+		err = try_enable_preferred_console(newcon, false, force);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL) {
@@ -4185,8 +4173,39 @@ void register_console(struct console *newcon)
 unlock:
 	console_list_unlock();
 }
+
+/*
+ * The console driver calls this routine during kernel initialization
+ * to register the console printing procedure with printk() and to
+ * print any messages that were printed by the kernel before the
+ * console driver was initialized.
+ *
+ * This can happen pretty early during the boot process (because of
+ * early_printk) - sometimes before setup_arch() completes - be careful
+ * of what kernel features are used - they may not be initialised yet.
+ *
+ * There are two types of consoles - bootconsoles (early_printk) and
+ * "real" consoles (everything which is not a bootconsole) which are
+ * handled differently.
+ *  - Any number of bootconsoles can be registered at any time.
+ *  - As soon as a "real" console is registered, all bootconsoles
+ *    will be unregistered automatically.
+ *  - Once a "real" console is registered, any attempt to register a
+ *    bootconsoles will be rejected
+ */
+void register_console(struct console *newcon)
+{
+	__register_console(newcon, false);
+}
 EXPORT_SYMBOL(register_console);
 
+
+void register_console_force(struct console *newcon)
+{
+	__register_console(newcon, true);
+}
+EXPORT_SYMBOL(register_console_force);
+
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {

-- 
2.52.0


