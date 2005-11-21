Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeD2B-0003rB-0p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 06:52:43 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EeD29-00070D-70
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 06:52:43 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511182126.22095.rob@landley.net>
	<87hda65mbv.fsf@amaterasu.srvr.nix>
In-Reply-To: <87hda65mbv.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511210851.20951.rob@landley.net>
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
Date: Mon, 21 Nov 2005 08:51:20 -0600
To: Nix <nix@esperi.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, mmazur@kernel.pl

On Monday 21 November 2005 04:25, Nix wrote:
> On Fri, 18 Nov 2005, Rob Landley wrote:
> > On Friday 18 November 2005 20:33, Blaisorblade wrote:
> >> Btw, why hasn't maszur went to post patches to kernel headers to make
> >> them includable from userspace instead of merging kernel changes into
> >> his headers (which is much more work)?
> >
> > For the same reason the glibc guys don't ship a patch against the kernel
> > headers but ship cleaned upkernel headers.  It's much smaller and
> > simpler, and the patch would break with every single release.  Besides,
> > the patch isn't what we need to build libc, the cleaned up headers are. 
> > It would add an unnecessary level of indirection and _never_ get merged
> > into the main kernel?
>
> One problem is that Mariusz's linux-libc-headers work seems to have
> stalled :( the last headers out there are for 2.6.12, and increasingly much
> (e.g. iptables) needs to be pointed directly at the kernel headers again.
>
> I hope linux-libc-headers isn't dead. It looked like it was turning into
> a very good aggregation point, with patches coming in from Ubuntu and RH
> among others.

Hopefully he won't mind me quoting from his email on Nov 4th.  Project's not 
dead, he's just busy with Real Life (tm):

> I'm also CCing Wojtek Cieciwa (cieciwa@pld-linux.org), since he's one of the 
> guys that need a new llh release and I should be releasing 2.6.14.0 right 
> about now (my world kind of collapsed a few days ago and I'm out of the 
> picture for don't know how long; I hope to be able to recover within a week, 
> but who nows how things will work out; keep me CCed though).

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
