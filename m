Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iyq9J-00086A-JQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Dec 2007 06:50:25 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iyq9I-0000ns-6u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Dec 2007 06:50:25 -0800
Message-ID: <4752C626.4050000@nagafix.co.uk>
Date: Sun, 02 Dec 2007 14:50:14 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] uml FB
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
Cc: Gerd Knorr <kraxel@bytesex.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Been looking at the uml-x11-fb patch again.
It still does apply more or less cleanly, but won't build (can't get
Kbuild to play nice) and I was thinking: wouldn't it be easier to just
drop all the X11 stuff and have just a plain in-memory VESA type of
framebuffer in the guest (straightforward contiguous memory region).
This would allow the guest to have a framebuffer and if we need to
actually see its contents, it could easily be exposed using shared
memory. This would completely de-couple the framebuffer from the host,
allowing us to attach/detach as needed: start session, detach, log out
of X, log in, attach to guest framebuffer (although this doesn't address
the mouse/keyboard issue).
Is this (easily) feasable at all?

Thanks
Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUsYmGK2zHPGK1rsRCpt9AJ40otwE6ziQDIpR6u0/ImQYFsFcegCfe5Jw
Q6XhYv6RkGb11AVZ/aZBB5c=
=xdpn
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
