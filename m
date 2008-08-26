Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY3Wo-0008Sb-9T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:44:31 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KY3Wl-0003a4-OW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:44:29 -0700
Date: Tue, 26 Aug 2008 14:44:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080826184425.GA18462@c2.user-mode-linux.org>
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
	<20080826174600.GA24342@c2.user-mode-linux.org>
	<48B44658.8010403@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48B44658.8010403@meduna.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 26, 2008 at 08:07:20PM +0200, Stanislav Meduna wrote:
> My host is current Ubuntu and I was unable to test 2.6.25.x
> there due to
>   Locating the top of the address space ... Address 0x0 no good?
> which AFAIK was a known problem caused by some ubuntu-specific
> patch.

You can work around this by putting a 0 into /proc/sys/vm/mmap_min_addr.

> 2.6.26 crashes here with

This one is fixed in 2.6.26.2, as you note below.

> 2.6.26.2 has no problems.
>
>> In an earlier email, you provide a nice test case.  However, I'm
>> running that here, and getting page after page of successful key
>> generation.
>
> Same here with 2.6.26.2 :(

Hmmm.  If it's not a problem there, I'm tempted to call it fixed,
whatever it was.  Can you check current 2.6.27-rc?

	    	      	  	Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
