Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg5XZ-0004oK-13 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:40:05 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg5XY-0007K6-OI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:40:04 -0700
Message-Id: <s0e3ea28.088@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Problems compiling 2.4 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
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
Date: Thu, 01 Jul 2004 10:40:09 -0700
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Okay, I found my problem. My problem was attempting to compile using:

make ARCH=3Dum

rather than:

make linux ARCH=3Dum

The compile is running as I type. Like an idiot, I keep forgetting to look =
at my prior notes. It appears that I encountered and resolved this issue ov=
er three months ago.

This change resolves the symlink issue in addition to several others (I did=
 try manually creating the link earlier, but still had problems).

Tony


>>> BlaisorBlade <blaisorblade_spam@yahoo.it> 07/01/04 10:36AM >>>
Alle 18:43, gioved=EC 1 luglio 2004, Jeff Dike ha scritto:
> Anthony_Brock@ous.edu said:

The problem is another: uml Makefile don't manage properly the=20
include/asm/arch symlink, and it is not created:

> asm/arch/posix_types.h: No such file or directory
To workaround this:
cd include
<make sure that asm points to asm-um>
cd asm
ln -s ../asm-i386 arch

There is a lot of other people claiming similar problems. For instance,=20
somebody else complained that to build UML he must avoid doing "make mrprop=
er=20
ARCH=3Dum" because some files are not recreated (with 2.4.24-3).

However, Anthony, I would recommend using, for optimal stability, a 2.4.26 =

vanilla kernel patched with 2.4.24-1um + the attached patch.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
