Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Byqhu-0002gw-PV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 04:40:18 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Byqht-0008G4-45
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 04:40:18 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040822111745.GA10736@bytesex>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
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
Date: Sun, 22 Aug 2004 13:17:46 +0200
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 20, 2004 at 03:01:40PM -0400, Jeff Dike wrote:
> kraxel@bytesex.org said:
> > uml-core-on-panic
> > 	Make the uml kernel dump core on kernel panics for later analysis.
> > 	Default: off, there is a kernel cmd line arg to enable that. 
> 
> I like this, but I think it would be better done in a panic_notifier.

I'll have a look.

> > uml-fix-mconsole-proc
> > 	fix kernel crash triggered by running "uml_mconsole <umid> proc
> > <some-file>"
> > 	multipole times. 
> 
> I didn't do it this way on purpose.  I create an internal procfs mount in
> case the UML root user has mounted something else on /proc.  I don't want
> the mconsole on the host to be faked out by that.

I guessed that from reading the code already ;)

I'm happy with any other fix for the kernel crash as well.  I'm no VFS
expert through and don't know what exactly is wrong in the original
code.  I know that my version has the drawback that it depends on procfs
actually being mounted on /proc, but it's better that than being able to
kill the kernel by calling "uml_mconsole proc <file>" a few timers ;)

> > uml-terminal-cleanup
> 
> I like this one, but it's big and I'm going to have to take a good look at it.
> I'm somewhat unhappy about the command line change, where you need to specify
> a console or UML doesn't boot.  That'll break everyone's scripts.  Is it 
> possible to provide a default console if there isn't one on the command line?

See Geert's and my other mail.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
