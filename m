Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh8F-0007hN-8D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:47 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh8E-0002Sb-JX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:46 -0800
Message-Id: <200401060259.i062x7FI023137@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML build system: patch ready 
In-Reply-To: Your message of "Sat, 27 Dec 2003 08:51:10 +1300."
	<1072468270.6872.13.camel@laptop-linux> 
References: <200312241943.37474.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
	<1072468270.6872.13.camel@laptop-linux> 
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
Date: Mon, 05 Jan 2004 21:59:07 -0500
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Jeff Chua <jeff98@silk.corp.fedex.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

ncunningham@clear.net.nz said:
> I may be able to get software suspend [a bit closer to] working under
> UML. The lack of support for modifying ldts was where I blocked when I
> briefly looked at it a while ago.

swsusp for UML is now reality, see sbuml.sf.net for details.  The one hitch
is that it's not up to date with the current UML.  I'm sure that help fixing
that would be appreciated.

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
