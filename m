Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CA6qk-0001Ka-4o for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 06:07:58 -0700
Received: from nn6.excitenetwork.com ([207.159.120.60] helo=excite.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CA6qj-0007YL-Kh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 06:07:58 -0700
Reply-To: jmfguy@excite.com
From: "jmf" <jmfguy@excite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20040922130749.72788B74D@xprdmailfe17.nwk.excite.com>
Subject: [uml-devel] UML on AMD64 x86_64
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
Date: Wed, 22 Sep 2004 09:07:49 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net




I'm using 64 bit Gentoo on an Athlon64 and it would be really nice to have a working port of 32 bit UML. This would allow us to sandbox a 32 bit Gentoo kernel within the 64 bit Gentoo environment.



I want to emphasize that I'm not even asking for a real 64 bit UML port, I simply want the standard UML 32 bit port to compile, and run, in amd64 32-bit mode. This would allow people in amd64 linux-land to have some form of UML to use while we wait for a true 64-bit implementation. 



I tried simply compiling the 32 bit UML port using gcc 3.3.4 and "linux32 make linux ARCH=um" with a SUBARCH := i386, but this failed complaining about things like 



arch/um/sys-i386/util/mk_sc.c:30: error: structure has no member named `eax'



I'm surprised UML didn't compile so if anyone has some suggestions to try, please let me know. 









_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
