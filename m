Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByDgD-00010w-Nx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 10:59:57 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1ByDgC-0002Ad-Cc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 10:59:57 -0700
Message-Id: <200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 20 Aug 2004 14:24:45 +0200."
	<20040820122445.GA21790@bytesex> 
References: <20040820122445.GA21790@bytesex> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
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
Date: Fri, 20 Aug 2004 15:01:40 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> uml-core-on-panic
> 	Make the uml kernel dump core on kernel panics for later analysis.
> 	Default: off, there is a kernel cmd line arg to enable that. 

I like this, but I think it would be better done in a panic_notifier.

> uml-fix-mconsole-proc
> 	fix kernel crash triggered by running "uml_mconsole <umid> proc
> <some-file>"
> 	multipole times. 

I didn't do it this way on purpose.  I create an internal procfs mount in
case the UML root user has mounted something else on /proc.  I don't want
the mconsole on the host to be faked out by that.

> uml-net-flush-on-ifup
> 	flush incoming packets on ifup -- fixes networks stalls which happen
> in
> 	case the unix socket buffer is already full when the interface is
> up'ed
> 	(due to SIGIO never signaling arrived data). 

Applied, BTW, this one is mangled on your site:
	@@ -129,6 +129,7 @@ static int uml_net_open(struct net_devic

It's in my 2.4 tree and will get moved over to 2.6 in due course.

> uml-terminal-cleanup
> 	tty / console handling cleanups.  The patchfile itself has a long
> 	description. 

I like this one, but it's big and I'm going to have to take a good look at it.
I'm somewhat unhappy about the command line change, where you need to specify
a console or UML doesn't boot.  That'll break everyone's scripts.  Is it 
possible to provide a default console if there isn't one on the command line?

> What is the status of the amd64 port?  The 2.6.4 patch on sf.net
> produces lots of rejects when I try to apply it on top of the 2.6.7
> uml patch.  Is a newer version available somewhere?  Or can I just
> ignore all the rejects (guess not)? 

It's stuck on 2.6.4 for now.  I'm going to get it caught up, but haven't
decided when yet.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
