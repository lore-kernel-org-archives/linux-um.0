Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGUVz-0002eL-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 18:32:24 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AGUVz-0001y3-96
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 18:32:23 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA32JsD03130
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 2 Nov 2003 21:19:54 -0500
Message-Id: <200311030238.hA32cqgX002509@ccure.karaya.com>
Subject: Re: [uml-devel] Linking 2 switches 
In-Reply-To: Your message of "Sun, 02 Nov 2003 00:19:48 +0100."
             <200311020019.48773.benoit.peccatte@enst-bretagne.fr> 
References: <200311020019.48773.benoit.peccatte@enst-bretagne.fr> 
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
Date: Sun, 02 Nov 2003 21:38:52 -0500
To: Benoit <benoit.peccatte@enst-bretagne.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

benoit.peccatte@enst-bretagne.fr said:
> So I modified uml_switch to listen on tcp port and created uml_uplink
> which is  able to connect to a local switch via unix socket and to
> another switch via a  tcp connection.
>
> Do you think his is a good solution ?

What's the matter with just hooking the switches together directly by UDP?

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
