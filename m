Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C4FD41178
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=; b=lNHeD12S9kLsFp1tI2K6eKGsMJ
	ag5nn64FaYN/X9E9k8CEEyM2vSvOwCfIvPLCK23cm7rwSTapBAK4CQqH4siBi48mjey+XGoPx1EDi
	raGBdi50Sbv4pN6F1D8AXEcU8ZUVmgdFcfqg8heanumXgu/8VO7TNKZeacVIyAzTNIHxMEX2WfeSd
	8W3QhbBlq1LoWwUTD7nXIPtiwYrANKQ0edr/MiJPsAKTh3tlexs7QtOMzWJsAY8tzvxJ63D8EGK+4
	XuvNDxpjPyBJavALqyt/HTr1hqBhrF39XVSJYVQ+1wHBuGBKKpC5fQutwjEhOS/o0gZhbOq+iu0Oy
	w7NnEnzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMDu-0000000CJ8T-1oeF;
	Thu, 15 Jan 2026 12:13:10 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMDs-0000000CJ7p-0eg1
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 12:13:09 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so8260475e9.2
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479186; x=1769083986; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=Dlc7o3DERXKmZkKeGLUyBYItd7k/sNcREZhPcVV74osH6HPlkOYkQMCQhtb+hhXh5C
         rgHdCFqkLvphf6yJUS2VOIAOC0ClQtTQhoWR+mvvNoNy8alOwELWThoObDING6Pc9Kpi
         Plf2bHPMwlJi+OcNAZ6K0NQb+/cPWK/NgdAsrmMJ3fFowOUhvPSUpmwfU7fxgT9Uy1Be
         F7A7dTPh0vI6vsXDVGDfm4ASsGWX32KoclyczObxXH4jZACIAEvP2a6vqQVA5pC0qiUt
         zEqCgzQfBp4gq0ZhTHxZCvYcmGT6l35FGug4xUouteInjR4qlno0YAkXmZhweHmZ/PQN
         zKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479186; x=1769083986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=LhPuM6pn+qjQcKxaKUYRilVEzb+GxtbWfztfnmiuqGQjZjG5GHQHgnMBERTdxOey3G
         1b1Q12u4FA0hDhK6iXMquqW3bNymug4UvpMtBWrXYMutPUOH0nZrTrG6kIa6SEuMjQJa
         qmYGdQhLpHMBwIypOqMGDKs0kZv7Cs3CUDWnuJsbK215XjGVDLpPFLYa2KyxUAT0+M7O
         L/jNvu26HaOPDGjURSXxG5rY+p9wejQeJQkuU5FBqm+jhP1pM1FRUfRjQSCOsZ6wWqiJ
         LGvh39Pf5wnxbPsEw2FIb3UHjYL0htYRNdAFlG8tY582f13u1kWeVKuMf92EovP2nMX8
         1RPg==
X-Forwarded-Encrypted: i=1; AJvYcCXUobe0pXvftRQ9E0iLSJ6YUqGYAPrKiRsPpnvx0bQyLMODjdfX+Lo0hcE/ARhzVIm6//pUO4vYCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm5QDPigV5DCkYUtFeoBN3fSZz3jIv9tISmzmo6S/dfzgMonF/
	shtPNteYV3HjFKuMvBziW2LJv1Bb2C4+9gkhZnwmgJwB66Yd7/H8lbp8hC9RO/zweMM=
X-Gm-Gg: AY/fxX6Y6orw//ZOPVXEsHrQDU0C2cGAAkzUWcPab+7GMytZ5rB7RVjF1UMUeZB0D64
	ewWhIY8aJh2n4kbdmryktPgvwr+AhVtpG3yElQd9q8kVJwBhcRkrkJuEgcGeNqxt1At5wdNPgck
	DG/s0JO2Uo7Yjr0NJQP6G6Dax1OzLfNwLtQKVFNC3dAMY+ztLaXmshessX5E64Rk1ywzHQJ3F5X
	OID+mLa5nKZ1FIq56m5zMeSFLkYhY3s9q7hQNlKBKrfeo019NDi+IuTk578V0+tBuMxgWuq3fHQ
	QR8TfEMUMUE4Rkr2QvIcsu4T0kDoS3J0MHDojxA0Cw4X+++iLHvzxPdcBrLJv4YGxBa3ctw2ERy
	/0s7+SZ0j7N2YNJpZar+8zCG11jBImyuv6BDrgi71Y/zKDxLTCNQypka5dCSUYo4mlPBSOui8kf
	uy2PG9xS4kXBSNHA==
X-Received: by 2002:a05:600c:1c20:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-47ee712ac96mr42613125e9.31.1768479186231;
        Thu, 15 Jan 2026 04:13:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801bc3e57fsm22590935e9.5.2026.01.15.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:13:05 -0800 (PST)
Date: Thu, 15 Jan 2026 13:13:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/19] powerpc: kernel: udbg: Migrate to
 register_console_force helper
Message-ID: <aWjZzuY31bg95jiy@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_041308_238894_4E21EA83 
X-CRM114-Status: UNSURE (   8.37  )
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

On Sat 2025-12-27 09:16:18, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

