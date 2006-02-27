Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FDk1Y-0001Rw-LF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Feb 2006 07:10:56 -0800
Message-Id: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [uml-devel] [Announce] mountlo 0.5 - Loopback mounting in userspace
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
Date: Mon, 27 Feb 2006 16:10:38 +0100
To: fuse-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

I'm proud to announce a new version of my pet project 'mountlo', a
utility which works similarly to 'mount -o loop', but the filesystem
runs entirely in userspace.

While arguably it is quite useless, I like it because it combines some
of my favorite technologies (Linux, UML and FUSE) with very little
additional glue code.

Features:

 o safe mounting of filesystem images for unprivileged users
 o all disk-filesystem types supported in a single binary

What's new since 0.2:

 o support for partitioned disk images
 o support for mount options
 o error reporting both from mount and the kernel
 o achieves reasonable performance using SKAS0 mode of UML
 o verbose and debug modes

An i386 binary (2MB) is available at:

  http://prdownloads.sourceforge.net/fuse/mountlo-i386-0.5.tar.gz

Requirements for running the binary are:

  - FUSE kernel module.  Since 2.6.14, this is included in mainline
  - FUSE utilities (at least version 2.2).

Compiling from source needs the following components:

   - http://prdownloads.sourceforge.net/fuse/mountlo-0.5.tar.gz
   - Linux-2.6.15 kernel source
   - FUSE-2.5 or later devel package (or source installation)

Comments and bug reports are welcome.

Miklos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
