Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXJ1t-0003ER-2k for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 04:47:21 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CXJ1q-0004dH-Mw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 04:47:21 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200411250456.33779.blaisorblade_spam@yahoo.it>
	<41A5C5A9.7040902@fujitsu-siemens.com>
In-Reply-To: <41A5C5A9.7040902@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411251349.54865.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Fwd: [PATCH] UML - close host file descriptors
	properly
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 25 Nov 2004 13:49:54 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 25 November 2004 12:44, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > This patch was sent by Jeff for merging in mainline - since you
> > complained on an earlier version, have you still something to correct in
> > it?

> AFAICS, it's the same patch as you have in bb3 with the name
> "uml-close-all-fds". So, it's OK. To have reboot on SKAS working,
> fix-reboot-skas is required also.
Yes, that is in -bb3.
> > Btw, the reboot problem is not fixed for me - even in -bb3, with your
> > last patch tarball excluding SYSEMU_SINGLESTEP, rebooting does not always
> > work.

> That's bad. On my system, since the patches are applied, I never saw a
> reboot failing.
I got the same randomical failure before. And what's more, with the use-va_end 
cleanup, it *always* crashed (not retested, but going to do this now).

Without va_end, sometimes (1 on 3 on average, I'd say) I get:

"Remounting root filesystem read-only.
Rebooting.
Restarting system.

deactivate_all_fds failed, errno = 9
Segmentation fault"

> I have an idea to find out, what happens on your machine.
Ok, going to test ASAP.
> First let me 
> summarize, what the reasons were on my system for problems while reboot:
> - on shutdown, UML blocks some signals before jumping back to main().
> - while the signals are blocked, the file descriptors still are set to
> generate SIGIO an IO events.
> - immediately before doing the exec()for reboot, UML did the following
> sequence * unblock the signals
>    * stop the timers
>    * deactivate the fds (i.e. reset O_ASYNC)
> - This failed, because:
>    * when a signal-handler was called after unblocking the signals, it
> segfaulted, because it got NULL from get_current(), so I inserted to set
> SIG_IGN for SIGIO and SIGALRM/SIGVTALRM, before unblocking the signals.
> Also I changed the sequence to first deactivate the fds and stop the
> timers, then unblock the signals
>    * Some fds, that were activated to generate SIGIO, were not closed nor
> disabled (on my system, this was the daemon-network). So, new SIGIOs were
> generated, while or short after the exec(). Since exec() resets the
> SIGIO-handler to SIG_DFL, this kills UML.
> Considering this, the reason for the problems on your system might be an
> other configuration, where again a fd stays open and active and kills the
> reboot generating a SIGIO.
> We can verify this by inserting
>      char c;
>      change_sig(SIGIO,0);
>      read(0,&c,1);
>      change_sig(SIGIO,1);
> as the very first action in main(). Now on start and reboot you have to
> press a key to continue. A SIGIO coming in while waiting, won't kill us,
> since SIGIO is blocked. So we have time to do "ls -l /proc/PID/fd" and see,
> whether there is something open still, only 0,1 and 2 should be open at
> that time. If there are others open, we need a close-all-fds-2 patch.
> There is an other possibility, I can't leave out. When the kernel does the
> exec(), there might be a signal just written to the queue, but not
> delivered yet. Then the first action after the exec() the kernel does, is
> to kill the process. Also, if there is a fd still open and active with
> CLOSE_ON_EXEC set, after the exec() you will see nothing being wrong, but
> in very rare cases, the reboot might be broken. To catch these, you could
> insert a read(0,&c,1) immediately before the exec() (no change_sig needed)
> and see, which fds are open there. But in this case, e.g. vmfile-XXXXX is
> intentionally open and will be closed on exec(). That doesn't matter, since
> SIGIO isn't activated for it. So, we have to look carefully, which fd is
> wrong.
>
> > ----------  Forwarded Message  ----------
> >
> > Subject: [PATCH] UML - close host file descriptors properly
> > Date: Thursday 25 November 2004 00:07
> > From: Jeff Dike <jdike@addtoit.com>
> > To: akpm@osdl.org
> > Cc: linux-kernel@vger.kernel.org, Blaisorblade
> > <blaisorblade_spam@yahoo.it>
> >
> > This process closes some file descriptors which were left open
> > incorrectly. These are the initrd descriptor, the temporary test file
> > used for testing /tmp for execution permission, and a descriptor used by
> > the netork to connect to the switch.  In the network case, we add network
> > devices to the opened list as soon as they are added to UML, rather than
> > when they are configured. This ensures that close_devices will remove the
> > device properly on shutdown.
> >
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> >
> > Index: 2.6.9/arch/um/drivers/net_kern.c
> > ===================================================================
> > --- 2.6.9.orig/arch/um/drivers/net_kern.c 2004-11-18 11:02:33.000000000
> > -0500 +++ 2.6.9/arch/um/drivers/net_kern.c 2004-11-18 11:22:10.000000000
> > -0500 @@ -126,10 +126,6 @@
> >   lp->tl.data = (unsigned long) &lp->user;
> >   netif_start_queue(dev);
> >
> > - spin_lock(&opened_lock);
> > - list_add(&lp->list, &opened);
> > - spin_unlock(&opened_lock);
> > -
> >   /* clear buffer - it can happen that the host side of the interface
> >    * is full when we get here.  In this case, new data is never queued,
> >    * SIGIOs never arrive, and the net never works.
> > @@ -150,11 +146,9 @@
> >
> >   free_irq_by_irq_and_dev(dev->irq, dev);
> >   free_irq(dev->irq, dev);
> > - if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
> > + if(lp->close != NULL)
> > +  (*lp->close)(lp->fd, &lp->user);
> >   lp->fd = -1;
> > - spin_lock(&opened_lock);
> > - list_del(&lp->list);
> > - spin_unlock(&opened_lock);
> >
> >   spin_unlock(&lp->lock);
> >   return 0;
> > @@ -289,7 +283,7 @@
> >  static spinlock_t devices_lock = SPIN_LOCK_UNLOCKED;
> >  static struct list_head devices = LIST_HEAD_INIT(devices);
> >
> > -static int eth_configure(int n, void *init, char *mac,
> > +static int eth_configure(int n, void *init, char *mac,
> >      struct transport *transport)
> >  {
> >   struct uml_net *device;
> > @@ -397,6 +391,11 @@
> >
> >   if (device->have_mac)
> >    set_ether_mac(dev, device->mac);
> > +
> > + spin_lock(&opened_lock);
> > + list_add(&lp->list, &opened);
> > + spin_unlock(&opened_lock);
> > +
> >   return(0);
> >  }
> >
> > @@ -705,7 +704,7 @@
> >  static void close_devices(void)
> >  {
> >   struct list_head *ele;
> > - struct uml_net_private *lp;
> > + struct uml_net_private *lp;
> >
> >   list_for_each(ele, &opened){
> >    lp = list_entry(ele, struct uml_net_private, list);
> > Index: 2.6.9/arch/um/kernel/initrd_user.c
> > ===================================================================
> > --- 2.6.9.orig/arch/um/kernel/initrd_user.c 2004-11-18 11:02:33.000000000
> >  -0500 +++ 2.6.9/arch/um/kernel/initrd_user.c 2004-11-18
> > 11:07:48.000000000 -0500 @@ -29,6 +29,8 @@
> >           filename, -n);
> >    return(-1);
> >   }
> > +
> > + os_close_file(fd);
> >   return(0);
> >  }
> >
> > Index: 2.6.9/arch/um/kernel/mem_user.c
> > ===================================================================
> > --- 2.6.9.orig/arch/um/kernel/mem_user.c 2004-11-18 11:02:33.000000000
> > -0500 +++ 2.6.9/arch/um/kernel/mem_user.c 2004-11-18 11:07:48.000000000
> > -0500 @@ -101,6 +101,8 @@
> >   }
> >   printf("OK\n");
> >   munmap(addr, UM_KERN_PAGE_SIZE);
> > +
> > + os_close_file(fd);
> >  }
> >
> >  static int have_devanon = 0;
> >
> > -------------------------------------------------------

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
