Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A0kG9-0002im-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Sep 2003 09:06:57 -0700
Received: from smtp015.mail.yahoo.com ([216.136.173.59])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A0kG8-0003k2-PR
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Sep 2003 09:06:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <00af01c37d5f$65ac1f50$6059a043@clicktosecure.com>
In-Reply-To: <00af01c37d5f$65ac1f50$6059a043@clicktosecure.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309201808.24547.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] FAQ: problems with 2.4.22-4um and answers
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
Date: Sat, 20 Sep 2003 18:08:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Frank Laub <fried@franklaub.com>

There are two known frequent problems, already known, causing 2.4.22-4um(and 
possibly patches based on it) to fail compilation:
- First, when you configure the uml, you must activate this option:
"Anonymous memory device"
or UML won't compile. So, activate it. By default it's off. Clear?
- if you instead see such messages:

/usr/src/uml-2.4.22-4um/arch/um/include/os.h:41: warning: no semicolon at
end of struct or union

it's for a known bug showing up on some systems(depends on changes in system 
headers from glibc, showing up for instance on my Mdk9.1) which is already 
being fixed. For now wait next patch or use 2.4.22-3um.
The problem that you, Frank Laub, had(I'm also answering to you) it's the 
second one. By the way, what are your distro and glibc versions?
I'm posting this message because there are already enough people asking for 
this problems.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
