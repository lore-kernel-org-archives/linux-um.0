Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F71E9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=; b=MrLRjm2DrGtpE1gD/XWOy9HSvt
	yUUDiYwAbECQuXeF5pyLR4hx2aSdeKH67sb1GHAQseq8hXdd7pyLbkWlVrq4IoBpTP7m12kwPWhra
	7G+rdIZfCIBMiKKCZua2z1sKf4u94M273DVaaDCQCJvlv4drTcgUWpboApulvXiXIMIvnQcaNvB3v
	RLAtQGVKxfG1ML0QSa6xuqjd0llm2gpQ+1N/5qE/3hyxA8Y+1IKBxWPBseVxZ4nrO1xoLrbYNT187
	6KsWDdzI5c1N6ryRS+VW5Rs7GIAKXZ9htwhUNcav7LPwmYqVt8gu7RcRSfHhBwx5/eiZ29vUno67A
	6cbai47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGf-00000001xLp-3YFA;
	Sat, 27 Dec 2025 12:19:33 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGY-00000001xEW-3il6
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:31 +0000
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso75775765e9.3
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837965; x=1767442765; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=Gsi4hHIxSeeXRXdAdUauoIUF/6d0J/pjNaySRXVyh7SekWI8bUuN7+YTe6GK/2Isda
         T7jsBKJcAyNtcB4ppS17NnTU4ncS0DKpYkUnufwmIUw0fEdm0yWZfJsjiWpGPzysWSJW
         l4DUajKseMZgvRFmxNoC48z4AKdWBxMtLI/ui/LF7rcxYAGRTd+vXra6lP84EYPHijeI
         MwrzY31JHhp3835BAwMNUtyy1fXtuuH9keN1lhcSHTVPLV+1t2Vrbrs72qiyY8Hw0cJB
         AdOlvVrV9CU2ab+qk3bcCFPRNIyVQoDLzBzM3PfPPUh0gdxaxqHEF0e7ztjvOWB1mxDu
         rWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837965; x=1767442765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=WZkvXtYvOxV8m72Qc9q9NoS5/YxZpOixgEfZKA/tHlQuvZc7ND72lZFHvek1fhkWyJ
         CdzHJHknpEjyS3xifNlJw/GkdFl2QYJLvCXYj8H9V2lx9msbzq5XIMrKmTQsVw7p1T5p
         gc7zxXVEXP0tx9PipBxhhH4TYRbVKJ1jnuqJb8k9UEp9YKs+YgknCcr/nnGNXYjTKteo
         EQa+recJ4IVx14wfd2LzrzJu3zkHpUwsdZxM9UdMr85HMtxmxCVmWjU83bTIGcrP4H35
         8NSsui/1tJI1FlC0UuA0WDFpOyVxahtVe0NWzZYjRakUjzW049bZ+LK9YeSKUmsS8KNI
         ZWkw==
X-Gm-Message-State: AOJu0YweFaLuTUxUjbFgwwt2HhGsCQ/EYeLAfL4QLfUSI6F46bwN8AKV
	Ie6WMn2LuL4eLg1InV79WNNjzSpa7B8BjtZAweTDARxrtAJkDsztojD8A7ZWtRyFybE=
X-Gm-Gg: AY/fxX4HaCTfza3MK2sqyEiFHyV3x496Jyq2dAA0GzejQUK9n388XWDK+59kuVdul+a
	au74kAO/KmWgeOZPF65hFqKoIOpVeLPu9L+LyklnKHTJA/iawuS+gPmobaxGp2jqLPIFJjp5YDA
	WVRVCW23RyaMf/ffCCrWk3KSsHdwXd33yayHXWZfPsoDpwGDBEpFj+dr5BpxDJOqGpWUyEAPzzz
	ilLuXSqFvhb9iewGm84WfiiHqgg4P7c/1XV7zW9ADNT1lE9wx4nhENsj4+xJweAJ9Np9FKmPJzL
	wW17OXunvHxemYWyeH4aJ27TMKO7ygHeHkRz/qdHnY1hh2W9DP/VOoAmIrOguPNrU9npDXcUhrB
	y1O4iEE8vVrm/GJ9kg3qZTguRo/SjaP+d4thOYVs0jJaFOGyvSuPK1JzukUsLJ89o95Dg+ZLNs9
	jOsnfhpKdI
X-Google-Smtp-Source: AGHT+IEqqHc/Rd2kLfHagj9YhzIrZRGfzwvOOoeUxY4FRXLnI0VACA/N9sgft7uDx22VCc1m3UDX7g==
X-Received: by 2002:a05:600c:190f:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47d195a72fbmr289900545e9.22.1766837964788;
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:24 -0300
Subject: [PATCH 17/19] drivers: tty: ehv_bytechan: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-17-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1183;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ipo1oJr6oF51GaJ/ypmHdNm6pxSai2H+L3ksWdFz4YE=;
 b=BCXQlMZHiSgf9aACQxFpdYHusJFHrRGAPtAecEP+JmKnj9nHT6kdi2m955mQdUkj992asxAcQ
 YxGwDMjxOJdD2wCUfBrHw1pcuZeGNuCZOOekwLuy8OjtGsDgBHGc3PP
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041926_953926_5164A095 
X-CRM114-Status: GOOD (  11.16  )
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

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/ehv_bytechan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 69508d7a4135..a2aab48d11ae 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -299,7 +299,7 @@ static struct console ehv_bc_console = {
 	.name		= "ttyEHV",
 	.write		= ehv_bc_console_write,
 	.device		= ehv_bc_console_device,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 };
 
 /*
@@ -331,7 +331,7 @@ static int __init ehv_bc_console_init(void)
 	   byte channels here, either, since we only care about one. */
 
 	add_preferred_console(ehv_bc_console.name, ehv_bc_console.index, NULL);
-	register_console(&ehv_bc_console);
+	register_console_force(&ehv_bc_console);
 
 	pr_info("ehv-bc: registered console driver for byte channel %u\n",
 		stdout_bc);

-- 
2.52.0


