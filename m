Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzGVQ-0006tz-7R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 07:45:24 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzGVL-0008BY-Dt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 07:45:24 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502101231.46482.blaisorblade@yahoo.it>
	<200502100916.55385.rob@landley.net>
In-Reply-To: <200502100916.55385.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101644.08326.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 16:44:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Thursday 10 February 2005 15:16, Rob Landley wrote:
> On Thursday 10 February 2005 06:31 am, Blaisorblade wrote:
> > 2.6.9 is unusable on a >=2.6.9 host, however (yes, it's ironic), but
> > 2.6.9-bs is usable in most cases (especially for SKAS mode - you Rob have
> > hit some bug in TT mode, however for people using SKAS mode it's ok. And
> > sadly, most people use SKAS mode, so it's often more stable).
>
> 2.6.9 was unusable on a 2.6.7 kernel as well.  (Knoppix 3.6.)
Hmm... ok, guess in TT mode it could be possible.
> And requiring SKAS mode to use uclibc
uclibc doesn't allow static linking? It's strange...
> is roughly equivalent to requiring a 
> kernel module in order to work.

Ok, are you able to figure out a way to copy the whole binary (+ libs) to the 
VM file and remap it from the file to arbitrary address spaces?

This is why in TT mode UML is statically linked, it's done so that we must not 
understand where libraries are located and remap them, too. I don't think 
there is a clean way (other than parsing /proc/self/maps, but that is a 
horrible kludge).

> If I could dictate the host kernel 
> environment people run my stuff under, I wouldn't need UML in the first
> place.

> Any idea when SKAS0 might be ready for testing?
You can already test it I guess, but probably it's not for production yet.

I (Wildly) guess a month could be enough, maybe... however for now you can do 
some testing in SKAS mode (the setup inside UML is not different).
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
