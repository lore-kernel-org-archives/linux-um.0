Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.boullis@ecp.fr>) id 1KmqBI-0003Ob-UW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Oct 2008 13:31:24 +0000
Received: from jaguar.ecp.fr ([138.195.33.9])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kmq8i-0002V9-P5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Oct 2008 13:31:24 +0000
Message-ID: <48EA1285.9050806@ecp.fr>
Date: Mon, 06 Oct 2008 15:28:37 +0200
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
MIME-Version: 1.0
References: <48CA7158.5080500@ecp.fr>
	<48CE23E5.4070308@ecp.fr>	<48E4CDE3.9090502@ecp.fr>	<20081004042815.GA18807@c2.user-mode-linux.org>
	<20081004183731.cajymruq1vwocwks@webmail.ecp.fr>
In-Reply-To: <20081004183731.cajymruq1vwocwks@webmail.ecp.fr>
Subject: Re: [uml-devel] parallel I/O
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Hi,

Nicolas Boullis wrote:
> On a reasonably new host, using as UBD devices logical volumes built  =

> on top of a FC SAN, building a 10GB ext3 filesystem took something  =

> like 50 seconds before my patch, and something like 3 seconds after  =

> it. (I can check the exact values if you wish.)

Hmmm... my memory was making thing much better than they really are.
It's around 38 seconds with 2.6.18 (before the "batch I/O requests"
change); it's several minutes with unpatched 2.6.24, and it's around 7
seconds with patched 2.6.24...

To be more honnest, my patch contains a part similar to Steve
VanDeBogart's "ubd does multiple io's when one will suffice" patch.
Using 2.6.24 with his patch but still serialized I/O, the time is around
23 seconds.

Hence, my patch (with 16 threads per device) make things around 3 times
faster.


Cheers,

Nicolas Boullis
=C9cole Centrale Paris

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
