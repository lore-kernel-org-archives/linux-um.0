Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbZqc-0008Ne-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 23:33:22 -0800
Received: from mail.interware.hu ([195.70.32.130])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CbZqc-0005mb-DO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 23:33:22 -0800
Received: from caracas-1565.adsl.interware.hu ([213.178.106.29] helo=debian)
	by mail.interware.hu with esmtp (Exim 4.34 #1 (Debian))
	id 1CbZqZ-0005Hp-KD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 07 Dec 2004 08:33:20 +0100
From: Hegedus Gabor <hygylista@freemail.hu>
Content-Type: text/plain
Message-Id: <1102404966.17303.71.camel@debian>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.9 slow
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
Date: Tue, 07 Dec 2004 08:36:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi!

I tested 2.6.9 with patched with host-skas3-2.6.9-v7.patch. It is very
slow, but there is not a big load, nor a big disk io. (I checkd with
iostat)

With 2.6.7 it is good.

bye
 HyGy



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
