Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQZCa-0006PR-Nf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 15:06:16 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQZCa-0001TG-3y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 15:06:16 -0700
Message-ID: <032901c43dee$7da4a730$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <c7aquk$trh$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Re: [uml-user] best way for init-script to start/stop UML
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
Date: Thu, 20 May 2004 00:13:18 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-user@lists.sourceforge.net, =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

> How can i gracefully halt a UML-machine? Is there something more simular
i think changing the cad-handler in /etc/inittab would do the trick:
in line:
ca::ctraltdel...
change
"-r" to "-h"

then you should be able to shutdown your uml with "uml_mconsole cad"

imho, it should be possible to issue init-commands to a running uml via uml=
_mconsole, to switch uml guest systems to whatever
init-level we like. is such feature existing or being planned ?

regards
roland



----- Original Message -----=20
From: "Sven K=F6hler" <skoehler@upb.de>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Wednesday, May 05, 2004 3:41 PM
Subject: [uml-user] best way for init-script to start/stop UML


> hi,
>
> i'm about to write some init-scripts that are supposed to start/stop UML
> machines if the computer started/stopped. I think i can easily start the
> UML-kernel, but stopping it is a problem for me.
>
> I can imagine to do it with mconsole, since there is a halt-command, but
> after the issuing the halt-command in mconsole, the UML-kernel stopps
> running immediatly. I worry about the filesystems of the UML-machine
> that might get damaged.
>
> How can i gracefully halt a UML-machine? Is there something more simular
> to the issuing a halt-command inside the UML?
>
> Since using mconsole is kind of tricky, i'd like to use the
> old-fashioned way with signals. What about SIGINT, SIGTERM, etc.
> Is it safe to send any of those to the UML-kernel? Is any of the signals
> simular to mconsole's halt-command?
>
> Another way could be to send the halt-command directly to the
> UNIX-Socket that mconsole would use. Is there any way of soing that from
> the command-line?
>
> Thx
>    Sven
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
