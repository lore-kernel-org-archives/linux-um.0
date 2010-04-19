Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkosina@suse.cz>) id 1O3xKN-0005Ru-PC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 20:12:19 +0000
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O3xKL-0007mt-Ev
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 20:12:19 +0000
Date: Mon, 19 Apr 2010 22:12:04 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <4BCCB89C.50201@web.de>
Message-ID: <alpine.LNX.2.00.1004192211140.7579@pobox.suse.cz>
References: <4BCB353A.3040806@web.de> <4BCB788E.2040501@kernel.org>
	<4BCC07C0.5050601@web.de>
	<alpine.LRH.2.00.1004191829220.28179@twin.jikos.cz>
	<4BCCB89C.50201@web.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] uml: Fix build breakage after slab.h changes
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Tejun Heo <tj@kernel.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 19 Apr 2010, Jan Kiszka wrote:

> >>> I suppose this patch will go through um tree?
> >> Good question. Does such a tree exist? I'm sitting on a few more um
> >> cleanups & fixes, and so far I'm working against Linus' tree as I failed
> >> to find anything more recent.
> > 
> > If these are simple-enough cleanups and/or compile fixes, feel free to 
> > send them to trivial@kernel.org.
> > 
> Some are trivial, but most aren't. Will check if I can split the formers
> out, but I guess it's simpler to keep the queue.

Well, if Jeff isn't actively maintaining UML any more, either you can take 
over the maintainership yourself, or feed the non-trivial patches through 
Andrew Morton.

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

