Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai4c6-0007n0-QM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:32:42 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ai4c6-0005Le-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:32:42 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [uml-user] /dev/anon available
Message-ID: <20040118045439.GE8571@ccure.user-mode-linux.org>
References: <200401130510.i0D5AlS4026784@ccure.user-mode-linux.org>
	<200401172048.47847.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401172048.47847.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 23:54:39 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 17, 2004 at 08:48:47PM +0100, BlaisorBlade wrote:
> I've given a look to the page, but yet I cannot see (this can be for my fault, 
> but I'd really like an explaination of this) why you couldn't just mmap 
> /dev/zero with MAP_PRIVATE to get the behaviour you want to get from 
> /dev/anon (or maybe using MAP_ANONYMOUS). 

Because when you map a /dev/zero page, modify it, then map it (i.e. the same
offset and the same fd) again someplace else, you don't get the modifications.
You get a page full of zeros.   This obviously breaks the UML VM system.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
