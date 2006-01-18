Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1Wq-00088b-17 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:50:24 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ez1Wn-0002XJ-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:50:24 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060117165217.0f9d9add.akpm@osdl.org>
In-Reply-To: <20060118001931.14622.17211.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001931.14622.17211.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 4/9] uml: fix spinlock recursion and
	sleep-inside-spinlock in error path
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
Date: Tue, 17 Jan 2006 16:52:17 -0800
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> In this error path, when the interface has had a problem, we call dev_close(),
> which is disallowed for two reasons:
> 
> *) takes again the UML internal spinlock, inside the ->stop method of this
>    device
> *) can be called in process context only, while we're in interrupt context.
> 
> I've also thought that calling dev_close() may be a wrong policy to follow, but
> it's not up to me to decide that.
> 
> However, we may end up with multiple dev_close() queued on the same device.
> But the initial test for (dev->flags & IFF_UP) makes this harmless, though -
> and dev_close() is supposed to care about races with itself. So there's no harm
> in delaying the shutdown, IMHO.
> 
> Something to mark the interface as "going to shutdown" would be appreciated, but
> dev_deactivate has the same problems as dev_close(), so we can't use it either.
> 
> ...
> +		/* dev_close can't be called in interrupt context, and takes
> +		 * again lp->lock.
> +		 * And dev_close() can be safely called multiple times on the
> +		 * same device, since it tests for (dev->flags & IFF_UP). So
> +		 * there's no harm in delaying the device shutdown. */
> +		schedule_work(&close_work);
>  		goto out;
>  	}

This callback can be pending for an arbitrary amount of time.  I'd have
expected to see a flush_sceduled_work() somewhere in the driver to force
all such pending work to complete before we destroy things which that
callback wil be using.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
