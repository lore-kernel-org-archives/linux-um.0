Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zeHL-0007xt-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 08:31:39 -0700
Received: from [128.123.64.160] (helo=hongkong.cs.nmsu.edu ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zeHK-0000p2-7s
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 08:31:38 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309171531.h8HFVT54015182@hongkong.cs.nmsu.edu>
Subject: [uml-devel] Re: Problem with 2.4.22-um4
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
Date: Wed, 17 Sep 2003 09:31:29 -0600
To: User-mode-linux-devel@lists.sourceforge.net


Patrick,

You are running into a different problem than the ubd_user stuff.

Somehow your host kernel is returning an error on tty read.  It looks
like the error might be "Permission denied".  You can try changing
the sigio_user.c::tty_output() function to look like this at the end:

        ...
        else if(n == -EAGAIN) printk("No, enabling workaround\n");
        else printk(KERN_ERR "check_sigio : slave read failed, err = %d\n", -n);

(Basically change the last like from a panic to a printk and negate
the variable n.)

I see a problem in the file though it probably isn't causing any
problems right now.  Doesn't the variable got_sigio need to be marked
volatile?

-Ross


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
