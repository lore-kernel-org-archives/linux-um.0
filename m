Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMzyq-0000zm-Rq
 for linux-um@lists.infradead.org; Sat, 04 May 2019 19:05:54 +0000
Message-ID: <95430ca975e73addc7f65e331488bc280974fd72.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] arch: um: support virtual time
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 04 May 2019 21:05:43 +0200
In-Reply-To: <20190503213249.30008-3-johannes@sipsolutions.net>
References: <20190503213249.30008-1-johannes@sipsolutions.net>
 <20190503213249.30008-3-johannes@sipsolutions.net>
Mime-Version: 1.0
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
To: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, 2019-05-03 at 21:32 +0000, Johannes Berg wrote:
> 
> @@ -65,12 +75,17 @@ int os_timer_set_interval(void)
> 
>         if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
>                 return -errno;
> +#else
> +       timer_enabled = true;
> +       timer_expiry = virtual_time + UM_NSEC_PER_SEC / UM_HZ;
> +#endif

This is broken in two ways - first of all, I missed the interval
completely, and secondly if you end up with a process that does
something like

 x = gettime();
 while (x == gettime()) { /* nothing */ }

then it gets stuck forever ...

I have a new version almost ready.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

