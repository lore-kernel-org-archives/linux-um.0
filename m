Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cyuto-0005wi-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 08:41:08 -0800
Received: from mail.ists.dartmouth.edu ([129.170.248.227])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cyutk-0002DU-M5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 08:41:08 -0800
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69f5c8791e34adc0f05b7433f6c7e254@whoopis.com>
Content-Transfer-Encoding: 7bit
From: Marion Bates <mbates@whoopis.com>
Subject: [uml-devel] strace of "ls" under Fedora Core 3
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
Date: Wed, 9 Feb 2005 11:40:54 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Marion Bates <mbates@whoopis.com>, William Stearns <wstearns@pobox.com>

[this is Marion channeling Bill.]

	As a quick reminder, Marion and Bill are trying to get i386 fedora 
core 3 running under uml (2.6.4, with the i386 emulation code) on ford 
(x86_64).  The uml binaries don't have TLS support, so we've renamed 
all of: /lib/tls. /usr/lib/tls, and /usr/X11R6/lib/tls directories.
	Even with that done, we're getting "cannot set up LDT for thread-local 
storage" as an error message when running something as simple as 
/bin/ls.  It appears that there's TLS system calls in the binary 
itself, not just in the */lib/tls libraries:

...
brk(0)                                  = 0x805d000
brk(0x807e000)                          = 0x807e000
brk(0)                                  = 0x807e000
shutdown(1610612264, 81)                = -1 ENOSYS (Function not 
implemented)
modify_ldt(0x1, 0x5ffffe28, 0x10)       = -1 ENOSYS (Function not 
implemented)
write(2, "cannot set up thread-local stora"..., 36cannot set up 
thread-local storage: ) = 36
write(2, "cannot set up LDT for thread-loc"..., 43cannot set up LDT for 
thread-local storage
) = 43
write(2, "\n", 1
)                       = 1
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

	The "modify_ldt" call looks ominous; In a perfect world, wouldn't the 
/bin/ls binary realize it didn't have any tls library support and not 
use TLS system calls?
	Yeah, right.  We can only hope.  :-)

	Any ideas?
	- A befuddled Marion and Bill




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
