Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQIVD-00053c-EI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 02:06:47 -0700
Received: from wr-out-0506.google.com ([64.233.184.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQIVC-00005t-SI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 02:06:47 -0700
Received: by wr-out-0506.google.com with SMTP id 60so1923956wri.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 05 Aug 2008 02:06:46 -0700 (PDT)
Date: Tue, 5 Aug 2008 10:05:02 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080805090502.GA3039@hack.voiplan.pt>
References: <20080801224125.GA13727@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080801224125.GA13727@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 1/14] uml: fix build when SLOB is enabled
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
To: Jeff Dike <jdike@addtoit.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, stable@kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

On Fri, Aug 01, 2008 at 06:41:25PM -0400, Jeff Dike wrote:
From 94409ded7768e15b0d0a5a172d611073c72308de Mon Sep 17 00:00:00 2001
>
>Reintroduce uml_kmalloc for the benefit of UML libc code.  The
>previous tactic of declaring __kmalloc so it could be called directly
>from the libc side of the house turned out to be getting too intimate
>with slab, and it doesn't work with slob.
>
>So, the uml_kmalloc wrapper is back.  It calls kmalloc or whatever
>that translates into, and libc code calls it.
>
>kfree is left alone since that still works, leaving a somewhat
>inconsistent API.
>
>Signed-off-by: Jeff Dike <jdike@linux.intel.com>
>Cc: WANG Cong <xiyou.wangcong@gmail.com>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Looks good. Thanks. :)


-- 
The opposite of love is not hate, but indifference.
	--Elie Wiesel

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
