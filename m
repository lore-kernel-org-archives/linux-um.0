Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4nKs-0008QI-UZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:17:06 -0700
Received: from mail.stral.net ([61.14.141.91] helo=ns1.stral.net ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C4nKm-0004SV-0c
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:17:05 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-reply-to: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
Message-ID: <E1C4nKm-0004SV-0c@sc8-sf-mx2.sourceforge.net>
Subject: [uml-devel] Compiling UML 2.6.8.1 with Static Linking results in
	segfault
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
Date: Wed, 8 Sep 2004 07:16:42 +1000
To: user-mode-linux-devel@lists.sourceforge.net

I've just tried to compile UML with TT disabled, SKAS enabled and static
linking enabled. When I run the linux binary is immediately segfaults.

I'm using GCC 3.3.4 and Libc6 2.3.2 ...

Can I provide any further info or is this a known problem?

Michael Ralston
Stral.net



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
