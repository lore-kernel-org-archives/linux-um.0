Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gLEuz-000833-UF
 for linux-um@lists.infradead.org; Fri, 09 Nov 2018 22:06:22 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] Add DISCARD support to UML udb driver
Date: Fri, 09 Nov 2018 23:06:00 +0100
Message-ID: <5868448.ctSSMDQgOm@blindfold>
In-Reply-To: <79343bcf-8cf7-27e8-1d53-ee404f6431bd@cambridgegreys.com>
References: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
 <CAFLxGvxy7d_9--b_SPcPQ_e=Er0aJds5TBqfd5Q-OANCj6DOaQ@mail.gmail.com>
 <79343bcf-8cf7-27e8-1d53-ee404f6431bd@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>

Am Freitag, 9. November 2018, 22:20:03 CET schrieb Anton Ivanov:
> > What shall happen if the host filesystem does not support these
> > fallocate() operations?
> > I guess we need to probe for them first and decide whether to
> > accept/offer the discard command
> > at run time.
> 
> If it the filesystem is using periodic (not realtime) fstrim, It will 
> return IO error on those and fstrim will fail. Normal file ops - write, 
> read, fsync should continue as this should not force a remount.
> 
> I could not test with realtime fstrim ans btrfs was having some issues 
> in 4.20-rc1. It was hitting spinlock recursions and irq on/off where 
> they should not be BUG()s.
> 
> Non-destructive probing is a bit difficult. IMHO, we should leave this 
> to the user and add flags the way nbd and loop have done it. We can also 
> add a config option to set a default on or off at compile time (same as 
> for sync io on ubd).

Well, we could do what qemu does.
If the syscall fails with -ENOTSUP, disable discard.

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

