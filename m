Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL62B-0007Vn-TJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 12:56:55 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BL61h-0005qf-4u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 12:56:25 -0700
Message-Id: <200405042039.i44KdPkI003888@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] hppfs file descriptor leak? 
In-Reply-To: Your message of "Wed, 05 May 2004 01:01:20 +0900."
	<20040505003813.3D86.SBUML-DELETETHISPART@zar.att.ne.jp> 
References: <1083601512.6946.6.camel@dan>
	<200405040221.i442L2ml026618@ccure.user-mode-linux.org>
	<20040505003813.3D86.SBUML-DELETETHISPART@zar.att.ne.jp> 
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
Date: Tue, 04 May 2004 16:39:25 -0400
To: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Cc: Dan Eaton <Dan.Eaton@rlx.com>, user-mode-linux-devel@lists.sourceforge.net

sbuml-deletethispart@zar.att.ne.jp said:
> In run_helper() in helper.c, fds[0] is never closed.  Could this be
> it? 

Nice spotting, but hppfs doesn't use the helper stuff at all.

BTW, those functions were also racy, fds[1] could be closed before the child
was execed.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
