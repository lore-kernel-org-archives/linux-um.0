Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cz6AJ-0001di-3G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 20:42:55 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cz6AH-0001dm-4s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 20:42:54 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
In-Reply-To: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502092240.44915.rob@landley.net>
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
Date: Wed, 9 Feb 2005 22:40:44 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: bugzilla-daemon@gentoo.org

On Wednesday 09 February 2005 10:38 am, bugzilla-daemon@gentoo.org wrote:
> ------- Additional Comments From dsd@gentoo.org  2005-02-09 07:38 PST
> ------- Could someone please update me with the status of this bug? Are
> there still problems?
>
> I notice that the latest version in portage is based on 2.6.8.1. Would
> upgrading to a newer version (assuming there are newer releases) help at
> all?

I believe it was fixed in 2.6.11-rc3-bk2 or thereabouts, but I personally 
would prefer to hold off closing it until 2.6.11 actually ships.  The UML in 
2.6.10 didn't build, 2.6.9 was unusable out of the box, and 2.6.11-rc3 
introduced _new_ build breakage on top of what -rc2 had because Linus just 
doesn't test it.

If the UML in 2.6.11-final works, consider the bug resolved.

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
