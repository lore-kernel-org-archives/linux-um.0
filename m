Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200404081123.i38BN0B6001871@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 08 Apr 2004 08:58:38 BST."
	<Pine.LNX.4.58.0404080857520.928@bitch.localdomain> 
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0404080857520.928@bitch.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] A quick humfs HOWTO
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
Date: Thu, 08 Apr 2004 07:23:00 -0400
To: Rus Foster <rghf@fsck.me.uk>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

rghf@fsck.me.uk said:
> Anyone else getting /usr/include/linux/aio_abi.h not found or is it
> just me?

It's not just you.  Move the include inside the #ifdef HAVE_AIO_ABI.

If you have a 2.6 host and you want to use the new aio stuff, copy aio_abi.h
from a 2.6 kernel tree (include/linux) to /usr/include/linux.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
