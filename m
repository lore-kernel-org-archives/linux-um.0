Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRrbz-0007Hg-TM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 04:57:51 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRrbz-0008Jq-7h for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 04:57:51 -0700
Message-ID: <078401c440be$2adff220$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <008701c43e76$686ec750$2000000a@schlepptopp>
	<200405231217.52945.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Re: [uml-user] tip: suse 9.1 live eval with skas
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
Date: Sun, 23 May 2004 14:04:52 +0200
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

hi!

first, it looked very much the same to http://www.user-mode-linux.org/~blai=
sorblade/patches/host-skas3-2.6.3-v1.patch
- but it seems to differ significantly especially at linux-2.6.0/arch/i386/=
kernel/ldt.c

suse 9.1 kernel source is at: ftp://ftp.suse.com/pub/suse/i386/9.1/suse/src=
/kernel-source-2.6.4-52.src.rpm

regards
roland







----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: <user-mode-linux-user@lists.sourceforge.net>
Cc: "roland" <for_spam@gmx.de>
Sent: Sunday, May 23, 2004 12:17 PM
Subject: Re: [uml-user] tip: suse 9.1 live eval with skas


Alle 16:26, gioved=EC 20 maggio 2004, roland ha scritto:
> Hi !
> if you don`t have a system with skas-patched kernel and don`t want to risk
> a kernel update but you want to give uml with skas a try, you can use suse
> 9.1 live eval-cd. it has a skas patched 2.6.4 kernel "out of the box".
>
> ftp://ftp.suse.com/pub/suse/i386/live-cd-9.1/LiveCD-9.1-01.iso
>
> so - just boot from this cd, mount your hdd-partition containg uml and the
> root_fs and start it "under" suse 9.1.
>
> the only caveat is, that this live-cd doesn`t contain the uml-utilities.
> maybe you can setup the path variables appropriately, to point to your
> uml-utilities on the mounted hdd-partition. didn`t try this yet.
>
> regards
> roland
Has anyone a pointer to check the source RPM of their kernel? I want to che=
ck
what 2.6 SKAS patch they use, to see if they fixed any bug and if they use =
an
up-to-date one.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3Dick
_______________________________________________
User-mode-linux-user mailing list
User-mode-linux-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
