Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xlwt-00046B-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 04:18:47 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xlws-0008R1-5R
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 04:18:46 -0700
Subject: Re: [uml-devel] Re: pthreads?
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <Pine.GSO.4.21.0309121104430.2312-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0309121104430.2312-100000@vervain.sonytel.be>
Content-Type: text/plain
Message-Id: <1063365483.13933.0.camel@henrik.marasystems.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: 12 Sep 2003 13:18:04 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

fre 2003-09-12 klockan 11.07 skrev Geert Uytterhoeven:

> GdkRgb is nice for displaying pictures, without having to care about X server
> visuals, etc. I.e. I need to write less code.  And I want a few buttons to
> control the fbdev behavior.
> 
> BTW, it's libX11 that needs libpthread...

What about running the X11 stuff in a helper and using mmap to map the
framebuffer data in both the UML and the helper process?

Regards
Henrik
-- 
Henrik Nordstrom <hno@marasystems.com>
MARA Systems AB



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
