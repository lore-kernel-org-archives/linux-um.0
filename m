Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyXIA-0007jp-CU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 07:28:42 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CyXI8-0000Bs-Oa for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 07:28:42 -0800
Message-Id: <200502081746.j18Hkds0002747@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Why is UML built static all the time? 
In-Reply-To: Your message of "Tue, 08 Feb 2005 02:03:53 EST."
	<200502080203.53596.rob@landley.net> 
References: <200502080203.53596.rob@landley.net> 
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
Date: Tue, 08 Feb 2005 12:46:39 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

rob@landley.net said:
> Is there any easy way to get UML to do a dynamic build?  I tried
> removing  -static from the makefile, but the build broke. 

Turn off CONFIG_MODE_TT.  The build will make a dynamic binary.

With tt mode enabled, UML must be a static binary.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
