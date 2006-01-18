Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzBn2-0005Ng-JM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:47:48 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzBn2-000635-6Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:47:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001938.14622.47308.stgit@zion.home.lan>
	<20060117165602.3d29f936.akpm@osdl.org>
In-Reply-To: <20060117165602.3d29f936.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181247.42976.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 12:47:42 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 18 January 2006 01:56, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > +int __cant_sleep(void) {
> > +	return in_atomic() || irqs_disabled() || in_interrupt();
>
> aww, man, this is awful.  Code is supposed to know what context it's
> running in, not go fishing about in core internals trying to fix up its own
> confusion.

Yes, I know.

But is libc supposed too? That's our problem. This code is only used for calls 
to malloc() (not kmalloc()) after the kernel has booted.

There are a few calls to malloc in our code, ok, and those should be fixed 
too.

But the main problem are glibc ones (which are called from all kinds of places 
- we once got a crash because opendir() was calling malloc with big sizes - 
we solved that by optionally using vmalloc()).
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
