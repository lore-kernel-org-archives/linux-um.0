Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWn04-0003rs-5q
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 17:30:48 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWn02-00036D-9i
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 17:30:46 -0800
Message-Id: <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [bug] uml segfaults if forcing static link, 2.6.0-test11 
In-Reply-To: Your message of "Wed, 17 Dec 2003 22:54:58 +0100."
             <Pine.LNX.4.58.0312172249020.19508@earth> 
References: <Pine.LNX.4.58.0312171735540.8123@earth> <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>  <Pine.LNX.4.58.0312172249020.19508@earth> 
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
Date: Wed, 17 Dec 2003 20:46:01 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> the attached .config produces an UML binary that segfaults much the
> same way as before the ALIGN fixes. 

HAHAHA, there is justice in this world :-)

This one is your fault, I think.

See this patch and see if it fixes the problem:
	http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=106867347801038&w=2

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
