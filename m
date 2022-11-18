Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A19AC4332F
	for <linux-um@archiver.kernel.org>; Fri, 18 Nov 2022 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QjoZ2xwPlGyKve/L23J5J93HV2PMpsvddTQm4rc8xpc=; b=ua1fbHv9q/6d98
	UW14UvNFBvuW4yjFIUqEldGixIcPG8Hd0Wk4HIBmiiRnrGR97xAUkrEvrZEZerPBVZkmIQsV6C66F
	wa8DeUdh0vx6uiYv9HWkUOZtXE7YLbTe3oku+Ga2/eOtihi2m3I6L6RMO+UtBvxRN+Lv8bZFJch4j
	Sga4Px4HWSfPbITvCp/yp1ahDodPy7zb4ikQynJ69VgEubuW1SP01/oZsg0GyLwLSgyVGZtmJi7Nm
	8adnI8k2rhDSrS5b+sf+fr9k/kn1nioMCvTnpCd7nY+iFQHwih+lwmkym4DhPJBMPsiN32S+lC7fp
	3YV6A4tUmTJCPxVU2pUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow2ol-004h6V-VN; Fri, 18 Nov 2022 14:58:11 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow2mG-004fcu-VY; Fri, 18 Nov 2022 14:55:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A1D8221FB8;
	Fri, 18 Nov 2022 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1668783329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RcWbup5BnnjHzEPpsHQeQ/9zmfC/ktCQBWDNShm4WAU=;
	b=EDb4yO6yUhovxR1R/uuiYft78ukr2h+oU+IjaIre1crSLD6FqDa7tOBl7T9GdFyjImWzLl
	fuZVE7BJe7raqlKMXUK6GnRr1NqEKply8FF3aod58x9Whn9xAOWMtUkNgxO/GnqpzSdULK
	TFzAN6y09Rae96AY+OVlAOuIn3VhXg8=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 093D42C141;
	Fri, 18 Nov 2022 14:55:28 +0000 (UTC)
Date: Fri, 18 Nov 2022 15:55:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <Y3ec3/fpdAQacAOW@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <Y3drEOkD1fuZcvV2@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3drEOkD1fuZcvV2@alley>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_065537_310718_81073F05 
X-CRM114-Status: GOOD (  17.12  )
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

On Fri 2022-11-18 12:22:58, Petr Mladek wrote:
> On Wed 2022-11-16 17:27:12, John Ogness wrote:
> > This is v5 of a series to prepare for threaded/atomic
> > printing. v4 is here [0]. This series focuses on reducing the
> > scope of the BKL console_lock. It achieves this by switching to
> > SRCU and a dedicated mutex for console list iteration and
> > modification, respectively. The console_lock will no longer
> > offer this protection.
> 
> The patchset looks ready for linux-next from my POV.
> 
> I am going to push it there right now to get as much testing
> as possible before the merge window.

JFYI, the patchset is committed in printk/linux.git,
branch rework/console-list-lock.

I'll eventually merge it into rework/kthreads. But I wanted to have
it separated until it gets some more testing in linux-next and
eventually some more review.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
