Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D28D4115F
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=; b=NvwZGdppr73Qz4i8aN12/WkJgm
	BXKnzyP7PXBRAMNYQL7N9mXdfgmPqINR/epZyEGefUCURxyEZBonAhQyuJAOS939kkPpdIyvtfGIx
	XX13HrA8eO5PXL+pp1VKFfocLmFMfsOdPHM6q/JFkMJASlUo0ovgWUeic/Reiyw4DA9xeo987IprK
	U4iKHQLKFrJCUiPRBG8kHCe9kR21yRHZpFixVLnLROWx3+niVL48CxOWdabCic7JGHZx3xEidPo9J
	AvBRwo5eskVos5P9RSY2CoFE0a85YQA6W4gBf7bgNmCipYmZwiDAmsj/mLY9ManJtTTQlRAG7/T/6
	Ad3GJw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgKP9-0000000C8na-2qmU;
	Thu, 15 Jan 2026 10:16:39 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgKP7-0000000C8mr-3iLZ
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 10:16:39 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so2005135e9.1
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472195; x=1769076995; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=bG1GGWFCDyu4No2Nx4KquoGWzsTZcqIbRRsiMvRed6ARqy7TTiRFpb0XyhzTY8rpuT
         BWi+YjHOgrhrOJC5eq9k5GyHGzQy9YjDcsGiAK+YmbygtanGBOCnXxIHCskKH/wx5mtz
         i1q8rRk60aDcWaIX5TDH5tRSexQnAnOSmVu87zm7SWDgzGf3j/ERyk32k7VkOSmPxOkT
         iIy0t4f/+UdLc5pXzMq8tXL/2wMvrbm6XJL4JE5EBUgY36uhpcQJn1udGsjfWrUlq9nR
         PwvtLxjEV9N90UqsVOeVWlccYlFZR5q2uWpY/fB0Lr41CxEdLzJ51KIRhby8fsm0BXG8
         C98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472195; x=1769076995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=Nr6f6aDrL2umdBJgqEInFmwjj8QvCNnN5TVt6xB9Blnk090MGXe0uhculemIN0El4S
         ZZP0k2754NGbDhdgdZBYfqGRNhv6Qhu4EaCo7QNAGi59FyBLBgM/5/FDXsJfj+pnNBy9
         07iPcipuf+7YPNMCYfH1z223MQbYtZujrwG0ydfy7mReNzFmXYrb3MCdyG77f3kLjnyd
         T965pcSwtPL9Vkq0J4//nwU+cfo6KYdaqap58JicFrtca8Ia39YrjDlU4iw2lTQDp0z8
         5nviuLkQ0uAXkg3A+uh8e9mE2yjvkyfMCk5R5eLRwxZy1QDK3JY2kEsPxMtd9pEntxKs
         mf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeJd233u6gWwWIhOGHuha7SwQeQF/j54s5gb+jHKjmz2KzkN35kxK/ISW/A1bwYx3xETQxQ4TGNQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxdEdtm0i71zgrKhL1ywEpPfX58z9NQwgx7WVrCxfQHfu4Stus+
	F0p5SIurMp1lGY/mIbNjp1OaiS4E7QlQoyWDp5pf7QLgBnxTU2x6xb9p+jjwQEgm3Hg=
X-Gm-Gg: AY/fxX4tdxPbGO3+hjTpj+BPLQn23PgwqwsRKZVvYovjY9IFQFJ9VxgqpVzmof+k5iF
	H20lQFwwWXxqb4JNVXiKeeVpbblHD5H8J3CzncrOd/BUHC2uJ7c4hsnruCCOeNUEmH4WoPEAjJz
	uBXwHngk+QzUsf48EkJQLsJKLBm3ot5stNSPGstpYPbubyDVR84Ngs+jme/fte6qz4vYQAXhg3i
	kb+GdoPzBRWX6hO3echoPp1yk1TvDv9kN3d0NX9hHWBeBW32cgug+P6oH55UaGJZ0/Xl7eTTLqk
	reBEUS2GOM0yA642OjfoewrYcT4AIvOv6f90PRdKQcX2DjcMKo4POSC/gZkz6RAKvWg8J5s0La0
	Ppom69G2ZlnZm03u04WDbwpr2xhgBCCkM13x5ZGqn5thEDPVwUoI6hzIeOCi63b10ZqQtn78a/1
	03N3aUNfYAyat0NtH9A7WBw5S1
X-Received: by 2002:a05:600c:608c:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47ee32e0829mr58296485e9.2.1768472195426;
        Thu, 15 Jan 2026 02:16:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm39739585e9.11.2026.01.15.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:16:34 -0800 (PST)
Date: Thu, 15 Jan 2026 11:16:31 +0100
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
Subject: Re: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Message-ID: <aWi-f9LBJtxGWgWs@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_021637_933391_3C47E6FC 
X-CRM114-Status: UNSURE (   8.44  )
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

On Sat 2025-12-27 09:16:14, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.

I would add "No functional changes." like you did in the other
similar patches ;-)

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nice clean up!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

