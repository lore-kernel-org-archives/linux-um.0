Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj2Dr-0000f3-Un for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:11:39 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aj2Dr-0004dK-ED
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:11:39 -0800
Message-Id: <200401202034.i0KKY4DG004042@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 20 Jan 2004 20:26:19 +0100."
	<200401202026.19785.blaisorblade_spam@yahoo.it> 
References: <200401202026.19785.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: First shrinkage of *_user.c files
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
Date: Tue, 20 Jan 2004 15:34:04 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I've started removing some functions from the user_objs, and here
> there are  the two first patches. Any comment on the style of these
> changes is highly  appreciated. The next thing I'm going to do is to
> remove entirely  hostaudio_user.c (I've already started this, but I've
> not got a successful  test yet, since I also did a little fix in
> this). 

Yeah, that's the style I'm looking for.  The goal should be to eliminate
anything outside of arch/um/os needing any libc headers.

Try to extract the essence of the libc dependency into arch/um/os rather
than just moving large chunks of code there, which looks like what you're
doing.

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
