Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyFFT-0006Zv-Hk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 11:08:11 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AyEkn-00068G-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 10:36:29 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: problems with UML, issues with includes
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
In-Reply-To: <4044A368.8050406@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403021906.20474.blaisorblade_spam@yahoo.it>
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
Date: Tue, 2 Mar 2004 19:06:20 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Friesen <cfriesen@nortelnetworks.com>

Alle 16:08, marted=EC 2 marzo 2004, Chris Friesen ha scritto:
> Jeff Dike wrote:
>
> Maybe I'm just confused about how the various things get compiled.  In a
> normal kernel build, including <linux/sched.h> gets you the kernel
> headers, not the libc headers.

> I had assumed that I would be able to get
> at the UML kernel's sched.h from within the arch/um code.  Is this a
> false assumption?  Or am I just doing it wrong?

Inside arch/um, there are some files which can include *only* the kernel=20
includes, and some files which can include *only* the libc includes;=20
os/file.c is of the second type. In the directory Makefile, the files liste=
d=20
in USER_OBJS are of the second type:

USER_OBJS :=3D $(foreach file,file.o process.o tty.o,$(obj)/$(file))
i.e. file.o is listed. Note this idiom:

 USER_OBJS :=3D $(filter %_user.o,$(obj-y) $(obj-m)) fd.o ...

the $(filter ) part means a "grep" for *_user.o: i.e. every file ending in =

_user.c is compiled against libc headers.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
