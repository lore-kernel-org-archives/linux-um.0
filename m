Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vLoX-0007xG-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 12:00:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vLoV-0001yi-QY
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 12:00:08 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h85Iqbj03445
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 5 Sep 2003 14:52:37 -0400
Message-Id: <200309051900.h85J09dM017914@ccure.karaya.com>
In-Reply-To: Your message of "Thu, 04 Sep 2003 05:11:11 -0000."
             <BAY7-F82eujjeHdzXT60000f1c9@hotmail.com> 
References: <BAY7-F82eujjeHdzXT60000f1c9@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: cleanup file io
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
Date: Fri, 05 Sep 2003 15:00:08 -0400
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

steve_schmidtke@hotmail.com said:
> i.e. wrap bare file functions into their os_* counterparts, and remove
>  unnecessary references to errno? 

I'd love such a patch.

> Also, is there a style reason some functions like the one above return
> -1  rather than -errno or the failed (negative) return value from the
> os_*  functions?  I'd like to standardize one style or the other while
> I'm at it,  if that's workable. 

I'd like to stick to the convention that success == 0, failure == -errno.
I just fixed a bug with os_seek_file that resulted from a misunderstanding
between me and myself on that issue.

				Jeff


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
