Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzG64-0005K7-C4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 07:19:12 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzG61-0005Fm-Pi
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 07:19:12 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502092240.44915.rob@landley.net>
	<200502101231.46482.blaisorblade@yahoo.it>
In-Reply-To: <200502101231.46482.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502100916.55385.rob@landley.net>
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
Date: Thu, 10 Feb 2005 09:16:55 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Thursday 10 February 2005 06:31 am, Blaisorblade wrote:

> 2.6.9 is unusable on a >=2.6.9 host, however (yes, it's ironic), but
> 2.6.9-bs is usable in most cases (especially for SKAS mode - you Rob have
> hit some bug in TT mode, however for people using SKAS mode it's ok. And
> sadly, most people use SKAS mode, so it's often more stable).

2.6.9 was unusable on a 2.6.7 kernel as well.  (Knoppix 3.6.)

And requiring SKAS mode to use uclibc is roughly equivalent to requiring a 
kernel module in order to work.  If I could dictate the host kernel 
environment people run my stuff under, I wouldn't need UML in the first 
place.

Any idea when SKAS0 might be ready for testing?

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
