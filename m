Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ujpP-0004P5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 19:26:31 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ujpO-0003K8-Ti
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 19:26:31 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h842J6j17189
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Sep 2003 22:19:11 -0400
Message-Id: <200309040229.h842TiFs009493@ccure.karaya.com>
Subject: Re: [uml-devel] vmware vmmon and skas 
In-Reply-To: Your message of "Wed, 03 Sep 2003 23:05:31 +1000."
             <20030903130531.GB8159@zipworld.com.au> 
References: <20030903130531.GB8159@zipworld.com.au> 
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
Date: Wed, 03 Sep 2003 22:29:44 -0400
To: Andrew Steele <fozzy@zip.com.au>
Cc: user-mode-linux-devel@lists.sourceforge.net

fozzy@zip.com.au said:
> Based on what I saw in other files I simply added a new first argument
> 	current->mm 

I haven't looked at the actual patch, but that's basically right.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
