Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCiVI-0008Qc-5l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:30:28 -0800
Received: from one.firstfloor.org ([213.235.205.2] ident=ingen)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCiVH-0001CW-LW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:30:28 -0800
Date: Wed, 9 Jan 2008 22:32:58 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20080109213258.GC15612@one.firstfloor.org>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<p734pdmput0.fsf@bingen.suse.de>
	<E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] uml and -regparm=3
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org, harvey.harrison@gmail.com

On Wed, Jan 09, 2008 at 10:20:49PM +0100, Miklos Szeredi wrote:
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> > =

> > > FASTCALL is defined empty in -mm, but UML is not compiled with
> > > -mregparm=3D3 and so this breaks things (I noticed problems with
> > > rwsem_down_write_failed).
> > >
> > > Tried recompiling UML with -mregparm=3D3, but that resulted in a stra=
nge
> > > failure immediately after startup:
> > >
> > > |%G=EF=BF=BD%@: Invalid argument
> > >
> > > What's up?
> > =

> > UML links with glibc and that does not use -mregparm. =

> > =

> > You can only use -mregparm in user space if you recompile
> > all libraries too.
> =

> Ah, right.  I didn't think of that.
> =

> Does that mean that FASTCALL removals will have to be undone?  Or is
> there an alternative?

FASTCALL is useless and should not make a difference. It enables
regparm on specific functions, but that should not make a difference
if it works or not.

For working -mregparm you will need asmlinkage on all
functions that interface with assembler code to disable regparms for them.
The only exception is system calls which have the arguments on the stack
too.

-Andi

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
