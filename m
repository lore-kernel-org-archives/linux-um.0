Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4hGF-0002ua-1W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Feb 2005 07:20:11 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D4hGE-000512-5H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Feb 2005 07:20:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502161930.55206.blaisorblade@yahoo.it>
	<opsmfxytsflfdzum@localhost.localdomain>
In-Reply-To: <opsmfxytsflfdzum@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502241731.56876.blaisorblade@yahoo.it>
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
Date: Thu, 24 Feb 2005 17:31:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>, Jeff Dike <jdike@addtoit.com>

On Saturday 19 February 2005 11:55, Vadim Abrossimov wrote:
> On Wed, 16 Feb 2005 19:30:54 +0100, Blaisorblade <blaisorblade@yahoo.it>
>
> wrote:
> > Ok, I have two more requests, if possible:
> > 1) add something like arch/um/Rules.make which is included everywhere
> > needed
> > 2) There is an error in the patch (even in Al's idea): you must swap, in
> > the below code
>
> OK. I will do it.
> Against which version you would suggest me to do it:
> - as an add-on to 2.6.11-rc3-mm2 + Jeff's tarball (which already includes
> the original USER_OBJ cleanup)
For now, against this one. The patch is still in development, so this is the 
right choice.
> - 2.6 bk
> - any other
>
> Also I have more general questions about the usual way the uml community
> works:

> - do the patches from Jeff's tarball are intended to be pushed in 2.6 BK?
> if yes when and how?
Yes, "when they are felt as ready". However the process in most cases is  
possibly (author?) -> possibly (someone, including me, forwarding it; I often 
forward patches directly to -mm) -> Jeff's tree -> -mm tree -> BitKeeper 
repository and final release.

However, there are actually some little differences between the trees that 
interact with this patch. The patch also changes some additions to the 
Makefiles done in the Jeff's tree, for instance about "skas0" and "x11-fb".

Those hunks will have to stay in the tree even after the patch is merged, 
while the rest will go with the relevant patches.

I'm finding it not trivial to port these patches from the Jeff's tree 
to the mainline tree... there are some little differences which should move 
inside a "jeff-only" part of the patch 

I'm doing the port to get it merged as soon as 2.6.12.
> - if one propose a patch against which version he/she should do it in
> order to (1) be useful for the community (2) get the patch pushed in 2.6
> BK soon? (Presumably (1) and (2) have the same answer :->)
Well, the Jeff's tree is highly experimental, so the casual user often does 
not apply the full tree, and patches can evolve in it for months, in the case 
of big rewrites (they are merged sooner if they are fixes).

Probably the better way to get the patch immediately useful is to prepare it 
against -bk or -mm... after all, normally you don't get big hunks of Jeff's 
tree merged at once.

When the patch is merged, it will need to get resync'ed against mainline 
anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
