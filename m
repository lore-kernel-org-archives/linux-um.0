Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tj@kernel.org>) id 1O3m8x-0006bH-FC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 08:15:47 +0000
Received: from hera.kernel.org ([140.211.167.34])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O3m8v-0004EE-WC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 08:15:47 +0000
Message-ID: <4BCC11FC.50802@kernel.org>
Date: Mon, 19 Apr 2010 17:19:08 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
References: <4BCB353A.3040806@web.de> <4BCB788E.2040501@kernel.org>
	<4BCC07C0.5050601@web.de>
In-Reply-To: <4BCC07C0.5050601@web.de>
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
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On 04/19/2010 04:35 PM, Jan Kiszka wrote:
> Good question. Does such a tree exist? I'm sitting on a few more um
> cleanups & fixes, and so far I'm working against Linus' tree as I failed
> to find anything more recent.

Well, in that case, I'll route this one through percpu.

Thanks.

-- 
tejun

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

