Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xmfn-0000Lr-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 05:05:11 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xmfm-00026y-PX
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 05:05:10 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20030912121525.GA16925@bytesex.org>
References: <20030912110805.GA16252@bytesex.org> <Pine.GSO.4.21.0309121311060.2312-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309121311060.2312-100000@vervain.sonytel.be>
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
Date: Fri, 12 Sep 2003 14:15:25 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

>   - The rate at which the display is updated

Ok.

>   - The visual type (it's in fb_fix_screeninfo, so the user cannot specify it)
>   - The frame buffer layout (it's in fb_fix_screeninfo), to e.g. debug code for
>     bitplanes

Uh?  Can a fb driver change them without fbcon becoming greatly confused?  I think
it is in fix for a reason ...

> GdkRgb allows to easily draw 8 bpp pseudocolor or grayscale, and 24 or 32 bpp
> RGB, and display it on whatever X server you have available.

For debugging various modes that makes sense, althrough it probably
isn't exactly fast ...

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
