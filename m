Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8QMu-0006OR-Jn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 13:01:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B8QMu-0001ME-1l
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 13:01:56 -0800
Message-Id: <200403302138.i2ULc3Ll004220@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 30 Mar 2004 19:25:02 +0100."
	<200403302025.02276.blaisorblade_spam@yahoo.it> 
References: <200403302025.02276.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Vmlinux - linux linking stages & /proc/kallsyms empty
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
Date: Tue, 30 Mar 2004 16:38:03 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> This because the vmlinux link script is wrong (you rejected the  patch
> I sent you time ago, was in the patchset). But kallsyms must contain
> the true addresses of the kernel symbols; since they change between
> vmlinux  and linux (if they didn't change, the second step would be
> useless), they  cannot be correct. I think that even System.map
> symbols do not match.

I didn't reject it so much as I put it aside for the moment because I didn't
understand it.

Your explanations, then and now, make sense, so I'm going to have another
look at it for my next 2.6 patch.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
