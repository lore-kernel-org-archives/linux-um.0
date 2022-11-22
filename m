Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37885C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hTknkxDUlhyZ3fsfzDIIySYeQdwkrZFmgkWcJG5L5O0=; b=HinZLJ0BCdPHTF
	rXznRZrjYBfmGUFHe8ySWIAPSFBtMNHySK4Xgz1Uhusk5KKZnx8ryxMFKw3syNPUInhsIgGk7DgkX
	nDr79fks3bXJpjNGfmTO7Bbq93RCsiDeRpHCHvPUYxGrfT9t8VweCb2iQfnhOLnXmsEOXaZHC2NHA
	11uTTPW6GO/Rx28LQmaM1em2M6Gjm/JkhzbeLAiENJs8IYo0dBKhxmlfjkkYtjHQAO60fOXdAy3yB
	xIAJ1XADA5lgUSofhkkdwDQPef5NFW+j+N7V7kIa3cXPpZO8oYLHInPPK2dCNh5Pakwmkwxedl/ca
	Or1Ge9nLuK3gOIID35KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWMi-00AoyG-Rf; Tue, 22 Nov 2022 16:43:20 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWMd-00AovI-C7; Tue, 22 Nov 2022 16:43:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A8C9CB81CBD;
	Tue, 22 Nov 2022 16:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD1C433D6;
	Tue, 22 Nov 2022 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1669135392;
	bh=HhGB03f7yfLJTw6SIRqhGxERi9Gom4x4ToervBUNQF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ai29wCwrSrFMalECnQg3VZFE6JJ7w1PVvNsX/nUcTdZGvwJT9FgVXh0Qu1fP/KZjg
	 gLL1mmmGyJUPfkwUZ8U8rfzyORb4k7cg2ocWkdlYVwXPJu4ByDHKX8FbqktGuqI0/r
	 L84ihOeSNwOdUyo5JUrjvyIoAUgVxWDKIToY6zCM=
Date: Tue, 22 Nov 2022 17:43:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Aaron Tomlin <atomlin@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Michal Simek <michal.simek@xilinx.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v5 00/40] reduce console_lock scope
Message-ID: <Y3z8HOt0yOd1nceY@kroah.com>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_084315_739488_1E864E06 
X-CRM114-Status: GOOD (  26.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Nov 16, 2022 at 05:27:12PM +0106, John Ogness wrote:
> This is v5 of a series to prepare for threaded/atomic
> printing. v4 is here [0]. This series focuses on reducing the
> scope of the BKL console_lock. It achieves this by switching to
> SRCU and a dedicated mutex for console list iteration and
> modification, respectively. The console_lock will no longer
> offer this protection.
> 
> Also, during the review of v2 it came to our attention that
> many console drivers are checking CON_ENABLED to see if they
> are registered. Because this flag can change without
> unregistering and because this flag does not represent an
> atomic point when an (un)registration process is complete,
> a new console_is_registered() function is introduced. This
> function uses the console_list_lock to synchronize with the
> (un)registration process to provide a reliable status.
> 
> All users of the console_lock for list iteration have been
> modified. For the call sites where the console_lock is still
> needed (for other reasons), comments are added to explain
> exactly why the console_lock is needed.
> 
> All users of CON_ENABLED for registration status have been
> modified to use console_is_registered(). Note that there are
> still users of CON_ENABLED, but this is for legitimate purposes
> about a registered console being able to print.
> 
> The base commit for this series is from Paul McKenney's RCU tree
> and provides an NMI-safe SRCU implementation [1]. Without the
> NMI-safe SRCU implementation, this series is not less safe than
> mainline. But we will need the NMI-safe SRCU implementation for
> atomic consoles anyway, so we might as well get it in
> now. Especially since it _does_ increase the reliability for
> mainline in the panic path.
> 
> Changes since v4:
> 
> printk:
> 
> - Introduce console_init_seq() to handle the now rather complex
>   procedure to find an appropriate start sequence number for a
>   new console upon registration.
> 
> - When registering a non-boot console and boot consoles are
>   registered, try to flush all the consoles to get the next @seq
>   value before falling back to use the @seq of the enabled boot
>   console that is furthest behind.
> 
> - For console_force_preferred_locked(), make the console the
>   head of the console list.
> 


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
