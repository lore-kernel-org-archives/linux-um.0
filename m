Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APU1W-0007y2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 13:50:06 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1APU1V-0004ge-Nr
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 13:50:05 -0800
Message-ID: <003501c3b531$01b30400$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <5.1.0.14.2.20031127102518.02675b90@mail.inboxprotection.com> <002101c3b52a$4a42ede0$2000000a@schlepptopp> <3FC66DC3.2010909@darkman.de>
Subject: Re: [uml-devel] Re: [uml-user] uml 2.6.0-test9 crash
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 27 Nov 2003 22:54:17 +0100
Content-Transfer-Encoding: quoted-printable
To: Sven 'Darkman' Michels <sven@darkman.de>, user-mode-linux-devel@lists.sourceforge.net

Hi !
>BTW: did you had any problems with building an uml kernel on
>9.0?
yes - i`m not able to do so, too.

>i wasn't able to get a running kernel on this box, compiling
>on another host (8.1) works fine...
IIRC, i compiled it on a redhat 7.3. Must have been my virtuozzo-
powered vserver on the internet :D

regards
roland



----- Original Message -----=20
From: "Sven 'Darkman' Michels" <sven@darkman.de>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, November 27, 2003 10:33 PM
Subject: [uml-devel] Re: [uml-user] uml 2.6.0-test9 crash


roland wrote:
> hi !=B4
> i think , i`m able to crash my uml. :(

i can't ;)


> at a second, third, fourth try, i isolated the problem a little bit:
> one or two non looped "dd if=3D/dev/zero of=3Dtest.dat bs=3D1k count=3D10=
000" just are enough
> to produce the same result.(under 2.6.0test9-skas-host and ALSO under 2.4=
.22-99-default
> suse9 host, rootfs inside uml is suse9)
>
> is anybody able to reproduce this?

not exactly:
SuSE 9.0 host, debian 3.0 uml, hostkernel: 2.4.22 with skas, uml: 2.4.22
with um6, test:
for i in $(seq 1 5); do dd if=3D/dev/zero of=3Dtest${i}.dat bs=3D1k
count=3D10000; done

The UML did the frist two dd's without problems, then it started to
hang.. i checked outside and saw the process switching states from
R to D and then back to R... so after a few secs the dd's did all
succeed and the uml is still running. So it didn't crash or so
but it also didn't play very well with that.

BTW: did you had any problems with building an uml kernel on
9.0? i wasn't able to get a running kernel on this box, compiling
on another host (8.1) works fine...

Regards,
Sven



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
