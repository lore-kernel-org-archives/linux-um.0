Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASPkG-0000kw-Te
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:24 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ASPkE-0002gQ-OW
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:22 -0800
Message-Id: <200312060005.hB605LAv008258@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Linux 2.6.0-test10 
In-Reply-To: Your message of "Sun, 23 Nov 2003 21:47:17 CST."
             <011101c3b23d$aa41e420$fd01000a@bp> 
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org>  <011101c3b23d$aa41e420$fd01000a@bp> 
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
Date: Fri, 05 Dec 2003 19:05:21 -0500
To: Brad Parker <parker@citynetwireless.net>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

parker@citynetwireless.net said:
> I get this trying to compile for the user-mode-linux arch: 

> include/asm/arch/system.h:7: asm/cpufeature.h: No such file or directory 

Linus hasn't taken any patches from me in a long time, so you need to apply
a separate UML patch which brings the Linus tree up to date.  Until I get
a test10/test11 patch ready, the test9 patch seems to work OK with a small
tweak.

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
