Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh8F-0007hS-D7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:47 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh8E-00015P-Sh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:47 -0800
Message-Id: <200401060258.i062wYFI023092@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML + skas 
In-Reply-To: Your message of "Tue, 30 Dec 2003 19:33:31 +0100."
	<20031230183331.GB2845@carpediem.epita.fr> 
References: <20031230183331.GB2845@carpediem.epita.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 05 Jan 2004 21:58:34 -0500
To: jeremie le-hen <le-hen_j@epita.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

le-hen_j@epita.fr said:
> But it think it would not be very difficult to make some #define
> protection around theses structures to prevent from changing the
> destination of `/usr/src/linux/' to a source without the SKAS patch
> applied.

Maybe, but skas4 doesn't have this problem, and /usr/include/asm should
point to the distro kernel headers, not whatever you have sitting in 
/usr/src/linux (and if the distro put a kernel tree there, you should be
building stuff somewhere else).

Of course, this is wrong if there are distros shipping a kernel tree with
the skas patch in it (which maybe SuSE is).  In this case, some sort of
protection would be the right thing for skas3.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
