Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19va2d-0003Vn-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 03:11:39 -0700
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19va2c-0005dR-0Y
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 03:11:38 -0700
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout2.freenet.de with asmtp (Exim 4.21)
	id 19va2V-0002Oz-PZ
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 12:11:31 +0200
Received: from b2afe.pppool.de ([213.7.42.254] helo=home.petschge.de)
	by mx3.freenet.de with esmtp (Exim 4.22 #1)
	id 19va2U-0004mZ-LV
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 12:11:31 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 1B7063BCE5
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri,  5 Sep 2003 23:14:52 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id BB6C53BCE4
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri,  5 Sep 2003 23:14:50 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] run away 2.6.0 
References: <200309021220.13334.petschge@gmx.de> <200309021850.h82Io9Hx001652@ccure.karaya.com> <20030903095811.DD7693BC56@home.petschge.de> <20030904144728.A58113BCE4@home.petschge.de> <200309052012.h85KCSjh001305@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030905211450.BB6C53BCE4@home.petschge.de>
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
Date: Fri, 05 Sep 2003 23:14:50 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

Jeff Dike wrote:
>> Why doesn't gdb show me the function names?
> Because those are all process addresses.  gdb only knows about UML
> symbols.
Ok, I admit, I never used gdb for anything else than debugging uml. Please 
could anybody give me a hint or some manuals to read, how I can debug this 
situatuion?

Thanks for your help,
Patrick "Petschge" Kilian

-- 
I still think the fastest way to get wholesale IPv6 adoption
is to write a pr0n server that serves thumbnails over IPv[46]
and full-size images over IPv6 only.              -- Ingvar



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
