Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERgj0-0007h8-0t	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 18:57:10 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ERgix-0007Vk-NA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 18:57:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Starting uml with the debugger
References: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
	<20051017175328.GA8015@localhost.localdomain>
	<200510172038.34803.rob@landley.net>
In-Reply-To: <200510172038.34803.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510180358.18434.blaisorblade@yahoo.it>
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
Date: Tue, 18 Oct 2005 03:58:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Tuesday 18 October 2005 03:38, Rob Landley wrote:
> On Monday 17 October 2005 12:53, Jeff Dike wrote:
> > If this thing is new enough to have skas0, then just disable
> > CONFIG_MODE_TT and gdb it normally.

> I'm curious: now that skas0 mode works, when does tt mode start to go away?

I really don't want TT mode to go away.

Reason 1, developers need to be able to enable SMP. Or the locking will break 
even more. And in these two days, with the new (and better) lock debugging of 
2.6.14-rc (from Ingo), I've seen enough bugs to let me scared.

And I simply tested "uml_mconsole <umid> eth1=mcast".

Say, the uml_net_interrupt(), when holding the iface spinlock, can call, in 
the failure path, uml_net_close(), which calls the interrupt again.

Said that, I also have plans (from one year at least) to jail TT mode in a 
faster mode (i.e. with segment limits). I was descouraged, but the 
motivations behind that turned out to be mostly wrong (a supposed "bad 
performance"), and Xen uses it.

However, that's for the memory layout. For the rest I'd take normal SKAS flow. 
So, this would be a SKAS mode for everything, except that it would be like 
2.5G/1G instead of 3G/3G (if you know about 4G/4G in Fedora from Ingo vs. 
3G/1G in vanilla kernels, you should get what I mean. If not, search google 
or lwn.net about 4G/4G).

> (Obviously, making tls work might be nice first...)

I've been stopped by debugging problems, but now I workarounded GDB problems I 
can debug simple problems very easily.

TLS is more difficult, as you need to disassemble the faulting location for 
the strange SIGSEGV, and that is not even always possible.

However, for your Ubuntu issue, see the mail I'm going to post.
> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
