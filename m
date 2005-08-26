Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8ja2-0004Ue-3g	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 12:09:34 -0700
Received: from silver.veritas.com ([143.127.12.111])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E8ja1-0005GJ-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 12:09:34 -0700
From: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <200508262023.29170.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0508262000530.8803@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection
	support (for UML), try 3
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
Date: Fri, 26 Aug 2005 20:11:20 +0100 (BST)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 26 Aug 2005, Blaisorblade wrote:

> This is a followup to my post of last week (Aug 12) about remap_file_pages 
> protection support. I've improved and consolidated the patches and updated 
> them against 2.6.13-rc6/rc7 (the same patches apply against both versions).
> I'm sending the full patch series only to akpm, mingo and LKML.
> 
> I've also reduced them to only 18, and made the splitting more significant. 
> I'm not resending all the patches for foreign architectures, because they're 
> almost unchanged since last time (there's just a trivial reject from ppc32, 
> because one change has already been done after -rc4).
> 
> I'm working on this to provide support for UML, which currently easily creates 
> more than 64K (the default limit) vma's for a single process. Actually, it 
> needs one VMA per each page. So, with this patch and specific UML support, 
> which Ingo wrote and which I'm porting to recent UMLs.

I'll try to take a look sometime next week - or, if I wait until
next Friday, can we expect it to have come down to 9 patches ;-?

I should say, my initial reaction is very much like Andi's last week.

sys_remap_file_pages solves a real problem, but it does so by breaking
lots of rules.  For more than a year after it came in, almost every
development we tried in mm would come up against "but then what do we
do about the nonlinear mappings?".

That has settled down now, but I don't look forward to extending it.
On the other hand, UML does deserve better support.

Hugh


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
