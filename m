Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeJIi-0007JX-KE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:25:08 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AeJIi-0003fJ-1j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:25:08 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401072025.02885.blaisorblade_spam@yahoo.it>
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
Date: Wed, 7 Jan 2004 20:25:02 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:34, marted=EC 6 gennaio 2004, Jeff Chua ha scritto:
> On Tue, 6 Jan 2004, Johannes Formann wrote:
> > so, now I'm done:
> > I hope this backtrave can helpt you.
>
> I just made a little patch to uml-patch-2.4.23-1. It's a modified version
> of BlaisorBlade's patch few minutes ago. Also, please ignore the patch in
> my previous email.
>
> Can you please try to see the patch below solve your problem?
Not yet looked at the code (and maybe I wouldn't be able to fix it).
However, the piece of code that I pointed out as being probably the cause o=
f=20
the problem was meant to be a fix to another problem. Try to do cat /dev/km=
em=20
with a 2.4.22-5 kernel (if you want) and you'll see your kernel panicking.

The fix maybe is not perfect but something must go in. Also, if that doesn'=
t=20
work, maybe the error is somewhere else (and triggered by this change, as=20
easily happens).

> --- uml/drivers/char/mem.c.org	Wed Jan  7 03:30:40 2004
> +++ uml/drivers/char/mem.c	Wed Jan  7 03:31:47 2004
> @@ -269,3 +269,3 @@
>  	}
> - 	*ppos =3D __pa((void *) p);
> + 	*ppos =3D p;
>   	return virtr + read;
>
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
