Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By7Rv-0006AF-Qa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:20:47 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1By7Rv-00058r-14
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:20:47 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [patch] mconsole_proc rewrite (and crash fix).
Message-ID: <20040820110817.GA21170@bytesex>
References: <20040719204008.GA15091@bytesex>
	<200408111957.40575.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408111957.40575.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Aug 2004 13:08:17 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Wed, Aug 11, 2004 at 07:57:40PM +0200, BlaisorBlade wrote:
        ^^^^^^
Did the mail really travel that long, or is your clock broken?

> Actually the exec command cannot send anything to the mconsole, but since it 
> invokes sh -c it allows for redirections to new consoles.

Having the output go directly to mconsole is much easier to handle
through.

> > The old code had the problem that the kernel crashed after calling
> > "uml_mconsole proc <somefile>" a few times.  I havn't tracked what
> > exactly causes the problem, I guess trying to access the procfs without
> > actually mounting it somewhere causes some corruption of kernel data
> > structures.
> 
> Who said that he didn't have mounted /proc inside the guest?

Code looks like that, as it uses get_filesystem and all that instead of
doing a simple /proc/... path lookup.  What is the point of doing it
that way, other than make it work even if procfs is not mounted below
/proc?

> However, I see basically two bugs:
> 1) why put_filesystem is not called at the end?

It is called earlier, right after ->get_sb() call.  Which looks sane to
me, as a successfull get_sb() should increase the refcount and thus
releasing the filesystems afterwards should be safe.  I'm no VFS expert
through.

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
