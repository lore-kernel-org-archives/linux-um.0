Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xjTU-0005RF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 01:40:16 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xjTT-00060o-VQ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 01:40:16 -0700
References: <Pine.GSO.4.21.0309111733190.1879-100000@vervain.sonytel.be>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <Pine.GSO.4.21.0309111733190.1879-100000@vervain.sonytel.be>
Message-ID: <878you2xu2.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: pthreads?
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
Date: 12 Sep 2003 10:52:05 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> I'm working on a virtual frame buffer device for UML that displays in a GDK/GTK
> window.

What is the point of using gdk?  I'd go with Xlib for that, if all you
need is just a X11 window to blit the vitual framebuffer to IMHO isn't
worth the trouble involved when using gdk/gtk.  You just don't need
all the fancy stuff provided by the toolkit ...

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
