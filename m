Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlePw-0004D1-UU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 17:22:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AlePw-0006to-3T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 17:22:56 -0800
Message-Id: <200401280146.i0S1kaZw004952@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 26 Jan 2004 23:17:08 +1030."
	<20040126124708.GH4203@erizo.shearer.org> 
References: <20040126124708.GH4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: PATCH kernel/umid.c
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
Date: Tue, 27 Jan 2004 20:46:36 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> -                       return(0); 
> +                       return(1);

I did the return(0) on purpose because, even though initcall procedures are
declared as returning an int, do_initcalls ignores it.

So, I added a comment there instead of changing the return value.

> In addition, umid.c seems to be a bit inconsistent as to what rates an
> exit(1) and what just does return(1). 

Stuff that's done early, before the kernel is actually running, rates an 
exit(1).  Everything else gets a return(1).  I don't always follow this rule,
but I did a quick check of umid.c and it looks OK.

				Jeff


				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
