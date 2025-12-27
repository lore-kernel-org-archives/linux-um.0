Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1015E8FDD8
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xV/54pzRS8Etay7a+DmZn75b0ho6rdI/NPswC/OMCoI=; b=dnLFyh5UusIRBeeMSvSs4QUQdk
	2aTnlsb+QFVgSsg1mDNNx6TUW60D4PN4P22FTUBeyNsCe8uZKxlT9k4Jkd/CXL9hzxRnWZDjnOOsr
	3y0fpX+q4BdD7rmY7+Ss9BOrxr0zTHF57R1Efn6YQtTYkchg+gXVovitT05EZYcEP0V+ZBGsmhvni
	Xb/Tx7QM3UaGDcAEAhx5toExje68h2kZdFriB5/7eaEUjzPaBJZAeZlD9ATR784WaZA94svJ6mNkn
	ZyKeuEkmf9gsPaGMyrVmuJwWvY3TF4oMDbeo/PGSb60rSYndDWFCYW2+iOcoqx+eiMT0Li2lKWZE0
	e/Wz0aQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTH2-00000001xfD-1W9m;
	Sat, 27 Dec 2025 12:19:56 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGr-00000001xVK-15Bl
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:54 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so39309395e9.2
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837983; x=1767442783; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV/54pzRS8Etay7a+DmZn75b0ho6rdI/NPswC/OMCoI=;
        b=f2dKhRV6NeOaH3NKiPnXHufM6cwLuNuNwBZwlLcaxLMKtYThjAxR+TgwPjc6Vnkyle
         UuvaOuvSRs/NbB7O/6/eL1QOx/OTE1tO/l8vq+57hfct436nywqzvNil2NZU7ek1Wld6
         IKvLucg1YGIXhRv1IJaFzIRanc9j9+8odm9zu8m5Iq/weMnK4vtHZpHF2dHKBI7lxw2h
         Z9USnSBia5aHPNM39yOnVaid7vZ4/ZpxQeueeQU/wfvT+r+ojPT8kgvPzFF8SNF8sTye
         Z7L4DzA5uBW2Lgm6IQpZVyNsotOXtQy6nH6d5vgyfOJKjLX+2X6EzlT94DvzVD3HX5uB
         1wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837983; x=1767442783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xV/54pzRS8Etay7a+DmZn75b0ho6rdI/NPswC/OMCoI=;
        b=tKiOd/vMkLAxE2FYfdcPNYrcGd72UCKVoGqh+JdgENPYh/09tdtpSBeNhHqNnNszVX
         1Jb0M0vtbKD8PMMSoALXey+srxC35V18XibCDKcGQsqWGb3T9knPuXZDi1l+/SS+4Xex
         W9gHj7k05RRhFy1LrlSDSxr0tgziJ+8hL7mKGdQAz7R93pb2Yy27ajc6bimE9Gn+epq5
         pWOVwxtB+yvSddgSGwnHWGqeI/k282kIlvf4mxUwJvQqAuTajyX5F3p8JMSeXQLzsohS
         EkQN9Kp7kZ62CEB2xuJvlPFmw20HmgoISThV2Nrijmyu+6BfRFlryo5qnIh41AVVIbkj
         k6fQ==
X-Gm-Message-State: AOJu0YxncY5B4AV3DVdxCrLqiBxOtlkZPdGcrJyzH2bzQc8IeD1iyCzP
	EAdHZxm3BLRmDvvon0914LIRU43DEZuxRHLmMCXQ5kQYEPBflLfhKll6E9kFYAIC/4s=
X-Gm-Gg: AY/fxX4Hq4tF7oL80dYSW+QU0au7b16HMgJJVnu4Yp4VCFJEvwwwp2/jA6oV6OoBeFB
	TuPkEpI+Sxo/wIx3b9k58OeSSAH804V4cmyRG3CSY+RY4ufCMWh0e1UtFK0umcR/4PVitqA0yNY
	2VP0RWXEHkVvQk6u/E+R5iBxhNAJj6oeyyI52ADzGOIzhXburJmfV4g3Vg3l0FW8STl2KZcDbpD
	sx+FBaTmvDFtG1dDTtsMkHqn1RQzqKd4kluFBEzB2xPgKJJ6p87iIXdO5Nqa9uvh2fbkEX7yKLE
	UgKUBGIGoq7rpRwQifzeEMLmuiV31UJsxlUemScw5O+KQZhgjLGcIE9JQPLMVt8Bq3ewTfKn1mW
	qTysrwEwPRq+4xMa0zbzREmC1EcBP4flsrGvfbdIwPtpkTT9ryrwB7rAOxAGrDD2I9nIoqdao7r
	7F7pzu/Df+w6TAOAwMM0c=
X-Google-Smtp-Source: AGHT+IH8iMWTGKOo0ODMODi1rEzmJGgWpFcndwFU+BLf6Q6Oiy3SLl7fhkZeY72om2wNWMGGrFeTWQ==
X-Received: by 2002:a05:600d:8:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-47d1c13fcfdmr225764485e9.4.1766837983269;
        Sat, 27 Dec 2025 04:19:43 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:42 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:26 -0300
Subject: [PATCH 19/19] printk: Remove CON_ENABLED flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-19-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5342;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=jfxXivsE45EkgkvCbI8I2BEVFtLSwL83e0mmBVPuH+w=;
 b=L4bmhgBbhK4MabaljXOFYoWoPA/F2Ms1Hw5KRZJ0wiLbS51oCxDTE2j2nmUG21whYB1lNSvfW
 KXB3PChlBf2AMEmTwaAmskLdw1SadRBF3zXvV826sJWL27JOeadfagz
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041945_392903_8D8EC420 
X-CRM114-Status: GOOD (  18.42  )
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

All remaining usages of CON_ENABLED were removed from console drivers
that were being registered without being specified on boot using console=
argument.

The usefulness of the flag was questionable since at first it meant that
the console was ready to print records. Later on, console drivers started
to set the flag when registering the console to make sure that the
console would be registered even without being specified by a kernel
argument.

With the inclusion a global state for system wide suspend/resume
in place, with console_{suspend,resume} handling CON_SUSPEND, and with
console_is_usable helper being more used, the CON_ENABLED flag can be
safely removed.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/proc/consoles.c      |  1 -
 include/linux/console.h | 27 ++++++++++-----------------
 kernel/printk/printk.c  | 15 ++-------------
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index b7cab1ad990d..b6916ed7957b 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -18,7 +18,6 @@ static int show_console_dev(struct seq_file *m, void *v)
 		short flag;
 		char name;
 	} con_flags[] = {
-		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
 		{ CON_NBCON,		'N' },
diff --git a/include/linux/console.h b/include/linux/console.h
index 7d374a29a625..0ab02f7ba307 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -164,9 +164,6 @@ static inline void con_debug_leave(void) { }
  *			consoles or read by userspace via syslog() syscall.
  * @CON_CONSDEV:	Indicates that the console driver is backing
  *			/dev/console.
- * @CON_ENABLED:	Indicates if a console is allowed to print records. If
- *			false, the console also will not advance to later
- *			records.
  * @CON_BOOT:		Marks the console driver as early console driver which
  *			is used during boot before the real driver becomes
  *			available. It will be automatically unregistered
@@ -192,14 +189,13 @@ static inline void con_debug_leave(void) { }
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
 	CON_CONSDEV		= BIT(1),
-	CON_ENABLED		= BIT(2),
-	CON_BOOT		= BIT(3),
-	CON_ANYTIME		= BIT(4),
-	CON_BRL			= BIT(5),
-	CON_EXTENDED		= BIT(6),
-	CON_SUSPENDED		= BIT(7),
-	CON_NBCON		= BIT(8),
-	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
+	CON_BOOT		= BIT(2),
+	CON_ANYTIME		= BIT(3),
+	CON_BRL			= BIT(4),
+	CON_EXTENDED		= BIT(5),
+	CON_SUSPENDED		= BIT(6),
+	CON_NBCON		= BIT(7),
+	CON_NBCON_ATOMIC_UNSAFE	= BIT(8),
 };
 
 /**
@@ -522,9 +518,9 @@ extern bool consoles_suspended;
  *
  * Requires console_srcu_read_lock to be held, which implies that @con might
  * be a registered console. The purpose of holding console_srcu_read_lock is
- * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
- * and that no exit/cleanup routines will run if the console is currently
- * undergoing unregistration.
+ * to guarantee that the console state is valid (CON_SUSPENDED) and that no
+ * exit/cleanup routines will run if the console is currently undergoing
+ * unregistration.
  *
  * If the caller is holding the console_list_lock or it is _certain_ that
  * @con is not and will not become registered, the caller may read
@@ -706,9 +702,6 @@ static inline bool __console_is_usable(struct console *con, short flags,
 	if (all_suspended)
 		return false;
 
-	if (!(flags & CON_ENABLED))
-		return false;
-
 	if ((flags & CON_SUSPENDED))
 		return false;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c5c05e4d0a67..9cb0911997e5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3890,21 +3890,17 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (err)
 				return err;
 		}
-		newcon->flags |= CON_ENABLED;
 		if (i == preferred_console)
 			newcon->flags |= CON_CONSDEV;
 		return 0;
 	}
 
-	if (force)
-		newcon->flags |= CON_ENABLED;
-
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
+	if (force && c->user_specified == user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -3919,8 +3915,6 @@ static void try_enable_default_console(struct console *newcon)
 	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
-	newcon->flags |= CON_ENABLED;
-
 	if (newcon->device)
 		newcon->flags |= CON_CONSDEV;
 }
@@ -3977,10 +3971,8 @@ static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 				for_each_console(con) {
 					u64 seq;
 
-					if (!(con->flags & CON_BOOT) ||
-					    !(con->flags & CON_ENABLED)) {
+					if (!(con->flags & CON_BOOT))
 						continue;
-					}
 
 					if (con->flags & CON_NBCON)
 						seq = nbcon_seq_read(con);
@@ -4233,9 +4225,6 @@ static int unregister_console_locked(struct console *console)
 				     consoles_suspended, NBCON_USE_ATOMIC))
 		__pr_flush(console, 1000, true);
 
-	/* Disable it unconditionally */
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
-
 	if (res < 0)
 		return res;
 

-- 
2.52.0


