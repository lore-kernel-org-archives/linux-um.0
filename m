Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3bXx-0006tA-VK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 07:29:43 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3bXp-0006Ft-Mo for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 07:29:36 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
In-Reply-To: <1094299889.7716.36.camel@localhost>
Message-ID: <Pine.LNX.4.61.0409041625430.16231@filer.marasystems.com>
References: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
	<1094299889.7716.36.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"; format="flowed"
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
Date: Sat, 4 Sep 2004 16:29:04 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: Dominik =?ISO-8859-1?Q?J=FCrgens?= <dcdom@gmx.de>
Cc: p g <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Sat, 4 Sep 2004, Dominik [ISO-8859-1] J=FCrgens wrote:

> But why does anyone use the /bin/sh in any script, when he wants to use
> the bash? That is in my opinion a very bad fault!!

/bin/sh is by UNIX standard a "UNIX compatible shell". It does not need to =

be bash, but it needs to implement the UNIX standard shell syntax.

So any shell script using the UNIX shell syntax should be using /bin/sh

Any shell script explicitly written for bash only shold be using /bin/bash

Assuming /bin/sh understands bash specific extensions to the UNIX shell=20
syntax is wrong.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
