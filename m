Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cpG-0006hx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:23:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cpE-00049z-7t
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:23:28 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LDEj06761
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:13:14 -0400
Message-Id: <200310062125.h96LPHGj020860@ccure.karaya.com>
Subject: Re: [uml-devel] (no subject) 
In-Reply-To: Your message of "Fri, 03 Oct 2003 16:51:00 +0200."
             <34131.81.0.169.41.1065192660.squirrel@pluto.nixia.no> 
References: <34131.81.0.169.41.1065192660.squirrel@pluto.nixia.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 06 Oct 2003 17:25:17 -0400
To: stian@nixia.no
Cc: user-mode-linux-devel@lists.sourceforge.net

stian@nixia.no said:
> I'd like to share memory between the uml-kernel and a user-space util
> (some megabytes).
> I'd like this to be a file-descriptor that is mmap'ed in both
> processes. What is the most nice way to do this?

Use iomem, which does pretty much what you want.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
