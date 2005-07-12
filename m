Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsNbS-0001Or-0Y	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:27:26 -0700
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsNbR-0000aZ-PO	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:27:26 -0700
Received: by rproxy.gmail.com with SMTP id b11so1069275rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jul 2005 09:27:22 -0700 (PDT)
Message-ID: <42D3EEF9.2020404@gmail.com>
From: Victor Condino <un1tz3r0@gmail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] host cpu frequency scaling and guest bogomips
References: <42D3549D.50308@gmail.com>
	<200507121756.40169.blaisorblade@yahoo.it>
In-Reply-To: <200507121756.40169.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Date: Tue, 12 Jul 2005 12:25:29 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
> Hmm, bogomips are calculated at startup and that won't change easily. However, 
> they become inaccurate in a much wider variety of situation, for instance 
> when there's some load on the host; so, using CONFIG_UML_REAL_TIME_CLOCK 
> (IIRC) uses the host clock for time calculation.
> 
> When you disable this option, I guess that a "sleep 10" when host is at 600, 
> if UML was started at 1800, might last 30 seconds more or less...

hmm... so the moral is, CONFIG_UML_REAL_TIME_CLOCK is a "good thing"(tm)
if your host is going to vary it's core freq?

- - V.C.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC0+73W5g8mX2/4TYRAvv3AJ9uA3HzbsM27evJHwUofX+1WOViMACfRL3J
AqZgxrkfanj50IaQxjdcyec=
=K/Cr
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
