Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6coC-0006Zz-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:22:24 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6coA-00040v-Hp
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:22:24 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LCEj06720
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:12:14 -0400
Message-Id: <200310062124.h96LOIGj020827@ccure.karaya.com>
Subject: Re: [uml-devel] uml failes to build with pcap enabled 
In-Reply-To: Your message of "Tue, 30 Sep 2003 23:51:35 +0200."
             <045401c3879d$06745b90$6f01a8c0@alex> 
References: <045401c3879d$06745b90$6f01a8c0@alex> 
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
Date: Mon, 06 Oct 2003 17:24:18 -0400
To: Alexander Newald <alexander@newald.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

alexander@newald.de said:
> I've tried to use uml with pcap but I fail to build the linux binary.
> I used a clean sorce of kernel 2.4.22 from kernel.org and the
> corresponding patch from the uml site. 

pcap is one of the lesser-used transports, and requires some build strangeness.

I don't know what's going on here, but I added it to mylist.

				Jeff


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
