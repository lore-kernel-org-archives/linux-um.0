Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65052D2F349
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=; b=xamZKZ8eSCVsHCLSzOy6FARBlW
	xbyBcA77yPrNRViQHla8DQOJmMDIakOgrORW5fBnqYonJDiH16C6t8htLrxAYVObHg+GDvNTSmNi1
	ws+didHjJqjcntl9ZBBl8HKLYhIr1qMy2c/EFRgB0qw6Wgp/3ntGLg+zSWu2dfE54bPmlBSGz1FEi
	N/2AFy16FTTvbtCDovwYQsTlkfdSG49l/Xt2iodZt6jrjelfw63qxHAFYM79aLx96W8g+3Wy4yDB6
	QfIecVJRjVNAQYMl5u4kKOZES2AZ4Ti2UfrrnQvmDKHN91U7uqOGrynFZt/F90s5uYG2Pq3pEBqFW
	MYv0iZDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfiKa-00000007Xfk-2zZf;
	Tue, 13 Jan 2026 17:37:24 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfiKY-00000007Xeg-1M4T
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 17:37:23 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so3739910f8f.3
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768325840; x=1768930640; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=RI06ZjcUx2YgRorbLPOXIHkMJV7NvKIDeapH0PXsXWGP3eMuP7Y5jNic434/mVF9w/
         Uss3hnZZlE+8HCBjbHgyuvmnu7b9lgnvFTqlgQjs2aFVRjelsabhvX/+KRo7OrXU2tkv
         7i7/NKxX/CPUjIsAvUNoeOHQO5K1HLUd1xmWor9o93OMk9Wi1kS00vLq7f8meA0xMgwJ
         +4Jzw2w1W1O0OY2lTlbe7ByPIBTn540eQwOHGkMBm3WcVpZkAdWCE7ISNLPr0ljAfiSt
         l8DFLROXSZ9OGErfxpIb3trC+WGD/6dTel4eTzQTyBQ0m0kYm7GPHbpW1CH2AdWDVzXt
         blJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325840; x=1768930640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=wyw7TL1qnKMtHSeh0aEodc+InyXotQnkIAecXui5ReRfx1wmcILOD+nIeezX3HR/Iy
         IG2z6TRpl2sMG5GntbGFc8EhEm8JhJg3n/iGSdec4tmi3VwtQImBW2Ox3TpvT3udvawA
         ezat+t2ubxO46NFVo3Dpsg5FGyMCPT/LTYQ/f2ks0iFxDlaRqE5Hyt8SD+uO3EGaFqdj
         eF9xg7faVMiPrKl9sH4UQzAMV6OzsggYXia3kssevBtQjmP2pS/jDjBfmRSInSgYoOg+
         jHJXXp5c1yo10gxg9rMA5C8EYJRI8Iq21OrtZ2puinBBiBWtcm+RF62YIX4rWyGf2kg9
         r91w==
X-Forwarded-Encrypted: i=1; AJvYcCVhl9DEYBuoh6eTtAoEJPAwC2SEfNq4dJJxNVMXZbYg1tpS9w7AQLPtJEB9LO/BhuwN/60cuDwDGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzRfN7YEKNTPU37QGHdSCbOAisTJWKq75beohhwqH6zFtjs6k4a
	rrLh82r38+ocHtASRZV1oz9X4qRaM6muK+wzTViZ8ZZk15XDPe9PnFOiDIE3Nw+8HtE=
X-Gm-Gg: AY/fxX60sxlp45RS5DYt051WRzpQuYymgzzoROSt/G1XD1HwBOG3d0ulAyoBbJmffPt
	5ApAtqUSJeZSysvTUHsAv1ffXks4rit1UZiqqJ9Vs29OkfyfDDF75exm7/X7O8Ro1EL8iG63ZQA
	WBUVgL8YLbiqJwZ9/jQzJ9wrePswVbhIjgBH1fPIpT2OJ2EuItTTc+QZY++ACfTDU444DESAGVt
	XRtuardl/nOPPTBgVm3suqBEbgP6RwtImSnCSeVw3ov6bX8Y3ICJiyvwuuhMQk/Y979yM3+MG3q
	Halx2Tj4GvtDqNx6TjpHQ2+ir+ORXHCvhvFwWY3UZkPBllXE0VqrseESqChg23y+IKWoYz6Ly1H
	eri9VEBxHQK09ZuIq2rOsX5FBREfijWb8vm9k+6amJuoluvmfWOB8bjjGF7V4cLRTrz2krZEuz9
	e2rFaWSJbhFCEDFw==
X-Google-Smtp-Source: AGHT+IHUReQqvVgC0db5F0/UgqAPwHgCcpq2ZD0lhm0g7XnDeEa3Phlj1/GEitKl8zvqkUFbSZC6XA==
X-Received: by 2002:a05:6000:2dc9:b0:430:fced:902 with SMTP id ffacd0b85a97d-432c36436fbmr29258778f8f.26.1768325840268;
        Tue, 13 Jan 2026 09:37:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm28342147f8f.34.2026.01.13.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:37:19 -0800 (PST)
Date: Tue, 13 Jan 2026 18:37:17 +0100
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
Subject: Re: [PATCH 02/19] printk: Introduce console_is_nbcon
Message-ID: <aWaCzZ8_UuyAa6xp@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_093722_404650_48A095C4 
X-CRM114-Status: GOOD (  30.22  )
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

On Sat 2025-12-27 09:16:09, Marcos Paulo de Souza wrote:
> Besides checking if the current console is NBCON or not, console->flags
> is also being read in order to serve as argument of the console_is_usable
> function.
> 
> But CON_NBCON flag is unique: it's set just once in the console
> registration and never cleared. In this case it can be possible to read
> the flag when console_srcu_lock is held (which is the case when using
> for_each_console).
> 
> This change makes possible to remove the flags argument from
> console_is_usable in the next patches.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h   | 27 +++++++++++++++++++++++++++
>  kernel/debug/kdb/kdb_io.c |  2 +-
>  kernel/printk/nbcon.c     |  2 +-
>  kernel/printk/printk.c    | 15 ++++++---------
>  4 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 35c03fc4ed51..dd4ec7a5bff9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
>  	WRITE_ONCE(con->flags, flags);
>  }
>  
> +/**
> + * console_srcu_is_nbcon - Locklessly check whether the console is nbcon

There is _srcu in the function name, see below.

> + * @con:	struct console pointer of console to check
> + *
> + * Requires console_srcu_read_lock to be held, which implies that @con might
> + * be a registered console. The purpose of holding console_srcu_read_lock is
> + * to guarantee that no exit/cleanup routines will run if the console
> + * is currently undergoing unregistration.
> + *
> + * If the caller is holding the console_list_lock or it is _certain_ that
> + * @con is not and will not become registered, the caller may read
> + * @con->flags directly instead.
> + *
> + * Context: Any context.
> + * Return: True when CON_NBCON flag is set.
> + */
> +static inline bool console_is_nbcon(const struct console *con)

And here it is without _srcu.

I would prefer the variant with _srcu to make it clear that it
can be called only under _srcu. Similar to console_srcu_read_flags(con).

> +{
> +	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
> +
> +	/*
> +	 * The CON_NBCON flag is statically initialized and is never
> +	 * set or cleared at runtime.
> +	 */
> +	return data_race(con->flags & CON_NBCON);
> +}
> +
>  /* Variant of console_is_registered() when the console_list_lock is held. */
>  static inline bool console_is_registered_locked(const struct console *con)
>  {

Otherwise, it looks good to me.

With a consistent name, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

