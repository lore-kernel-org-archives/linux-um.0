Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200402110118.i1B1Imip004260@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 03 Feb 2004 01:16:54 +0100."
             <401EE876.9090700@darkman.de> 
References: <401EE876.9090700@darkman.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] wall on shutdown
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
Date: Tue, 10 Feb 2004 20:18:48 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

sven@darkman.de said:
> But sometimes the shutdown doesn't send the well known wall msg. I
> tried multiple kernel configs etc., but it seems to be a race
> condition. 2 times it worked, 3-4-5-6 time it doesn't work. The UML
> simply goes down (clean shutdown, all ok execpt the missing wall). Now
> i added a echo bla | wall; shutdown to the inittab, that 'works' but
> isn't very beautiful ;)

This sounds like a userspace problem.  Does wall (or shutdown) have any delays
in it which sleep long enough for UML to shut down?

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
