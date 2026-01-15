Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3437DD4115E
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=; b=kY5MJ1RcskPsXxhcDyuuJH0czR
	uD+L92+l/cOV2JmVfjUzDCrG/5e7fvJo1DROgZzSPlJm3nZyDibnIt5cX4SMWZYDBDwHY3hJ+7Ezv
	6RsNSCVm+n9bFV1vBiETvFvDsXUAsPFu+HKrGyKian729mW6f//f7HOnhcyit1ouwXnb2b+wU5Vs0
	RyqioMpRr7GkIjrhduV7sugRorw3BCrbAgVNfYeoxv5R5JSGFEHe/jlJXJr2jurGfYWzlcaThIheI
	KUDoPXPrx/cfu1jMSrYocLW0U/i2oDQZGgIunt12B8ioQ9/Zh2IlLbyBQPJ+Y2ZCoJ40xqlLX5DDZ
	fD6HnVvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgKSW-0000000C92b-1F0M;
	Thu, 15 Jan 2026 10:20:08 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgKST-0000000C90r-3m7w
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 10:20:07 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-42fb2314f52so347534f8f.0
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=UFMIHyzm/mf800Jak0zNRj0vP6X0MI0TFuKqT01CTbC6+Xx5GYUy2f9JphAbXSZLYB
         7NVwoXj+kOM6UlfXWmuNqnuhxUS9oPCq8bt79RTFCL92q+BPWFj7S67ogv4QQ52EDM9B
         TiF39Jiel2uT296nK6GMYcPBkgnXtEgxKX4GXBggd2Eq8z3icgurBaUdzQ4EQGYw+PYN
         g19657coTDLDyc3ElfG9JQ0fyi6ZbyGfkNCbkqSpN3JIZ8NzhB4Bv75uLhPUVm1g70Zk
         zB00NLej72oHt8s4GmqGjNM40RRmlIZHifp5PqEX/P1KY3ZApHhIqYuOtkicGkrKPrHs
         5drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=pWKtiF840wNxNUo/tHtcWotcWfzPImfpXuzH4PJ+Rly9qYEPYp3OD7KlBeCDAw7qfO
         xybh8FkCaziqWDWbcNAGKxlUpZEmdqGaVXZUQmQB9eXFZemq50/CoI7m54UOF0kxYF2V
         n/XQbCg3dgrzPXl0ly0BmCng0QqurtxEJ5YlNRna4iTUJCTe7gnnBITq1uEWojbFZTMG
         hgN5xJXOcDdxEchsT+c3P7gKc88UqDAc5pOPd1k7014nnohSCUCNpivJGdi8aLZyb/xE
         CAJ3Y/MOUGPX6/FpL3nCLltZURLisM0oHsKVWvlQcvhYU0q6wpeN+LPBDzwlkm0nNN8L
         PnjA==
X-Forwarded-Encrypted: i=1; AJvYcCWoBfeSlR9qXfhdueoOhXxNxiAbNuhokH5Sd6pTp5jG+JgxbnMGzr1RFu/DBiddv+N0uewC9JJOPw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3igBqGk3zRn84BQoVqWDGJY95pcd6dbGdfLqS37cM41DbfUs5
	6cavddpfGficZYrgXowfjBVO/4LM6w7/cepuO0aHC7gLlL0uPen2IfglfffMXvJjA/k=
X-Gm-Gg: AY/fxX7dYSdUnuivT8AaljzjnIafeqdNzyCpXYOFBb3q/QDZHkV6RoxdO5hnHUbquu9
	ie2ZcKZo3RWNYhc17go0m0fogL8DXXFqu1BW6ha696J8Q9b55wPRJcKTazcIm6A5sBDg0YQdGWw
	w00DOoWRhq1nvfMBhV34uvPetFtPBB6EasovkYz9cQYK4QQ/8QLZUcBi2M68nCxe/z2OTCbACVy
	FQ435w3nJyctPvSnZVRrtqgfqMLRmZdCWjZJdhSW2TkFzTOJEWhbtxFUMLFjOEk1Pa3AzOZOBNd
	i7HECDlRXy2fV7DG7kCHsBxoQlH3wvgcZvrVMsTmjmGSCX2v/08IdPtWM3PFmkXn6ioRVyC31VD
	BUG4G5/E+/Um9e/vMJRhoFjecO9NVjNmVPfanuewWYyyTiYLdXVjpQSJhPvoAAobKYCiIFgxAaE
	uDae5B4j3RanK0hw==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_022005_959975_75B99F82 
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

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
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

