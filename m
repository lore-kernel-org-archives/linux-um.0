Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba4AV-0002aa-DC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 19:59:23 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ba4AU-00040S-Qm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 19:59:22 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [BUG] host fd leak when using hostfs
References: <c9oc52$a3$1@sea.gmane.org>
	<200406121932.43743.blaisorblade_spam@yahoo.it>
	<40CB4074.30706@upb.de>
In-Reply-To: <40CB4074.30706@upb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200406142010.03150.blaisorblade_spam@yahoo.it>
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
Date: Mon, 14 Jun 2004 20:10:03 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:42, sabato 12 giugno 2004, Sven K=F6hler ha scritto:

> >>So this should be bug in hostfs, so that hostfs doesn't close files on
> >>the host if they are closed inside the UML. Is there a fix for that
> >>already?
> >
> > Try the attached patch (for 2.6 only!), but please be very careful...
> > there could be subtle pitfall in the VFS making it have other problems.
> > However I've well understood what is the difference between 2.4 and 2.6
> > which makes the difference.


> > What is your UML version? I got the same thing with 2.6.4 patch adapted
> > onto 2.6.6 (the 2.6.6-02 distributed on my page).
>
> I think i used 2.6.6-um1 from the official download-page. I should have
> mentioned that in my first POST.

Well, I think that the patch should apply since I don't see any change to=20
hostfs in the patches. I am convinced that HPPFS also suffers from this bug=
,=20
since it too, on 2.4, used the force_delete() trick; however the matter is =

more interesting, since hppfs seem to NEVER close the host file. But I also=
=20
think that it should become another hostfs module soon.

> > for i in `find /mnt/usr/bin`; do cat $i >/dev/null; done
>
> i think even "find /mnt/usr/bin" would habe been sufficient to reproduce
> the problem.

Just checked, and as I thought, the answer is no. The problem happens only =

when opening files.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
