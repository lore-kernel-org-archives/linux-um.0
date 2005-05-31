Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dd7OG-0001HS-74	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 07:06:44 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dd7OE-0004MR-B9	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 07:06:44 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Slower system call with SMP
Message-ID: <20050531135731.GA9909@ccure.user-mode-linux.org>
References: <29D15BBCA340DA4D8146D38B4924FC7A105057@zcarhxm0.corp.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A105057@zcarhxm0.corp.nortel.com>
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
Date: Tue, 31 May 2005 09:57:31 -0400
To: Majid Salame <msalame@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> The cost of a system call it seems to be higher when
> Running a RHE host with dual CPU (SMP turned on) and the image is patched
> with skas patch.
> 
> Doe that make sense ? Doing the same test by disabling SMP on the host, and
> results are much faster.

What exactly was the test?  A getpid loop?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
