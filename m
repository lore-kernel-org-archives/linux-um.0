Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOMgT-0002Tr-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 24 Nov 2003 11:47:45 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AOMgS-0006C0-Ep
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 24 Nov 2003 11:47:44 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Cann't startup network read of data failed, err = -35
References: <19785.1069699339@www12.gmx.net>
In-Reply-To: <19785.1069699339@www12.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311242050.13146.blaisorblade_spam@yahoo.it>
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
Date: Mon, 24 Nov 2003 20:50:13 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:42, luned=EC 24 novembre 2003, Thonix@gmx.net ha scritto:
> Hi all,
>
> I created a new kernel 2.422-6um now I make a call:
>
> linux ubd0=3D/root/uml-ubd/Debian-3.0r1.reiser eth0=3Dtuntap,,,10.1.100.17
> mem=3D128M
>
> now i get this error message while the netzwork initialisation:
>
> Setting up IP spoofing protection: rp_filter.
> Configuring network interfaces: read_output - read of data failed, err =3D
> -35 SIOCSIFFLAGS: Operation not permitted
> eration not permitted
> read_output - read of data failed, err =3D -35
> SIOCSIFFLAGS: Operation not permitted
Provide that on the host /usr/bin/uml_net is setuid; you obviously must hav=
e=20
installed the Uml tools.
>
> Pleas help me ....
>
> Thankx
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
