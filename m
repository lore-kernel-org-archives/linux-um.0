Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ike1U-0003No-HL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 04:03:40 -0700
Received: from brick.kernel.dk ([87.55.233.238] helo=kernel.dk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ike1S-0007CU-9d
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 04:03:40 -0700
Date: Wed, 24 Oct 2007 13:03:23 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Message-ID: <20071024110323.GO14671@kernel.dk>
References: <alpine.LFD.0.999.0710232057080.30120@woody.linux-foundation.org>
	<20071024081047.GC2464@hacking>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071024081047.GC2464@hacking>
Subject: Re: [uml-devel] [Git Patch] arch/um/drivers/ubd_kern.c: fix a
	building error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, jdike@karaya.com, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 24 2007, WANG Cong wrote:
> 
> Fix this uml building error:
> arch/um/drivers/ubd_kern.c: In function 'do_ubd_request':
> arch/um/drivers/ubd_kern.c:1118: error: implicit declaration of function 'sg_page'
> arch/um/drivers/ubd_kern.c:1118: warning: passing argument 6 of 'prepare_request' makes pointer from integer without a cast
> make[1]: *** [arch/um/drivers/ubd_kern.o] Error 1
> make: *** [arch/um/drivers] Error 2
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks, applied!

-- 
Jens Axboe


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
