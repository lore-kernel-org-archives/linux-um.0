Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ClqGU-0005Lu-DN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 07:06:30 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1ClqGN-0005v8-Az
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 07:06:29 -0800
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2) 
In-Reply-To: Message from "Armin M. Warda" <Armin.Warda@gmx.de> of "Tue,
	04 Jan 2005 15:05:59 +0100." <200501041506.05104.Armin.Warda@gmx.de> 
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031531.19246.Armin.Warda@gmx.de>
	<20050104115947.GA3715@bytesex>
	<200501041506.05104.Armin.Warda@gmx.de> 
Message-ID: <2928.1104850371@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Tue, 04 Jan 2005 09:52:51 -0500
To: Armin.Warda@gmx.de
Cc: Gerd Knorr <kraxel@bytesex.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Armin" == Armin M Warda <Armin.Warda@gmx.de> writes:
    Armin> I don't think the problem is in tmpfs!

    Armin> When I saw the problem for the 1st time, of cause I
    Armin> immediately blamed tmpfs and switched to a reiserfs /tmp, but
    Armin> to my surprise the problem did not go away. Finally I even
    Armin> tested an ext3 /tmp - just to be sure - and the problem was
    Armin> reproduced, too.

  This isn't a new problem to us.
  We see it regularly. In *most* cases (but I can't say *ALL*) it is
because of swap files for UMLs that are no longer running, but for which
there are T-linux processes hanging around.
  kill -9/-CONT/etc. them and the disk space comes back.
  Most of the time.

  (this relates to the thread where we read /proc/XXX/environ, and so
couldn't recognize that the processes could be killed, and also to the
thread where i complained about having to -CONT a process before it
could be -9'ed)

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQdqtwYqHRg3pndX9AQFqRwQAxkIGcI44qepaQfRF2F281fkJTcClojT4
AxKX+bS+u2yUwYz+xypF4ccr1NaK9Vx+Ez+LdbIqx67m5XgPa6Bi3lbXp0wPwjnN
TO00L33cnronUsETn6exoq/iNhI+GqaatfuNGkE3E9CWh3JqUoKzTk7Hs+3T9OJ9
IDIJYuoJ1Gk=
=qsvP
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
