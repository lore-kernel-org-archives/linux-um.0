Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0NCd-0001eT-UA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 12:20:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0NCb-0000i6-7S
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 12:20:11 -0800
Date: Thu, 6 Dec 2007 15:19:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206201929.GA9366@c2.user-mode-linux.org>
References: <20071206170640.GA7420@c2.user-mode-linux.org>
	<20071206114642.555a0749.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071206114642.555a0749.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Customize tlb.h
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Dec 06, 2007 at 11:46:42AM -0800, Andrew Morton wrote:
> > +void flush_tlb_mm(struct mm_struct *mm)
> > +{
> > +	struct vm_area_struct *vma = mm->mmap;
> > +
> > +	if (atomic_read(&mm->mm_users) == 0)
> > +		return;
> 
> Under which circumstances does this test succeed?

Sigh, none.  The other copy obviously succeeds during exit - this one
isn't needed.

> This file rather needs an inclusion of percpu.h.  I guess you got
> lucky.

Yup, drop this, and I'll send a fixed version.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
