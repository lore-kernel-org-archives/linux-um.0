Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AN0nN-0007KU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 18:13:17 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AN0nL-0000Na-Lr
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 18:13:16 -0800
Message-Id: <200311210222.hAL2Mw4L004150@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] further scheduling weirdness 
In-Reply-To: Your message of "Thu, 20 Nov 2003 13:12:15 PST."
             <000201c3afaa$fed85f40$6801a8c0@nexxus> 
References: <000201c3afaa$fed85f40$6801a8c0@nexxus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 20 Nov 2003 21:22:58 -0500
To: sean whalen <swhalen@denature.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

swhalen@denature.org said:
> This is simply due to a schedule_timeout call in a module.  Does
> anyone have any ideas on this?  It seems to critical a function to
> actually be broken. 

That BUG is "scheduling in interrupt".  So if your module is doing anything
that could sleep, like that schedule(), in an interrupt handle, it should
stop.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
