Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x46C-0005nZ-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 05:29:28 -0700
Received: from mout1.freenet.de ([194.97.50.132])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x46C-0001Iw-Cf
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 05:29:28 -0700
Received: from [194.97.55.148] (helo=mx5.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.22)
	id 19x468-0000YY-Jp
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:29:24 +0200
Received: from b2a62.pppool.de ([213.7.42.98] helo=home.petschge.de)
	by mx5.freenet.de with esmtp (Exim 4.22 #1)
	id 19x467-0003Hd-D4
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:29:24 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id C5C043BCE5
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue,  9 Sep 2003 18:28:52 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id 587F63BCE4
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue,  9 Sep 2003 18:28:51 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] Re: 2.6.0 uptime bug 
References: <200309041706.03045.petschge@gmx.de> <20030905151952.6EBFC3BCE4@home.petschge.de> <20030906190708.56B8C3BCE4@home.petschge.de> <200309091616.h89GG72J003645@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030909162851.587F63BCE4@home.petschge.de>
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
Date: Tue, 09 Sep 2003 18:28:51 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

>> I have a patch which gives the correct uptime. I don't know what the
>> patch  breaks so please post any problems you have.
> Have you been able to figure out whether this is also a problem for other
> ports?  Your patch suggests that it is, and if it is, then you should send
> it to LKML so it can be fixed in mainline.
I don't know if other arch beside uml give the wrong uptime. If anyone could 
check this on i386 or other "read" hardware I'd be glad to hear the result. 
Looking at the code and the callpath all arch should have this bug. If 
someone is able to confirm this I'm going to post the patch to the lkml. 

mfg,
Patrick "Petschge" Kilian

-- 
Spam ist weniger ein technisches als ein soziales Problem. Die einzigen
technischen Mittel, die soziale Probleme halbwegs brauchbar loesen,
sind schwere Waffen. Und das auch nur bei wirklich konsequenter
Anwendung.      -- Alexander Schreiber in dasr



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
