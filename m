Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C80D31A25
	for <linux-um@archiver.kernel.org>; Wed, 14 Jan 2026 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=; b=OxlxnnSxsJi21kP/h9md1ZdMLV
	EoXrsSTRY1LI0c+nwtToykpJZ3UXPWlf9Q2DcsjfbzvnSj3HgT6hN/TYgidL4SEsIk+Q3qjUYBS/a
	25dnpbLkeiESuZUMRh0oCqjWLPdL/8UpN44rJyLJxYDeyTQ2CWM0HgOinDdePi6Sn9dqxzPjRe4DL
	TngVHC3WKs6DQsJHkTstZqrTiS9cLr2Fek9v1jK4oynJZhDExCWZgBGeULPCNl8j7yoOm8yyixXnQ
	JUCZu+UVRoIBZC7eJ9jGpwEtGKFZhQ4d9o+G1bL6yFIT+XwwDnDXI0kp4ueaMDD1YeLtRaKZouls/
	Cuf5fNAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfwUI-00000008OBz-24Xt;
	Wed, 14 Jan 2026 08:44:22 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfwUC-00000008OB6-3Yth
	for linux-um@lists.infradead.org;
	Wed, 14 Jan 2026 08:44:19 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-430fbb6012bso6708529f8f.1
        for <linux-um@lists.infradead.org>; Wed, 14 Jan 2026 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768380255; x=1768985055; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=G7YD9GT9MNwkv7GZp7I46HAKE/2DaWiOGkuFcp7CIEWkCHExzYkeWGJ+/neNbppQsn
         P6/D4UFb0SZalcxfQLR7SKbCf0gq6ZJo8Az6skkP0C49bGV1SPVcambmHhDfdJw295my
         ebabyiZtdDCN6CjQqmXAtP28KFXa4ZCyAzkqNuu8nxEozbre8l4k3+tG5s0DZEbzOUuy
         5HgbJVhEmSODoEblLggTtQd96UGVnNXFy3cutrr/jCbtulNCbRFWrc2PFNwgSBW0+nsf
         59CmNk8DowXdIgMrIAbdrTsbLxVPZcNbupF9k2kTi1qWTtczet7b8uud31TzBp4zDCwG
         HxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380255; x=1768985055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=jhtlsJEuWBOWvexu9M4CQUfdKrVRXVquuN4RZ/aUp2s7WWwIjV8Xn/uHIpJaGEwMbm
         mGdlML6VD5HIBdHa3ZqAhX9xp+pBfDWhe3eb5YB57Q0qoXIkMsu9TzQcEG+DKGV+CIiR
         Mf/y1Uo6k/dgtajshA4U1xptiVfJh2ydixKKWYv8JWiYM1tmbroToRMZGtX4m1wdkkYV
         egPTR3huWRfqzha3cIvtlg6Zd9bgW/LTei6RFW8VbrT/Bdc6L8rm3p80W25VFyLhL1gb
         iRLadX6VZY53qvuNGHoD4Q+/3aNsQ6ySRck0QpDFXOBgoUiHjVf02A6ga/EaXgD4YYN2
         tBmA==
X-Forwarded-Encrypted: i=1; AJvYcCVY+UmiJ2CozXqveAlFP1NZHknl5qXt+BkXxcCIm325fdYHtiMZLTUT4KzFb/OMNZ+lxHsCZhxAwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx++Yv9+TcAAeN7ebx/rj6LgMmQIPvpr/+5aRWtK8trA2vwHJdv
	ogwVEi0veaHKxU3kXxyDQocSJV4wgSc0Nzfvh1YMCYumjfDZzICrPb6cLl7nzkyJhjs=
X-Gm-Gg: AY/fxX7ga0lxeWlblXo0g+RKdgD//nmLfiecXRKoKYtYzlwDl4Dzin9tyeFv/sXYmPb
	SvyoXuOyv9ydOFRZkoYVg7H9KZSWjZ2Xkg3W5xeFXwmwGZIUbvJ5BHClFbFJzm2E4Y5YvUUsK2m
	VkEcUElNLfGumMBlAL8To2gN9Ws58VC8DCBv8oxyqGxryG2OLqXoXtgS7g5zIoqmqapVQHExPBP
	3bT7+0/Swwgr/EY5b7eTCpNx54PGG2h+0wuuzJoG09ySUpTyFc4GC2oTQejKCURbQpqlQUz0rGs
	4O3kLrYgTbRQ/Pv6O2xEyqZKcBUGbfFkXgQVpCrEKGW9lQk3Fk5F9hnsOdhUtd4aHLEyGWWGXCA
	itCBGYSMrgLLK2CfvHGJyue+qiK4saJH736+QWwe1zJXeFMriQ9p9vXjk4s/yECrP3jRMa6VCHU
	U3+6clLrSYwp48Dg==
X-Received: by 2002:a05:6000:61e:b0:431:a38:c2f7 with SMTP id ffacd0b85a97d-4342c574bedmr1500621f8f.59.1768380254886;
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm48685590f8f.35.2026.01.14.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Date: Wed, 14 Jan 2026 09:44:11 +0100
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
Subject: Re: [PATCH 03/19] printk: Drop flags argument from console_is_usable
Message-ID: <aWdXW6ohfQ7_z2B_@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_004416_943414_628EFD8E 
X-CRM114-Status: GOOD (  20.39  )
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

On Sat 2025-12-27 09:16:10, Marcos Paulo de Souza wrote:
> The flags argument was also used to check if CON_NBCON was set, but their
> usage was fixed in the last commit. All current users are reading the
> variable just to call console_is_usable.
> 
> By calling console_srcu_read_flags inside console_is_usable makes the
> code cleaner and removes one argument from the function.
> 
> Along with it, create a variant called __console_is_usable that can be
> used under console_list_lock(), like unregister_console_locked.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
> -/*
> - * Check if the given console is currently capable and allowed to print
> - * records. Note that this function does not consider the current context,
> - * which can also play a role in deciding if @con can be used to print
> - * records.
> - */
> -static inline bool console_is_usable(struct console *con, short flags,
> +/* Variant of console_is_usable() when the console_list_lock is held. */

Nit: The comment is a bit misleading because this function is called
     also from console_is_usable() under console_srcu_read_lock().

     I would say something like:

/*
 * The caller must ensure that @con can't disappear either by taking
 * console_list_lock() or console_srcu_read_lock(). See also
 * console_is_usable().
 */
> +static inline bool __console_is_usable(struct console *con, short flags,
>  				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
> @@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
>  	return true;
>  }
>  
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. Note that this function does not consider the current context,
> + * which can also play a role in deciding if @con can be used to print
> + * records.

And I would add here something like:

 *
 * Context: Must be called under console_srcu_read_lock().

> + */
> +static inline bool console_is_usable(struct console *con,
> +				     enum nbcon_write_cb nwc)
> +{
> +	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
> +}
> +
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }

Otherwise, it looks good. It is a nice clean up.

Best Regards,
Petr

