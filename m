Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkosina@suse.cz>) id 1O4H5Q-0002GZ-GS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 17:18:12 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4H5P-0002n6-8m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 17:18:12 +0000
Date: Tue, 20 Apr 2010 19:18:04 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <20100420165225.GA31439@c-98-229-117-200.hsd1.ma.comcast.net>
Message-ID: <alpine.LNX.2.00.1004201917520.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<74c7d668690f283cf3b8aed92004dc72e872f7ce.1271713955.git.jan.kiszka@web.de>
	<20100420083358.GD4356@cr0.nay.redhat.com>
	<alpine.LNX.2.00.1004201635050.7579@pobox.suse.cz>
	<20100420165225.GA31439@c-98-229-117-200.hsd1.ma.comcast.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/5] uml: Drop private round_down definition
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, 20 Apr 2010, Jeff Dike wrote:

> > > Shouldn't this signal.c #include <linux/kernel.h>?
> > 
> > Well, it gets included implicitly through uaccess.h -> sched.h -> 
> > kernel.h.
> 
> You're depending on the internal details of uaccess.h and sched.h.  If
> either of them changed, then this would cause unexpected compile
> failures here.
> 
> Better to explicitly include kernel.h.

Yeah, I have that already in my tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

