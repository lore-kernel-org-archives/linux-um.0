Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg7tN-0000ou-EY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 13:10:45 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bg7tM-0001O9-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 13:10:45 -0700
Message-Id: <200407012105.i61L5Il9003563@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Problems compiling 2.4 kernel 
In-Reply-To: Your message of "Thu, 01 Jul 2004 10:40:09 PDT."
	<s0e3ea28.088@ORANGE.OUS.EDU> 
References: <s0e3ea28.088@ORANGE.OUS.EDU> 
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
Date: Thu, 01 Jul 2004 17:05:18 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Anthony_Brock@ous.edu said:
> Okay, I found my problem. My problem was attempting to compile using:
> make ARCH=um
> rather than:
> make linux ARCH=um 

OK, that needs fixing.  All the other arches do something sane with just 'make',
and UML needs to follow suit.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
