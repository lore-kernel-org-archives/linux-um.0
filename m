Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJ4YH-0003mf-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 00:02:13 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJ4YH-0004XA-4M
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 00:02:13 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] 2.6.9-bs7 panic on check_sysemu
References: <4250729B.7040407@rimuhosting.com>
	<200504051323.47160.rob@landley.net>
	<200504052255.39254.blaisorblade@yahoo.it>
In-Reply-To: <200504052255.39254.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504060059.04907.rob@landley.net>
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
Date: Wed, 6 Apr 2005 00:59:04 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 05 April 2005 04:55 pm, Blaisorblade wrote:

> > Speaking of which, I ask this from time to time:
> >
> > What's the minimal patch set that _just_ adds -SKAS0 mode to something
> > like a 2.6.11 kernel?  I'd like to try it out, but every time I sit down
> > to whack at it my interest budget runs out sifting through a mountain of
> > unrelated x86-64 patches to try to figure out what exactly I need to
> > apply to get just SKAS0...
>
> Also, I forgot: during your development work use SKAS. It doesn't give any
> big difference visible inside the Virtual Machine (except for bugs).

I'm trying out the build on various different systems: knoppix, red hat, suse, 
debian.  In some cases running on borrowed machines, in other cases running 
on a knoppix boot cd.  (I care because I'm using the host tools, which vary 
slightly from system to system.)

You just suggested that I replace the kernels on all of these systems, 
(including other people's machines, and the bootable CD that uses a kernel 
with the cloop patch applied and an initramfs that's hard to extract) with a 
different kernel.  Just so I'm testing something faster that's not actually 
what I'm going to be deploying.

If I was going to replace the host kernel and run on a modified system, I'd 
just A) replace it with the version I actually need, B) run the build as root 
and use chroot instead of UML.

I'm interested in SKAS0 because it's potentially deployable.  Any SKAS that 
requires a modified host kernel is not, for my purposes.

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
