Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zkeK-0004jG-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 15:19:48 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zkeH-0006Tj-TC
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 15:19:46 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8HMB5j04421
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 18:11:06 -0400
Message-Id: <200309172220.h8HMKGNu021271@ccure.karaya.com>
Subject: Re: [uml-devel] Re: Problem with 2.4.22-um4 
In-Reply-To: Your message of "Wed, 17 Sep 2003 16:30:57 -0000."
             <BAY7-F101ZIhTrBoe2U000001de@hotmail.com> 
References: <BAY7-F101ZIhTrBoe2U000001de@hotmail.com> 
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
Date: Wed, 17 Sep 2003 18:20:16 -0400
To: Steve Schmidtke <steve_schmidtke@hotmail.com>, Ross Combs <rocombs@cs.nmsu.edu>
Cc: User-mode-linux-devel@lists.sourceforge.net

steve_schmidtke@hotmail.com said:
> rocombs@cs.nmsu.edu wrote: 
> > I see a problem in the file though it probably isn't causing any 
> > problems right now.  Doesn't the variable got_sigio need to be 
> > marked volatile?
>
> I vote yes. 

Me too.  Fixed in my pool.

			Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
