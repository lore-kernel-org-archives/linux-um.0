Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUjr-0001Ol-T1
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:24:27 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATUjq-0003rr-39
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:24:26 -0800
Message-Id: <200312082338.hB8NcCAv030482@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: Your message of "Mon, 08 Dec 2003 22:29:40 +0100."
             <Pine.LNX.4.44.0312082224010.14902-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0312082224010.14902-100000@filer.marasystems.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 08 Dec 2003 18:38:11 -0500
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

hno@marasystems.com said:
> With this there is various kernel-dependent programs such as
> iptables, strace etc which needs to be built.

How are these kernel-dependent (in the sense that they have to be built against
a UML /usr/include/asm or they won't work under UML)?

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
