Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YjSqE-00051V-4V
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Apr 2015 13:31:26 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YjSqA-0003ah-1w
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Apr 2015 13:31:26 +0000
Received: from [192.168.178.24] ([80.171.221.60]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0MFLhE-1YXNTz2tQS-00EIdn for
	<user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Apr 2015 15:31:15
	+0200
Message-ID: <55325CA3.8060506@gmx.de>
Date: Sat, 18 Apr 2015 15:31:15 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML specific or just a generic 4.0.x glitch :
 kernel/time/Kconfig:157:warning: range is invalid ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

tfoerste@t44 ~/devel/linux $ make ARCH=um linux -j3           
scripts/kconfig/conf  --silentoldconfig arch/x86/um/Kconfig
kernel/time/Kconfig:157:warning: range is invalid

-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E
--
"; the past is all dirty and cruel in the modern popular imagination, with the exception of the Romans, who are just cruel"
Ian Mortimer, 2008, "The Time Traveller's Guide to Medieval England"

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

