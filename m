Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AH7tN-0007aM-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 12:35:09 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AH7tM-0008PY-Ce
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 04 Nov 2003 12:35:08 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Partitioning scheme for ubd's
References: <200311041921.09084.blaisorblade_spam@yahoo.it> <20031104195247.GW9377@dijkstra.csh.rit.edu>
In-Reply-To: <20031104195247.GW9377@dijkstra.csh.rit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311042138.00969.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 4 Nov 2003 21:38:00 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:52, marted=EC 4 novembre 2003, Matt Zimmerman ha scritto:

> The command line, I think, accepts both for backward compatibility.
Backward compatibility is ok. If CLI accepts both, we are ok. Only docs don=
't=20
seem up-to-date.
> The
> device file names, of course, are a userland concern.  Current versions of
> makedev, at least in Debian, use the new scheme.
>
> > > > The other possible solution(which would be
> > > > cleaner) would be to teach, if possible, to the host kernel Device
> > > > Manager to read a file as a bunch of partition with its table(I've
> > > > heard of DM about COW files these days), and then to mount the
> > > > partitions, but I don't know if it's possible.
> >
> > Would instead this one(or another way to do this) be interesting? So th=
at
> > the kernel could guess by itself the offsets of partitions, rather than
> > requiring the user do more passages(i.e. use fdisk to read partition
> > table) to handle this.
>
> I suppose the solution to this would be partition support on loop devices.
> Is this any easier in 2.6?
I've not yet looked at the code, but anyway 2.6 is just cooler, and with=20
better Makefiles... so if I **ever** do this, I'll do it in 2.6.

About 2.6, are you still interested in the mconsole_exec patch? I could por=
t=20
it to 2.6, and in that case, probably I could even add the managing of=20
stdin/out/err to a console/serial line. in 2.4 exec_usermodehelper closes a=
ll=20
open files(I didn't want to duplicate it, the patch was not meant as a toy)=
,=20
in 2.6 it's probably simpler.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
