Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmHPt-00020X-MJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 12:33:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BmHPt-0004x1-4q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 12:33:45 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml_mconsole issue
References: <IFEIKNDOLFNCKMGAENCFEEIECHAA.Anthony_Brock@ous.edu>
	<200407122036.i6CKa3Ys001604@ccure.user-mode-linux.org>
In-Reply-To: <200407122036.i6CKa3Ys001604@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407182134.30301.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jul 2004 21:34:30 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 22:36, luned=EC 12 luglio 2004, Jeff Dike ha scritto:
> Anthony_Brock@ous.edu said:
> > (gdb) bt
> > #0  0xa00730df in link_path_walk (name=3D0xa0a59ca9 "uptime",
> > nd=3D0xa3fd3aa4) at fs/namei.c:591
>
> This is known, and I haven't got around to fixing it yet.
What about calling directly the inline version of read() from asm/unistd.h =

(something like kernel/kmod.c calling execve())? I also think that someone =

would kill you for such code duplication. Or not?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
