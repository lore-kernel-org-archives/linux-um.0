Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAprs-0001WL-NF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 05:44:24 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAprq-0000qE-Dy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 05:44:24 -0800
Message-Id: <200503141615.j2EGFbFF002845@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] stdio and serial consoles. 
In-Reply-To: Your message of "Mon, 14 Mar 2005 00:48:09 EST."
	<200503140048.09731.rob@landley.net> 
References: <200503140048.09731.rob@landley.net> 
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
Date: Mon, 14 Mar 2005 11:15:37 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

rob@landley.net said:
> Is it just me, or is stdio_console.c and ssl.c basically the same code
> with a  couple of variables renamed, a different driver structure
> initialization, and  slightly different header #includes? 

Yeah, they started off as totally different drivers until I realized that
there was no reason for them to be different.  So I spent a good amount of
time factoring out common code until you basically have one code base which
plugs itself into the kernel in two slightly different ways.

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
