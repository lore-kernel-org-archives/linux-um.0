Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzCZ0-0002Wp-BT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:32:50 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzCYz-0006W5-Mp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:32:50 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502092240.44915.rob@landley.net>
In-Reply-To: <200502092240.44915.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101231.46482.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 12:31:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Thursday 10 February 2005 04:40, Rob Landley wrote:
> On Wednesday 09 February 2005 10:38 am, bugzilla-daemon@gentoo.org wrote:
> > ------- Additional Comments From dsd@gentoo.org  2005-02-09 07:38 PST
> > ------- Could someone please update me with the status of this bug? Are
> > there still problems?
> >
> > I notice that the latest version in portage is based on 2.6.8.1. Would
> > upgrading to a newer version (assuming there are newer releases) help at
> > all?
>
> I believe it was fixed in 2.6.11-rc3-bk2 or thereabouts, but I personally
> would prefer to hold off closing it until 2.6.11 actually ships.  The UML
> in 2.6.10 didn't build, 2.6.9 was unusable out of the box, and 2.6.11-rc3
> introduced _new_ build breakage on top of what -rc2 had because Linus just
> doesn't test it.
>
> If the UML in 2.6.11-final works, consider the bug resolved.
>
> Rob

Both 2.6.9 and 2.6.10 are more or less usable out of the box (although I'd not 
recommend 2.6.10 because various UML fixes were merged just *after* the  
release).

2.6.9 is unusable on a >=2.6.9 host, however (yes, it's ironic), but 2.6.9-bs 
is usable in most cases (especially for SKAS mode - you Rob have hit some bug 
in TT mode, however for people using SKAS mode it's ok. And sadly, most 
people use SKAS mode, so it's often more stable).

About the problem itself, I've already explained everything on bugzilla... and 
especially, nothing is fixed for TT mode on a NPTL-only Gentoo host, nor I 
know how to fix that (except by releasing a stable glibc which is built the 
correct way, i.e. with NPTL in /lib/tls and normal version in /lib - the 
current ebuild for this is correctly marked unstable).
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
