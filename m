Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQPQ-0007d2-D1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:49:28 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQPO-0003TB-Ll	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:49:28 -0700
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <20050606224201.1557CFD31@sc8-sf-spam2.sourceforge.net>
References: <20050606224201.1557CFD31@sc8-sf-spam2.sourceforge.net>
Content-Type: text/plain
Message-Id: <1118098104.10147.38.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.12-rc5-mm2-patches20050605 build issues, run
	issues, backtrace
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
Date: Mon, 06 Jun 2005 23:48:23 +0100
To: William Stearns <wstearns@pobox.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> [uml-devel] 2.6.12-rc5-mm2-patches20050605 build issues, run issues, backtrace
> 
> Good afternoon, all,
>  	Trying to build 2.6.5-rc5-mm2 on x86_64.  This is with all the 
> patches in Jeff's quilt tarball from 20050605:
> 
> fs/externfs/externfs.c:20:23: 2_5compat.h: No such file or directory
> make[2]: *** [fs/externfs/externfs.o] Error 1
> make[1]: *** [fs/externfs] Error 2
> make: *** [fs] Error 2

You are missing at least one patch, apply all of them except the testing
one (which does not apply cleanly anyway)

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
