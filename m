Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Armlc-0007I7-2o
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 15:30:40 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Armjd-000374-5H
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 15:28:37 -0800
Message-Id: <200402132355.i1DNtjsq004236@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] First shrinkage of *_user.c files 
In-Reply-To: Your message of "Wed, 21 Jan 2004 20:19:02 +0100."
             <200401212019.02494.blaisorblade_spam@yahoo.it> 
References: <200401202026.19785.blaisorblade_spam@yahoo.it>  <200401212019.02494.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 18:55:45 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> The next thing I'm going to do is to remove entirely
> hostaudio_user.c (I've already started this, but I've not got a
> successful test yet, since I also did a little fix in this). 

I finally merged this.  Now we are one file closer to being able to get
rid of the USER_OBJS crap :-)

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
