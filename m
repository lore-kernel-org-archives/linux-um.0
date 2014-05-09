Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Wis9r-0002H1-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 21:16:43 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wis9q-0002Xj-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 21:16:43 +0000
Received: from [192.168.178.21] ([80.171.220.243]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MUCTO-1WIzZO03QA-00R0YV for
	<user-mode-linux-devel@lists.sourceforge.net>; Fri, 09 May 2014 23:16:36
	+0200
Message-ID: <536D45B3.8040606@gmx.de>
Date: Fri, 09 May 2014 23:16:35 +0200
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
Subject: [uml-devel] 1 zombie process after starting a 23 bit UML guest
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Today I realized that current kernels produces a zombie proces :

tfoerste@n22 ~ $ ps aux | grep 'Z' | grep '<defunct'
tfoerste 10918  0.0  0.0      0     0 ?        Zs   23:11   0:00 [linux-v3.12-48-] <defunct>

The last kernel which does not produce such a zombie is kernel 3.11

I do not use a xterm for any output, just "con0=fd:0,fd:1 con=pts". However I'm unsure if this is an already known issue (and I just forgot it) or whether I should kick my test box to bisect the guelty commit id between 3.11 and 3.12

-- 
Toralf


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

