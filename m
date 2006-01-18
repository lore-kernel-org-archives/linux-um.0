Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1aP-0008E2-QC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:54:05 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ez1aP-0003mh-OG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:54:06 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060117165602.3d29f936.akpm@osdl.org>
In-Reply-To: <20060118001938.14622.47308.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001938.14622.47308.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 6/9] uml: avoid malloc to sleep in atomic
	sections
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
Date: Tue, 17 Jan 2006 16:56:02 -0800
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> +int __cant_sleep(void) {
> +	return in_atomic() || irqs_disabled() || in_interrupt();

aww, man, this is awful.  Code is supposed to know what context it's
running in, not go fishing about in core internals trying to fix up its own
confusion.

> +	/* Is in_interrupt() really needed? */
>  }

Yes, it is.  in_atomic() is a no-op on !PREEMPT and local irq's can be
enabled in soft- or hard- interrupt context, so irqs_disabled() will return
0.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
