Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL2Mn-0003XN-NV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 09:01:57 -0700
Received: from smtp2.att.ne.jp ([165.76.15.138])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL2MJ-0000U9-FR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 09:01:27 -0700
From: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Subject: Re: [uml-devel] hppfs file descriptor leak?
In-Reply-To: <200405040221.i442L2ml026618@ccure.user-mode-linux.org>
References: <1083601512.6946.6.camel@dan>
	<200405040221.i442L2ml026618@ccure.user-mode-linux.org>
Message-Id: <20040505003813.3D86.SBUML-DELETETHISPART@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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
Date: Wed, 05 May 2004 01:01:20 +0900
To: Jeff Dike <jdike@addtoit.com>
Cc: Dan Eaton <Dan.Eaton@rlx.com>, user-mode-linux-devel@lists.sourceforge.net


In run_helper() in helper.c, fds[0] is never closed.  Could this be it?

When debugging sbuml, I had to add this line:

--- helper.c.org	Wed May  5 00:46:40 2004
+++ helper.c	Wed May  5 00:47:18 2004
@@ -100,6 +100,8 @@
 		pid = -errno;
 	}
 
+	os_close_file(fds[0]);  // for sbuml...  Is this a uml bug?
+
 	if(stack_out == NULL) free_stack(stack, 0);
         else *stack_out = stack;
 	return(pid);



change_tramp() in net_user.c also does not close fds[0].

These are in 2.4.23-2.
I don't know if these are related to hppfs, but it may show the pattern
to look for in other code.

--Richard

> Dan.Eaton@rlx.com said:
> > It seems that each access to /proc entries that I am spoofing from the
> > host results in an open file that never gets closed.  I am looking at
> > it via gdb but any insight that anyone has would be greatly
> > appreciated.
> 
> First I've heard of it, but I'm not too surprised.  The thing to do to
> track it down is see what file descriptors are being lost by looking at
> /proc/<uml-pid>/fd.  It should be pretty obvious.
> 
> I'll take a look at it when I get a chance.
> 
> 				Jeff
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
