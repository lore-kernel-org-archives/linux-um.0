Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALTSd-0002Mo-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 12:25:31 -0800
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42] helo=ms-smtp-03-eri0.texas.rr.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ALTS3-0006T2-Ak
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 16 Nov 2003 12:24:55 -0800
Received: from austin.rr.com (cs68201160-91.austin.rr.com [68.201.160.91])
	by ms-smtp-03-eri0.texas.rr.com (8.12.10/8.12.7) with ESMTP id hAGKOdl4014809
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 14:24:39 -0600 (CST)
Message-ID: <3FB7DD09.3050101@austin.rr.com>
From: Steve French <smfrench@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [Fwd: arch/um/sys-i386/bugs.c compile error]
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 16 Nov 2003 14:24:41 -0600
To: user-mode-linux-devel@lists.sourceforge.net

  This compile error shows up on my more recent SuSE systems due to 
presumbably these sytems including the more current gcc (3.3.1).  With 
the deault UML config both 2.4 and 2.6 UML build fail on e.g. SuSE 9

Perhaps the compiler is stricter now - showing up a problem with the headers.

> I get the same arch/um/sys-i386/bugs.c compile error on 2.6.0-test9-1-um
> and 2.4.22-6-um. Anyone have an idea of what causes the error?






-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
