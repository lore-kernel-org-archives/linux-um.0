Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4isQ-0004M9-LF for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 07:59:10 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B4isI-0001Ih-NO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 07:59:02 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] /dev/kmem panic in SKAS mode
References: <Pine.LNX.4.44.0403190013140.32344-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0403190013140.32344-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403201706.26725.blaisorblade_spam@yahoo.it>
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
Date: Sat, 20 Mar 2004 17:06:26 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <hno@marasystems.com>, Jeff Dike <jdike@addtoit.com>

Alle 00:37, venerd=EC 19 marzo 2004, Henrik Nordstrom ha scritto:
> On Thu, 18 Mar 2004, BlaisorBlade wrote:

[... about the /dev/kmem - copy_to_user fix ]
> Found the thread, but not sure what needs to be changed. On the 4/3 Jeff
> mentioned the fault_catcher and some wrapping of the guts in copy_user to
> fix this problem, but no code ;-)

> Anyway, for now I can live without klogd in this environment, but it would
> be nice to have this issue fixed. Is this problem planned to be fixed in
> the 2.4 tree, or only the 2.6 tree?

I think Jeff just didn't yet release a new 2.4 patch, since the reasoning=20
applies to both  - anyway he'll have a better answer.

About this, there was also the need for a patch to mainline (mentioned in t=
he=20
same thread); I sent it to LKML and Andrew Morton, but only for 2.6 (it has=
=20
been corrected a lot by Andrew Morton and sent to Linus for inclusion); 2.4=
=20
still lacks the fix (as of 2.4.25).

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
