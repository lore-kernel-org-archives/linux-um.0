Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba4E9-0003GA-V7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:03:09 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ba4E9-0007C3-Fx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:03:09 -0700
Message-Id: <200406150354.i5F3sBFm025995@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [SYSEMU] New benchmarks results 
In-Reply-To: Your message of "Sun, 13 Jun 2004 23:50:14 +0200."
	<1087163413.1260.111.camel@chartreuse> 
References: <200406121616.26839.blaisorblade_spam@yahoo.it>
	<1087163413.1260.111.camel@chartreuse> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 14 Jun 2004 23:54:11 -0400
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, roland <for_spam@gmx.de>

LaurentVivier@wanadoo.fr said:
> Could you explain where we lost :
> w/o SYSEMU
> real - (user+sys) 5m13.144s 5m10.549s 5m12.002s 
> w/ SYSEMU
> real - (user+sys) 3m02.705s 3m08.483s 3m01.044s 

Somewhere in the host kernel.  Given this, it would seem that real is a better
measurement than user+sys on an unloaded system since user+sys leaves out the
host kernel.

What you really want is time on the host, except covering only the benchmark
period rather than the period from boot to halt.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
