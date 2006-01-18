Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzBjt-0005CV-JX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:44:33 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzBjr-00054v-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:44:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 4/9] uml: fix spinlock recursion and
	sleep-inside-spinlock in error path
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001931.14622.17211.stgit@zion.home.lan>
	<20060117165217.0f9d9add.akpm@osdl.org>
In-Reply-To: <20060117165217.0f9d9add.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181244.01140.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 12:44:00 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 01:52, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > In this error path, when the interface has had a problem, we call
> > dev_close(), which is disallowed for two reasons:

> > *) takes again the UML internal spinlock, inside the ->stop method of
> > this device
> > *) can be called in process context only, while we're in interrupt
> > context.

> > I've also thought that calling dev_close() may be a wrong policy to
> > follow, but it's not up to me to decide that.

> > However, we may end up with multiple dev_close() queued on the same
> > device. But the initial test for (dev->flags & IFF_UP) makes this
> > harmless, though - and dev_close() is supposed to care about races with
> > itself. So there's no harm in delaying the shutdown, IMHO.

> > Something to mark the interface as "going to shutdown" would be
> > appreciated, but dev_deactivate has the same problems as dev_close(), so
> > we can't use it either.

> > ...
> > +		/* dev_close can't be called in interrupt context, and takes
> > +		 * again lp->lock.
> > +		 * And dev_close() can be safely called multiple times on the
> > +		 * same device, since it tests for (dev->flags & IFF_UP). So
> > +		 * there's no harm in delaying the device shutdown. */
> > +		schedule_work(&close_work);
> >  		goto out;
> >  	}

> This callback can be pending for an arbitrary amount of time.  I'd have
> expected to see a flush_sceduled_work() somewhere in the driver to force
> all such pending work to complete before we destroy things which that
> callback wil be using.

Thanks for the tip (it's good I got schedule_work right, it wasn't hard but 
1st time I use it), however the device is not later freed, it seems, in this 
context... even because it's an unlikely event (I reproduced it with a 
damn-bad configuration).

Not going to cause seeable leaks anyway, but yes, to correct.

However, network devices are created from the host only, so only the host 
should free them (as done by net_remove on "hot-unplug" request).

Maybe that's to fix too, however, but in a separate patch; Jeff, what about 
this?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
