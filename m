Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wmpb-0002Vn-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 11:03:11 -0700
Received: from gate.in-addr.de
	([212.8.193.158] helo=mx.in-addr.de ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wmpa-0003wg-Ie
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 11:03:10 -0700
From: Lars Marowsky-Bree <lmb@suse.de>
Message-ID: <20030909180126.GC10485@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] "Kernel panic: Segfault with no mm"
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
Date: Tue, 9 Sep 2003 20:01:26 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

with the UML kernel on 2.4.21 I am seeing the above. I can trigger it by
a NULL pointer dereference in the kernel (ie, my buggy code / module
;-).

Instead of a regular panic, I get the above. It appears something is
going astray with the mm handling.

#0  panic (fmt=3D0xa01b8ad2 "Segfault with no mm") at panic.c:59
#1  0xa00af3b4 in segv (address=3D1074944004, ip=3D2706132208, is_write=3D0=
,=20
    is_user=3D0, sc=3D0xa1468280) at trap_kern.c:119
#2  0xa00af866 in segv_handler (sig=3D11, regs=3D0xa1468280) at trap_user.c=
:69
#3  0xa00b351c in sig_handler_common_tt (sig=3D11, sc_ptr=3D0x58) at trap_u=
ser.c:37
#4  0xa00af990 in sig_handler (sig=3D1, sc=3D
      {gs =3D 0, __gsh =3D 0, fs =3D 0, __fsh =3D 0, es =3D 43, __esh =3D 0=
, ds =3D 43, __dsh =3D 0, edi =3D 2694189056, esi =3D 2694189056, ebp =3D 2=
705767004, esp =3D 2705766988, ebx =3D 4294967295, edx =3D 0, ecx =3D 27057=
66824, eax =3D 2706243584, trapno =3D 13, err =3D 0, eip =3D 2706132208, cs=
 =3D 35, __csh =3D 0, eflags =3D 66118, esp_at_signal =3D 2705766988, ss =
=3D 43, __ssh =3D 0, fpstate =3D 0x0, oldmask =3D 436281344, cr2 =3D 107494=
4004})
    at trap_user.c:104
#5  <signal handler called>

I wonder whether anyone has seen that before or whether it is something
peculiar to my setup. (Which also includes the aa patches for the VM)


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
