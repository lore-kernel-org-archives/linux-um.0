Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkosina@suse.cz>) id 1O4EVh-0004HA-R0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 14:33:09 +0000
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4EVg-0000Em-Ff
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 14:33:09 +0000
Date: Tue, 20 Apr 2010 16:33:01 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <e89d636e305d095f5919c0e22cf92159c4067018.1271713955.git.jan.kiszka@web.de>
Message-ID: <alpine.LNX.2.00.1004201632500.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<e89d636e305d095f5919c0e22cf92159c4067018.1271713955.git.jan.kiszka@web.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 5/5] uml: Clean up asm/system.h
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
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 19 Apr 2010, Jan Kiszka wrote:

> Remove duplicates and unused prototypes.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@web.de>

Applied, thanks.

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

