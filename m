Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8kVS-0007pt-Rg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 10:32:06 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B8kVS-00017W-B6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 10:32:06 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Vmlinux - linux linking stages & /proc/kallsyms
	empty
References: <200403302025.02276.blaisorblade_spam@yahoo.it>
	<200403302138.i2ULc3Ll004220@ccure.user-mode-linux.org>
In-Reply-To: <200403302138.i2ULc3Ll004220@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403312042.39776.blaisorblade_spam@yahoo.it>
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
Date: Wed, 31 Mar 2004 19:42:39 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Alle 23:38, marted=EC 30 marzo 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > This because the vmlinux link script is wrong (you rejected the  patch
> > I sent you time ago, was in the patchset). But kallsyms must contain
> > the true addresses of the kernel symbols; since they change between
> > vmlinux  and linux (if they didn't change, the second step would be
> > useless), they  cannot be correct. I think that even System.map
> > symbols do not match.
>
> I didn't reject it so much as I put it aside for the moment because I
> didn't understand it.
>
> Your explanations, then and now, make sense, so I'm going to have another
> look at it for my next 2.6 patch.

Wait a moment (maybe you already understood this but I'm not sure): what I =

suggest *now* is much *more* than the patch I had at that time - that one w=
as=20
not enough (i.e. with that you get /proc/kallsyms full, but having wrong=20
addresses)!

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
