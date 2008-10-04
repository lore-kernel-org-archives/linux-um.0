Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.boullis@ecp.fr>) id 1KmA8T-0002M3-Br
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 16:37:41 +0000
Received: from jaguar.ecp.fr ([138.195.33.9])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KmA8M-0005Rr-G5 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 16:37:41 +0000
Message-ID: <20081004183731.cajymruq1vwocwks@webmail.ecp.fr>
Date: Sat, 04 Oct 2008 18:37:31 +0200
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
References: <48CA7158.5080500@ecp.fr> <48CE23E5.4070308@ecp.fr>
	<48E4CDE3.9090502@ecp.fr>
	<20081004042815.GA18807@c2.user-mode-linux.org>
In-Reply-To: <20081004042815.GA18807@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello,

Quoting Jeff Dike <jdike@addtoit.com>:

> Sorry about the lack of responsiveness.

No problem, I'm glad to read you now.


> I've had such a patch for quite a while.  I never stuck it in mainline
> because I couldn't find any common use cases where it made a noticable
> difference.
>
> Does your patch help noticably with anything reasonable common?

It did help significantly for me.
On a reasonably new host, using as UBD devices logical volumes built  
on top of a FC SAN, building a 10GB ext3 filesystem took something  
like 50 seconds before my patch, and something like 3 seconds after  
it. (I can check the exact values if you wish.)
Note that this is using CONFIG_UBD_SYNC (or whatever it is called);  
without it it gets even faster (but I guess parallel I/O make no  
difference).

My feeling is that it might improve performance when reads and writes  
are performed simultaneously, but I have not made any try.

As for using CONFIG_UBD_SYNC, my feeling is that it's much safer if  
the host might crash (or experience power outages, or...): as far as I  
understand it, journaled filesystems need to know when data is  
actually secured on the discs.


Hope this helps,

Nicolas Boullis
Ecole Centrale Paris


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
