Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpfFp-0003Of-El for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 20:37:21 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BpfFo-0005Kv-VZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 20:37:21 -0700
Message-Id: <200407280435.i6S4ZEfL008747@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Off by one error in umid.c 
In-Reply-To: Your message of "Thu, 15 Jul 2004 18:51:26 PDT."
	<40F7349E.7010109@jimpick.com> 
References: <40F7349E.7010109@jimpick.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 28 Jul 2004 00:35:14 -0400
To: Jim Pick <jim@jimpick.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

jim@jimpick.com said:
> Here's a fix for a little memory corruption I was having.  I was
> passing  in a uml_dir directory without a trailing slash. 

Nice spotting.

		Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
