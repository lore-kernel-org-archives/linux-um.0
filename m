Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkRja-0003kL-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 11:10:30 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BkRjX-0005lO-TM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 11:10:28 -0700
Message-Id: <200407131905.i6DJ5gGu003363@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] make port channel use setsockopt SO_REUSEADDR
In-Reply-To: Your message of "Tue, 06 Jul 2004 19:09:29 +0800."
	<40EA8869.8050602@metaparadigm.com> 
References: <40EA8869.8050602@metaparadigm.com> 
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
Date: Tue, 13 Jul 2004 15:05:42 -0400
To: Michael Clark <michael@metaparadigm.com>
Cc: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

michael@metaparadigm.com said:
> Small patch to make port channels allow reuse of local addresses.
> Useful in the case where you restart a UML from a script and you don't
> want to have to allocate a new port number each time. 

Applied, except I fixed the error case slightly.

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
