Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHvDD-0005pv-0I	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 20:23:59 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EHvDA-0008VE-LW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 20:23:59 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [uml-devel] Re: [patch 1/2] Fixup symlink function pointers for
	hppfs [for 2.6.13]
Message-ID: <20050921032353.GU7992@ftp.linux.org.uk>
References: <20050826145749.03BFE24D661@zion.home.lan>
	<200508262204.43683.blaisorblade@yahoo.it>
	<20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk>
	<200509181400.35765.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181400.35765.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 04:23:53 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 02:00:35PM +0200, Blaisorblade wrote:
> On Friday 26 August 2005 23:48, Al Viro wrote:
> > On Fri, Aug 26, 2005 at 10:04:43PM +0200, Blaisorblade wrote:
> > > And beyond that what? I cannot even think what's the rest *. And
> > > "obvious" doesn't hold with me.
> Al, while at it, can I get a bit of help from you?
> 
> We have a commented out version of 
> arch/um/drivers/mconsole_kern.c:mconsole_proc(), which is supposed to read 
> the contents of procfs from the internal kernel mount, rather than /proc (to 
> avoid being faked out by hppfs).
> 
> As remarked in comments, that code is broken (run on the host uml_mconsole 
> <umid> proc <filename>, which will call that code, for 4-5 times gives you an 
> oops inside UML). Can you help with that?

nd.mnt is what?  NULL?  There's your oops.

Grab fs/nfsctl.c::do_open() and s/nfsd/proc/g in there.  FWIW, it's probably
better off in libfs.c with fs type as argument...  For now, just copy it -
it's trivial and small enough; when I move the sucker to libfs, we'll
switch to that.  And lose that deactivate_super(), obviously - you won't
be touching superblock anymore.

And for pity sake, 

	...
		goto out;
	...
out: ;
}

is spelled
	...
		return;
	...


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
