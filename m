Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgRmj-000708-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jul 2004 10:25:13 -0700
Received: from mail1.engr.ucsb.edu ([128.111.53.4] helo=smtp.engr.ucsb.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BgRmj-0008Mf-LN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jul 2004 10:25:13 -0700
Received: from www1.engr.ucsb.edu ([128.111.27.8]:3451 helo=cs.ucsb.edu)
	by smtp.engr.ucsb.edu with smtp (Exim 4.24) id 1BgRmc-00079E-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jul 2004 10:25:06 -0700
From: <lyouseff@cs.ucsb.edu>
In-Reply-To: <40E520AE.8040302@cs.ucsb.edu>
Message-Id: <E1BgRmc-00079E-Gg@smtp.engr.ucsb.edu>
Subject: [uml-devel] Re: does O_DIRECT hinder greatly file reading performance
	but not writing??
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
Date: Fri, 2 Jul 2004 17:25:09 -0000
To: user-mode-linux-devel@lists.sourceforge.net

Sorry for the repeated posts, but i figured out that my email body was not
posted. My appologies for the spam.

---------------------------------
Hi All,

I am kind of new to UML and I am experiencing a very strange performance
hinder with it. I am running two benchmarks; one that writes a 50Mbyte file
and the other one reads a 50Mbyte file. I tried the benchmarks with and
without setting the O_DIRECT flag, in which cases the whole task is done in a
matter of seconds(10-30 seconds) except when reading the file with O_DIRECT
flag on. In this case, it takes 18-20 min!!! I am running UML 2.4.19 on top of
kernel 2.4.25. I have time output like that (average of 20 runs)


Operation              UserTime(sec)   SysTime(sec)  WallClockTime(sec)

Write Without O_DIRECT    5.612000  0.117500  27.164500

Write With O_DIRECT       10.007000 0.017000 22.199500

Read without O_DIRECT     3.035000 0.091000 7.760000

Read With O_DIRECT        21.492000 29.680000 1133.054000

I would appreciate it very much if somebody would explain to me how to solve
that strange performance problem, or even explain why does it happen for
reading with O_DIRECT but not without !!??

Thanks allot,
Lamia Youseff
-- 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
