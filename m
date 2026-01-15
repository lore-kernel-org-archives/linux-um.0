Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C27D4117D
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=; b=t474cXvBgNSHbJkc6mzv1xKbV4
	DnC4CYXs78TPEJ+AWvURibe381YHVIwtQjmrc7NrkO7Y/oqSpdu9duXY/eqczRU8GidPHTWStjKn6
	qnpQCXAVCaw/mICNaOwGY5XHHwvA8TP+P0iEdf3VcdtMgdF4Wc4bmQPHdxdPEPpHAfYsiTX3Z/YTe
	+TFVVquwBIY75szyqYL4BMZRQ3zG7YmFiEwW4p/9wQ/Q6xUanQHNdjIYIhdzBE+cKVcaxzFVXFNI+
	XoLWX1pAZSlKWe+c7PabtDN1/xdpa1olpOkL0tj305mmDvdmpwL+/RI4PMAPVKbM0anPhBeop2Jic
	dGDb7U3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMTx-0000000CKkG-3QVd;
	Thu, 15 Jan 2026 12:29:45 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMTu-0000000CKjU-2U2K
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 12:29:44 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so8025325e9.0
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768480181; x=1769084981; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=KVeqjiHHh54QX9uZG57LOrC463ScoL4YPVwv0NpK00H1B62FjXIT1QYfrVWY/LrCzF
         fpKiESn7E/m8Qzf3QhGfKMO8PI16hc7AWpK9OlMYwT4DYSyFOJ7q9Hq5gxCTRexS5t71
         2nWXW4gl2E4pzND5AYtZJmKXCx18BrpINw7MovVv0H3qffD/XXY7MJ+z03a10T/M3zyS
         lLtaPJqc7wX3sOboM2j/p5L/tT3xxbyV1VfGL4iwUGkNUTi8tW/ScQKPZt5mqMsYsfOg
         JyzLC94GgB4Sj2Bakua4Q8QSEekcMVEK0/JLElIBJmOkctCH8XQQqpUUF/R/cPNbQLsU
         zZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480181; x=1769084981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=HZxGsmJM8rjw8vQdsGSHRfzfBQokAWafa92YKyMkSbYNfGLjCiw11OCGAPcW31jJYE
         BlWj9Ep7GefYAVAPfiwAOKAWF1L8cNMbd1FkEA2w8UXcsqSwsq5R3XtRcuye9lANhado
         JTgk8CUmWHtwzD2XvgjQBRl4Bh78NIg0q/yR2vQci+CF8MjtGW52QkOf/eX9GPnCokMa
         cNJbrhaiCZDMtMLDtBqNnBAJCEqWNfpz8cOU7jfgCIzzRaaDLtwk0k/e/Xkh2uFgV2MM
         9iGWL4efikUp8syv4T3lOV2R8chaNogPdD5GvqdNAn+/kM3D2koXqu4qUqjmPA5HryoD
         CSXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYV9ukIndcAs4lf5MhpH96eA+wVt8DukeqRqTIuCvTbvdg9SBZPVSGrF7uHZUKchlqPME5s5Fcw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7xHC46j7ud1OVMBD8LulpSi/FnIGeXN8vpPN/ge6Y3sgIoR/D
	+ucPsWstNzb+TZPuU9YHl+8geY3PXImbvfmjtOAEs5Xuh1Hj7Vh0861OzqFMKm6p4nc=
X-Gm-Gg: AY/fxX7gBnHnLd0Woh8N6CXHKZ1qr3Ovyvm9y9X8a7GMLq91PsOe3UWf/cTBebdUP8O
	yOuLbI7yoHlJIscvpG6ELqHRgdNlMbZoeKz3pT7rJJTXFtYYIoPqhTm8y/e9ddn/JlHL45yH4JK
	z+kKjHR55G8eB5JUwSGoCPv+UZe/uqrgGGkQ3hTvsu6MWVxGVIqi3jvbWcnKm2RBCbd3D8DXqDC
	K62xHpJni3S8pvtn3qCZei2ZmwZRwHt3MPTmH9uftKrqHI1XxWT4+jiZTVx6sSahuM6yn5qBwL3
	O3MPJNBc4jhL+trsTr9zEgA6DmaokAGnsvI7kkS0OX/b4XMtPgU3PTI/UMRjbPmIgFj1rNvZugL
	5AJ4tLpDtdoc3yomp868aZPv0gRAmf+rQK7pKqNwD9EcJZBF9T+ZjtZ1k3Flc1uEoKdTkPcGtI3
	PSquRjldlWK9f80g==
X-Received: by 2002:a05:6000:420a:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-434ce7324b4mr3823468f8f.4.1768480180633;
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653576sm5965022f8f.17.2026.01.15.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:29:37 +0100
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
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Message-ID: <aWjdsbYev_5zfKEC@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_042942_675703_86E195E0 
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

On Sat 2025-12-27 09:16:21, Marcos Paulo de Souza wrote:
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

