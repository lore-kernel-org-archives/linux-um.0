Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVhjr-00077f-Vd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 19:13:51 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BVhjr-0004iL-IF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 19:13:51 -0700
Message-Id: <200406030302.i5332iB5030454@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] connecting to uml switch? 
In-Reply-To: Your message of "Wed, 02 Jun 2004 20:12:41 EDT."
	<C28780ABC637504896EB86B4FB75FFBFD2FE4F@MAANDMBX1.ets.enterasys.com> 
References: <C28780ABC637504896EB86B4FB75FFBFD2FE4F@MAANDMBX1.ets.enterasys.com>
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
Date: Wed, 02 Jun 2004 23:02:44 -0400
To: "Kohari, Moiz" <mkohari@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

mkohari@enterasys.com said:
> Is there a limit (under uml) to how many SOCK_STREAM sockets I can
> create and then connect() to?  I have a program that creates and
> connects sockets to the uml switch, after 12 of these connect() fails.

What version of UML?

			Jeff



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
