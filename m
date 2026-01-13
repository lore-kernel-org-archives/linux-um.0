Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5BD2F33E
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=; b=pHNekmYKGqmTPyXpx+NFloVwU1
	BL3mH2Rpse+eUu8+9SlDjMtBQNxDK/wZ95vBNS1zn02oTOzkpypW9wHEwgA93B5CQs61RdAel2LoG
	dZRgN0mUQeGqm7awFR7rSKXTNvZN+sDjss+/547sMw4X+3lb9zDQ6xmewK9NUD/ayVTuUJIMV7p5l
	ZBUxHHgl4frqG9JiSZL0lHeD6mL2F/F5dJWQIgE5uwC7JU2yVGnOtZgCNQ3dzIEmAeKhOqg9BTbHN
	DaTDEsvTAOMMEbMp0oD5cOe9kgFGbpIWQg+vT7UtSemjZ8IEZcYdhHcBZa4Nwd96H1HPd0TuhA3Ju
	1y9VID+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfhDV-00000007T3N-1Rnm;
	Tue, 13 Jan 2026 16:26:01 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfhDS-00000007T2E-3qHV
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 16:26:00 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso71146275e9.3
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768321556; x=1768926356; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=AWJ3LjZcCgewUzLSzpg/HVEX/WzvAF4GPmkYCfG6smzzZKcH2v//Xumn3M32dL32FA
         yi0+jtLmTak6Tq9hCRB6ESorx+h4aWHfcgyCoch+ej39Ga9qMwnoXtn7QIDPKxjQO4uJ
         gb65kya4ozlFSLwNQ5YklCFOQEfIzNBYT33C0UVsoNzAiMc3fynlQspUKuqE2KdDXRnr
         /S7DJNToWu3znDzFG3V94VkIia4rLL70stsniHBMfODYVb0+nEKQ3gwAyUEgMwfbueHb
         RoyHJYhuC/y2JlclnduJ5MgP6rTnh9kuXlWGk5CZuImz16VUfwsbZe2o/DP7JkPWZEwq
         enJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321556; x=1768926356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=tdsVI7b5RNXg5b5GtV12oC273yQ/gso1Q1n++tHuD2oB8OekSztGVHOBu37V5afJJr
         k7Z/lyh2HwMWBH5+2acVslqOGgQ7t2ZAmPICnWsb80EVJwtKv6yqYvUWc/5a+acj8Bv9
         /6Fav6e1LTe3MXaV7So5xSC4V/7BPHdb1WWF5S4ldc3MqasA23iJUxP8KeREldEXYY2j
         F6NucC1W23sER9cOjeeMK3e1DtYDsiEZytTRh7V3O+TxRyki7AdaTwF7wu5X7NojkxIP
         T6zja/UiWXJ91zpBMaHioTPLfvy21k0qKvaHmsZl64Wt0vDDJMs46UWF28RhpZvjh3N5
         gDDA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgGE8z+UOaxsAGi1AWZxA11o1EdERlFs9haAR9YMMS8eWPmz0N2ol0GgPGWjEvA2rhVKELWg3eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YypYIZ2+u95fzUigzDtr19CnhbYbpj7UToxPvDQgO/tm9FO2ukP
	+3HNLGu0WbkfHZued6kHJuFma7YK2ru+3u/i3s3MiK4xLFmlofvJ5dSMLWtgeoxkrI0=
X-Gm-Gg: AY/fxX5wrshOku/tewUngu6c7qHyi7P4J1q0nzGhhcSwtU64XhYfW5BtWCBdBw0aZfJ
	OMnk+HUJAinq4KZAe4QK/UM78/auL7oDQyydS2JNW3bqjihAgf/IYXyYA8dFailSlrSYFIRv7Eq
	QhOaMUaQ3qwh5C6bmSGLQT9rViS6qkyR/Pp4ZfhaZHxuZKO4p/nOSIaOMJlFDhKz+3wGRVkXkqX
	XpLXXhCHS800eWu1XJHSZyYHkKapXdVRIMiEkLAMjMmFiK3TUvA8E9TZDwwh0/dqitRC87MnP8j
	lyRBX36DZsb3vAFsFHNURzbok4KIU7KAistLBNapCW2FM5P+A4kRv0LC3ej8YEhcjWujSTF1szZ
	FCiSC766gFO3Ho8Iltqr+12kl0rdUV+wRO6G454evKZxe9BsEC7gKSFenwwQ7oU2yb3z8I7lbvO
	yUhkGtOqMbB7YvL1PHFcJqt0av
X-Google-Smtp-Source: AGHT+IG4o2sMRbjal/wNqE1AyBhrQEhgOmuQP9i1Wb50Y85ZgDNaJvwCCbv/cl0e10bMkrsnwOfPLQ==
X-Received: by 2002:a05:600c:1e1c:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47d84b0aa4bmr229523325e9.5.1768321556267;
        Tue, 13 Jan 2026 08:25:56 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm45637605f8f.8.2026.01.13.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:25:55 -0800 (PST)
Date: Tue, 13 Jan 2026 17:25:52 +0100
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
Subject: Re: [PATCH 01/19] printk/nbcon: Use an enum to specify the required
 callback in console_is_usable()
Message-ID: <aWZyEHsOJFLRLRKT@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_082558_992948_49FB1FF2 
X-CRM114-Status: GOOD (  23.33  )
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

On Sat 2025-12-27 09:16:08, Marcos Paulo de Souza wrote:
> The current usage of console_is_usable() is clumsy. The parameter
> @use_atomic is boolean and thus not self-explanatory. The function is
> called twice in situations when there are no-strict requirements.
> 
> Replace it with enum nbcon_write_cb which provides a more descriptive
> values for all 3 situations: atomic, thread or any.
> 
> Note that console_is_usable() checks only NBCON_USE_ATOMIC because
> .write_thread() callback is mandatory. But the other two values still
> make sense because they describe the intention of the caller.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -202,6 +202,19 @@ enum cons_flags {
>  	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
>  };
>  
> +/**
> + * enum nbcon_write_cb - Defines which nbcon write() callback must be used based
> + *                       on the caller context.
> + * @NBCON_USE_ATOMIC: Use con->write_atomic().
> + * @NBCON_USE_THREAD: Use con->write_thread().
> + * @NBCON_USE_ANY:    The caller does not have any strict requirements.
> + */
> +enum nbcon_write_cb {
> +	NBCON_USE_ATOMIC,
> +	NBCON_USE_THREAD,
> +	NBCON_USE_ANY,

AFAIK, this would define NBCON_USE_ATOMIC as zero. See below.

> +};
> +
>  /**
>   * struct nbcon_state - console state for nbcon consoles
>   * @atom:	Compound of the state fields for atomic operations
> @@ -622,7 +635,8 @@ extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
>  		return false;
> @@ -631,7 +645,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
>  		return false;
>  
>  	if (flags & CON_NBCON) {
> -		if (use_atomic) {
> +		if (nwc & NBCON_USE_ATOMIC) {

This will always be false because NBCON_USE_ATOMIC is zero.
I think that it was defined as "0x1" in the original proposal.

Let's keep it defined by as zero and use here:

		if (nwc == NBCON_USE_ATOMIC) {

Note that we do _not_ want to return "false" for "NBCON_USE_ANY"
when con->write_atomic does not exist.

>  			/* The write_atomic() callback is optional. */
>  			if (!con->write_atomic)
>  				return false;


Otherwise, it looks good to me.

Best Regards,
Petr

