Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASPjt-0000fA-Gq
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:01 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ASPjr-0002V2-H5
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:51:59 -0800
Message-Id: <200312060005.hB6050Av008225@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: Your message of "Wed, 03 Dec 2003 11:04:03 +1000."
             <3FCD3683.2030503@snapgear.com> 
References: <3FCD3683.2030503@snapgear.com> 
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
Date: Fri, 05 Dec 2003 19:05:00 -0500
To: Steve Bennett <steveb@snapgear.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

steveb@snapgear.com said:
> The attached trivial patch provides access to <asm/ldt.h> when
> compiling against UML. 

I.e. you're compiling on a system that has /usr/include/asm linked to 
/usr/include/asm-um?

I don't think that's a great idea.  UML pretends to be the same arch as the 
host to userspace, so you should be compiling against the host's headers.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
