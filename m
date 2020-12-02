Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQiC-0007yr-RG
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:54:21 +0000
Message-ID: <36c4780dbcea541307cbcc90b37baaf49f03fc9a.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 02 Dec 2020 12:54:18 +0100
In-Reply-To: <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
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
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

Oh, I found the bug ...


>  static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
>  {

[...]

> +	irq_entry->reg[type].irq = irq;
> +	irq_entry->reg[type].active = true;
> +	irq_entry->reg[type].events = events;

Obviously, here we need

	irq_entry->reg[type].id = dev_id;

:-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

