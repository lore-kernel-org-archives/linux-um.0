Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bezea-0003Lf-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 10:10:48 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BezeZ-0003tJ-Pg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 10:10:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Hi people. A kernel bug in the vanilla kernel
References: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no>
	<40C99B22.2010709@auto.ucl.ac.be>
	<1081.83.109.37.51.1086955616.squirrel@nepa.nlc.no>
In-Reply-To: <1081.83.109.37.51.1086955616.squirrel@nepa.nlc.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406271912.46828.blaisorblade_spam@yahoo.it>
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
Date: Sun, 27 Jun 2004 19:12:46 +0200
Content-Transfer-Encoding: quoted-printable
To: stian@nixia.no, user-mode-linux-devel@lists.sourceforge.net

Alle 14:06, venerd=EC 11 giugno 2004, stian@nixia.no ha scritto:
> Thanks people. If the world was perfect the code should run forever
> without problems, but floating point exception is better than machine
> freeze as happens outside UML on all machines tested except one by my
> buddies.
Well, about running without problems I disagree... the "floating point=20
exception" is the correct behaviour: since with UML on 2.6 it reports so an=
d=20
on 2.4 there is no error message, we have a (little) bug, indeed, in Uml 2.=
4.

Links about why that is correct behaviour:
http://lwn.net/Articles/89002/

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
