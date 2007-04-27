Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhSGC-0002RW-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 08:21:24 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhSGA-0001QD-TZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 08:21:24 -0700
Message-ID: <463214E7.5080605@nagafix.co.uk>
Date: Fri, 27 Apr 2007 16:21:11 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
	<200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
In-Reply-To: <20070427151051.GB6019@c2.user-mode-linux.org>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Jeff Dike wrote:
> On Thu, Apr 26, 2007 at 04:12:40PM +0200, Blaisorblade wrote:
>> If there are so many interfaces and they were just reordered, this could be 
>> caused by a (non-existant) change in link order. Or (I don't know how) it 
>> could derive some way from the fact that interfaces are initialized later 
>> (instead of __initcall, late_initcall is now used).
> 
> No, there's a database of interface names and MAC addresses somewhere.
> Distros have started making sure that ethx is always the same device
> by making sure that it always has the same MAC.  So when a device
> shows up with a different MAC, it gets a new name.
Question remains as to why the mac address was the same until 2.6.20 and
is now different.

> 
> The easiest way to work around this is to provide a MAC on the UML
> command line.
Except, pcap doesn't have the option.
I am looking at pcap_user.c and pcap_kern.c trying to figure out where I
can add parsing for that.

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMhTmGK2zHPGK1rsRCkwAAJ0TPF5I088YhGv1QHQWhe5wmnsWwACfSLk2
e1tMjWEtWYMJDQ33vGqQUIg=
=ljCV
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
