Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFGSZ-0000dT-Ic
 for linux-um@lists.infradead.org; Thu, 25 Feb 2021 13:13:40 +0000
Message-ID: <96d1f031409d87ff91582eb5b3c1db5af9832bf9.camel@sipsolutions.net>
Subject: Re: [PATCH 4/7] um: time-travel/signals: fix ndelay() in interrupt
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 25 Feb 2021 14:13:33 +0100
In-Reply-To: <20210223161449.7461e0b6dacc.I3507b456d425cb95a092eb50b6cb491fe8575c50@changeid>
References: <20210223152707.408995-1-johannes@sipsolutions.net>
 <20210223161449.7461e0b6dacc.I3507b456d425cb95a092eb50b6cb491fe8575c50@changeid>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> 
> +void unblock_signals_hard(void)
> +{
> +	if (!signals_blocked)
> +		return;
> +
> +	if (signals_pending && signals_enabled) {
> +		/* this is a bit inefficient, but that's not really important */
> +		block_signals();
> +		unblock_signals();
> +	} else if (signals_pending & SIGIO_MASK) {
> +		/* we need to run time-travel handlers even if not enabled */
> +		sigio_run_timetravel_handlers();
> +	}
> +
> +	signals_blocked = 0;
> +}

This is, of course, racy & wrong - we could set signals_pending just
after checking it.

Need to make this

{
	if (!signals_blocked)
		return;
	signals_blocked = 0;
	barrier();

	if (signals_pending && signals_enabled) {
...


Anyway, I need to repost this series, but I'll wait a bit longer for
further feedback before that, since I know Arnd and others wanted to
take a look at the IOMEM and PCI bits.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

