Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgWRq-0007k4-P7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Dec 2004 14:56:14 -0800
Received: from radium.outervoid.net ([206.123.106.250])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CgWRp-0004SM-4A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Dec 2004 14:56:14 -0800
Received: from mail.outervoid.net (localhost [127.0.0.1])
	by radium.outervoid.net (Postfix) with ESMTP id E2CC940087
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Dec 2004 11:56:10 +1300 (NZDT)
Message-ID: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
From: "Carl" <lists@outervoid.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [uml-devel] Memory corruption/errors?
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
Date: Tue, 21 Dec 2004 11:56:10 +1300 (NZDT)
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

Running the piece of code from the URL below is generating errors on
various UML kernels:

http://downloads.rimuhosting.com/memtest.c

Kernels tested are: 2.4.27, 2.4.27-bs1, 2.6.9-bb4.

Different UML host servers have been tried too, and only UMLs running on
SMP (dual Xeon) servers seem to have the problem (P4s with HT are fine).

Can anyone else reproduce the errors? Any ideas?

Thanks, Carl



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
