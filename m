Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRrFR-0000ex-PN for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 04:34:33 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BRrFR-0003fb-8B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 04:34:33 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] CVS not updated?
References: <20040518180259.GC29114@ccure.user-mode-linux.org>
	<Pine.LNX.4.44.0405182131440.10300-100000@filer.marasystems.com>
	<20040518220017.GA29646@ccure.user-mode-linux.org>
In-Reply-To: <20040518220017.GA29646@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200405231337.30401.blaisorblade_spam@yahoo.it>
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
Date: Sun, 23 May 2004 13:37:30 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, Henrik Nordstrom <uml@hno.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 00:00, mercoled=EC 19 maggio 2004, Jeff Dike ha scritto:
> On Tue, May 18, 2004 at 09:42:13PM +0200, Henrik Nordstrom wrote:
> > >From the error message I think you are missing a "anonymous" system us=
er
> >
> > or a suitable mapping in your CVS password file to another suitable
> > system user..
> >
> > The CVS password file format is
> >
> > login:[password][:unixuser]
> >
> > if the unixuser is not specified the login is used..
> >
> > Example for anonymous CVS with pubcvs as the UNIX user
> >
> >   anonymous::pubcvs
>
> Thanks for your help.  It looks like it works now.
Not here:
cvs -d :pserver:anonymous@www.user-mode-linux.org:/cvsroot/user-mode-linux l
ogin

refuses any password I can type (including the empty one).

cvs -d :pserver:anonymous@www.user-mode-linux.org:/cvsroot/user-mode-linux =

checkout doc/web/cl
answers:

/cvsroot/user-mode-linux: no such repository

even when I try from inside ssh blaisorblade@www.user-mode-linux.org. Howev=
er,=20
I used :ext: and my login name and it worked (though the site content is a =

bit out-of-date).

I would suggest to write, on the server, a script which checks out everythi=
ng=20
from the CVS repository and rebuilds it; then you commit the new site, run =

the script from the server and it should work perfectly + the site would=20
always be up-to-date.

By the way, onto=20
http://user-mode-linux.sourceforge.net/compile.html
there is still a link to the old repository. (I know I could fix it now, by=
=20
asking you to update then the site, but I've no time right now + you need t=
o=20
do something anyway).

Good bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
