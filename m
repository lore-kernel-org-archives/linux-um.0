Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iz7l3-0007hI-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 01:38:34 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iz7kz-00081E-OL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 01:38:33 -0800
Message-ID: <4753CE8E.9030305@bytesex.org>
Date: Mon, 03 Dec 2007 10:38:22 +0100
From: Gerd Hoffmann <kraxel@bytesex.org>
MIME-Version: 1.0
References: <4752C626.4050000@nagafix.co.uk>
In-Reply-To: <4752C626.4050000@nagafix.co.uk>
Subject: Re: [uml-devel] uml FB
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

Antoine Martin wrote:
> This would allow the guest to have a framebuffer and if we need to
> actually see its contents, it could easily be exposed using shared
> memory. This would completely de-couple the framebuffer from the host,
> allowing us to attach/detach as needed: start session, detach, log out
> of X, log in, attach to guest framebuffer (although this doesn't address
> the mouse/keyboard issue).
Havn't looked at it for ages.  Should be doable though.  Note just some
shared memory area isn't enougth, you need also some channel for screen
updates (guest->host) and mouse/kbd events (host->guest).  One possible
approach would be coding up a vnc server, so you can use any vnc client
to see the uml framebuffer and talk to the virtual machine.  This would
also allow remote access to the display.  uml-x11-fb never worked with a
remote display, probably because it grooks when it can't write to the
X11 socket buffer, which quickly happens without the MIT-SHM extention.

cheers,
  Gerd


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
