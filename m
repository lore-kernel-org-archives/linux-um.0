Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE89BE9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=; b=dIKdsOQ5zwp2cMJP+oOnO6ctfm
	Te3Op6DBvCvxIuqP9H8gxWrEVtMy7yJ0s1Qpja4JG6UGHVr/Wcw7OXhCoWZsQ2HJOeK5PQv5FvVz6
	HPYtZ7pNzD4A86s6J99aAIm0ESAXNNpcTRyvO07pun0pJ3lssUeNmFhLd2PazQwkBOcTD2Md2r1Dy
	pGIywOvBPDaIbqm33AcNIp/KgByGlGmUSyM2flElEpB0zuL++DGRpoDBuG84/7t6iFXfNpDOKtQvH
	qA5j9I2sVg1C/ZkolsyqwOew8ADiURRd5K0WDdL25qp8hF7MNAb1Bj+XRQnDnN0GdkkFgLz4eklj1
	WgVt4oeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFP-00000001wBs-2JS3;
	Sat, 27 Dec 2025 12:18:15 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTFM-00000001w8S-44t7
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:18:14 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-47774d3536dso61935655e9.0
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837891; x=1767442691; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=JYUIaHeN3+2enAoVIrPzMIDUI2EHShJqex4nD1ETsa/FUhiSPSc5hviSTy+S4KofLZ
         9BSQTaHYr0UnxQMralZA8bbimmn24bs15i86S3ddN0Hqs/rHkidQ/h5Mr3Tilhhw/CRi
         CDnj7QzJ71IDhwwQ/hvFyJC6KJG9LijuMxJk1wEE/KSJAYKK4RxBlExjKqD8GFIg5zik
         3NlK5aGltk2Sr2VGl+rGF5XwhBHOYFne5V+jy6f5eJbOAyFZCMSGhy4djgSj7bUInehO
         fWrQrmDKTf1MMBThRgYWUI7v93ql/wWLZVsDCe3WVIMxER1g5/UdQx+e9SE+5fkwcqDG
         gUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837891; x=1767442691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=C5dWfLSsasIc4skoUDLS6X0uWjuSnNRA15XRoCGgLUq1kqqi69r9wdPaVWIvNqwaCw
         pPrKcOFnPcV+Rw6VHJvS9YuBhs3nuujhjutzzOVL6G+0aKj0bOppEgdRnF8O8sbmHZ5F
         V+KXcwxlXYwovUvt9WTmOKdsHLobAlc6VghV4btGuOA6K6YPdNSHwOitrorqLj71i1qx
         2GTh5JyQKAO3B+/jXTHvuE6Zwq2SgKbbosZGKWDavJr93/A4wsqCQhIkY4BxiADyGxh/
         GOlVRKu49CYKETf1oshQFYjGcL6eCzK9suLfPMje5n09m+UlPI7uxFU/KWrquw0tO82y
         5PPQ==
X-Gm-Message-State: AOJu0Yylja1D+vhqOzJDRTV2VX1DzOCd4m5+Lx3zA7GJyVJ9a5nUWaVt
	fbcs17CjxdS2cowlwlQtYeP71U7NfM0etP935ODticwG0ankC3NBkR1DY3nsfS9Rl44=
X-Gm-Gg: AY/fxX59O23XpIvHqvWWeLg1VdhK7xi8vexJRHbbFogjnB0XGnKMVBwaVtvBzjGd3DJ
	MAI+gcWHwJp5rfK2OZup2rFO4fwp3uf/fllhSExGESldvfVn6O597Ih9DyrjedaMN3CgudqNOqY
	yBMu+4xRczrb+I+zAjempgy4aDfvIlP75+Ss49xXFhf0GbBkvOyD4WJkaQrDJpbaOQFgrdbLUXK
	QlP0C8VPCuFYlzFYYWpbwjMytzZRyJRZQjeIOz5HEMkspzfGbIwBoVsLKXdAc6A/XGFjumnwHx+
	0IRamnAOLxiH5PQwlwShhpR9vnLn2V7+hn63yz0ICBTohjqWGChCM7EVomUHQpE5h35WGoajELA
	7vAx9tYBy3fMggXMWMXDcUxHe3pfc7CH5MG1WmpVMFmsOVPglMIM5qmv59e+3YZMkzYReWXHz6Y
	5lgBvCYFV7
X-Google-Smtp-Source: AGHT+IFJeR5Bq3e314KIMXwkrZhqd3SM0Gtgef2ZKhyuTvMEsyAQgTg0idlkENoTE/A1RwLAaI6A4g==
X-Received: by 2002:a05:600c:a30f:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-47d52efc7bdmr6320155e9.1.1766837890917;
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:16 -0300
Subject: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=997;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
 b=bFiYD37gtcultSa+DtuWsZDZsqldtTEWNQGlnO3f8qpUTnHo9LyYg6/jnVTrFnBYz5Wno6rCP
 MIg9mT6KNXdApenqW2Pg83sbMRC0cE454dAXf3m0peqNYruoithEiNk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041813_033446_998A82BD 
X-CRM114-Status: GOOD (  11.09  )
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
 arch/m68k/emu/nfcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index d41260672e24..3504bbb4aedc 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -110,10 +110,9 @@ static int __init nf_debug_setup(char *arg)
 		/*
 		 * The console will be enabled when debug=nfcon is specified
 		 * as a kernel parameter. Since this is a non-standard way
-		 * of enabling consoles, it must be explicitly enabled.
+		 * of enabling consoles, it must be explicitly forced.
 		 */
-		nf_console.flags |= CON_ENABLED;
-		register_console(&nf_console);
+		register_console_force(&nf_console);
 	}
 
 	return 0;

-- 
2.52.0


