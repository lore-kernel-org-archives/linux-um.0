Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zl73-0000GN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 15:49:29 -0700
Received: from bay7-f115.bay7.hotmail.com ([64.4.11.115] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zl72-0002jx-P6
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 15:49:28 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] compile error ...(now tracked down)
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F115B33UKyM25I00015854@hotmail.com>
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
Date: Wed, 17 Sep 2003 22:48:58 +0000
To: jdike@addtoit.com, blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

>blaisorblade_spam@yahoo.it said:
> > # define st_atime st_atim.tv_sec        /* Backward compatibility.  */
>	...
> >                 .st_atime   = src->st_atime,   /* time of last access */
>
>This is just because of the names of the struct uml_stat.  Changing those
>field names should fix the compile problem.

Yup, there are a few ways sub-second file timestamps are handled:

  http://mail.gnu.org/archive/html/bug-gnulib/2003-08/msg00183.html

I'm not going to pick one at this time. :)  I'll send Jeff another
patch that renames the entries and references to ust_*.  I also see a few 
stat() references in the code I can stomp right now.

Steve

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
