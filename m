Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3cfI-0003Ze-LD for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:59:37 -0700
Received: from fmmailgate04.web.de ([217.72.192.242])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3cfF-0007UN-8y
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:59:27 -0700
Date: Tue, 03 Jun 2008 21:59:13 +0200
Message-Id: <303013682@web.de>
MIME-Version: 1.0
From: devzero@web.de
Subject: Re: [uml-devel] [PATCH 1/6] UML - Deal with host time going backwards
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, User-mode-linux-devel@lists.sourceforge.net

>> Protection against the host's time going backwards - keep track of the
>> time at the last tick and if it's greater than the current time, keep
>> time stopped until the host catches up.
>
>Strange.  What would cause the host's time (or at least UML's perception
>of it) to go backwards?

mhh - what about admin`s/user`s stupidity ?

e.g.

0 * * * *   root  /usr/sbin/ntpdate some.time.server >/dev/null 2>&1

in root`s crontab.

if the hosts`s clock is running faster than clock on some.time.server, this=
 would set host`s clock back in time every hour or so....

common malpractice regarding time-syncronization - have seen that more than=
 once.
(and have to admit that i used that some years ago before i wasn`t aware th=
at ntpd does handle that more intelligent)


_______________________________________________________________________
EINE F=DCR ALLE: die kostenlose WEB.DE-Plattform f=FCr Freunde und Deine
Homepage mit eigenem Namen. Jetzt starten! http://unddu.de/?kid=3Dkid@mf2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
