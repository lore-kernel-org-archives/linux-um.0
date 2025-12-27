Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD745E9270E
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=; b=zIap2ARLvY00Kkg4VWtJiTutdr
	e+5w7PCKWIKyLwlRFPkKtyhf+bRQNGuBrc/EyfzPV6Tu/6cy+4AlI1T7MVt1feJ23Q5V5kDgAK9KE
	/QWmF8dKixwAe176ccLf+vB8TJlB9hR6tLBx95OoHKhJCj3yU9ZBCRjnF7Y+NWja60PlvQ0psTd4n
	mP8jWCjBDDO9ZXipgzyESdD4IbFr3oBEaqGpAcuMpeuMplDJmFTJHIHfyaz9xCJ0ZaWkIYBuAqkIZ
	zQ8v2Fp0SVxol2ar+fy8TASeXmR7ufIdiNRqZZ7gm2hXs53C78COF+gxFucnt1rQaE0TAPzWNJFTA
	RZiwRCFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTGA-00000001wnV-1hJp;
	Sat, 27 Dec 2025 12:19:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTG7-00000001wjW-0jmm
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:19:00 +0000
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-42fed090e5fso3657896f8f.1
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837937; x=1767442737; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=aBbgGyDQ0AzlmHNuzWPqcDHRNvMRP0a8rYXU3gPOQa+kiC88faRolT+1pBOmq8nWUL
         P2vQfJsMdPuGAcuboeqLy4VF7TqvDiS+OxprkxyB4CKNkROS/mbwF3/l7JqHfRVRQE2W
         xQNksh2cdA0kIG632NM0KVywH+mcBdRvp2csJueITWvn52qL2m/Ti+df9wqMew2JnpXT
         nyEAtzAABSa/AbX8IkCzSdP+bXSnwW3QvoSRT3SkExAD8ukLpDVaqPy0/LS50CvK67EM
         Doxy2qP/FDi6sD8VOV5181UDzzI0gfHKSh+vbIf2ewSeDQAyP71yi0TxDdTGcG35fEbe
         mP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837937; x=1767442737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=rIzxGdJSkdV6bjGTGnDKFICxJLxPghLPD5XM0/c+48TYMP6BAXwhvD27+oRBvKZJsZ
         xf23YzGDx1mQ0I9zCwAFqAEAGLRaXa/AWhh3ioGfN5WS/P6QggaWRndCy/N3bQE2Q9RZ
         /2uxt0XYgkxbo2h/Nkl6YEnI+4s1CfyxbTDvvs1h8T8DPm5rIaWJ2WO9WGQX9b3zrtFn
         NzKw4RDU2ms4znqeZdOM4ryG5xBAmvEGKlC/ZjmSDMCH1U6kI7mLWGdUh7QqOQbEjbnp
         f1uB8Bpd/KcQ6FKeNw8XSbiyFJwGX3p+Ytjgg77bQVWdYrRdl+gjYQ1vj5JuALd1nsaz
         41rQ==
X-Gm-Message-State: AOJu0Yxpf0hwPkIkGfaqbMfpyejTCAEYBN74KVIw3jLi/DRIO/QCJFbV
	av3KmJIEHTLDtbzvnCNf6zLWli8hzhsMRToT4y6jtJaUjc5EYSKcIz7LKyiPjizt40k=
X-Gm-Gg: AY/fxX5VevrfFr2V2Ff8A99cT1tUahF5bmA3AwxoW8CqMhuWxouVzCIDpndU/2lY3P8
	Tiaeh7egbXajztcr2zR0ZGBEoiI1LPwa6/+iSeWNIa3i2M5/gCwDkEdJKnVRQCksPsKECVmJBXW
	RJk/00qXefc50No517MOQ8VIdhxCCEHpzeRAB9u/CV70m/huA5THQlVK9P8Jlbx4NzFDZn60qIt
	gxe4j+K59oEgcseymEJ0+kWFyRBKiMg88gpM6+JniEacvHVqxL9oSdfhy7o7fL+eM58NZJP6A1X
	PRDdubFiI1rt+p1KQhnjYW/tIByHYxiKphgYNVlcC9bTZQjVgkFz1w0OA3at/5CRahF1ep+Yj8B
	ilTERDN45JsoKkyq/0sE21yNDFXOnXZXUwiiBGuTzYIKWYw9pP6bqSxSa1nmUyQltLBSp16oXFO
	SZCaV8mEag
X-Google-Smtp-Source: AGHT+IEilNPw9ykBXsWasfDesGg5n0pMdngWI0y9wCDnaTUFF7DpZ4wL0dzMcGNMkGv8jBn79QEjlQ==
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d1954a128mr290319795e9.13.1766837937081;
        Sat, 27 Dec 2025 04:18:57 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:56 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:21 -0300
Subject: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=940;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=go1Xoe57mzaY/mIQIq5f3pHcbzGWVFe1Pe8aCGM93yA=;
 b=2O7MS+wSbmBy5GHviNZc0eUrBGjBqbDvdZl/gWh/gmVWu32K1VqnWzIxEikovOvxtxQ1Ut5k4
 SCkXkL827NRAROp5vOzN3LiFx30TLjgXwQqt3ej5ptdr+YtakhrR7Rs
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041859_236522_DAA7387C 
X-CRM114-Status: UNSURE (   9.97  )
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

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/hwtracing/stm/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index 097a00ac43a7..d3ae633e3bf1 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -42,8 +42,8 @@ static int stm_console_link(struct stm_source_data *data)
 
 	strcpy(sc->console.name, "stm_console");
 	sc->console.write = stm_console_write;
-	sc->console.flags = CON_ENABLED | CON_PRINTBUFFER;
-	register_console(&sc->console);
+	sc->console.flags = CON_PRINTBUFFER;
+	register_console_force(&sc->console);
 
 	return 0;
 }

-- 
2.52.0


