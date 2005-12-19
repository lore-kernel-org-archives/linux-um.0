Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoNwh-0001Rb-Rk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:33:07 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoNwd-0002We-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:33:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191732.43333.blaisorblade@yahoo.it>
Subject: [uml-devel] Introducing new bugs with fixups - one safe story
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
Date: Mon, 19 Dec 2005 17:32:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net

One nice day a clumsy programmer (let's say me) on a "call for fixing" day 
wrote the following patch (host_kern.c):

-       start = (long long) (page->index << PAGE_CACHE_SHIFT) + from;
+       start = ((long long) page->index) << PAGE_CACHE_SHIFT + from;

to make sure page->index was casted before shifting, to avoid losing 
information. But look below. Does the new line:

        start = ((long long) page->index) << PAGE_CACHE_SHIFT + from;

must be interpreted as:

        start = (((long long) page->index) << PAGE_CACHE_SHIFT) + from;
(what I meant) or as 
        start = ((long long) page->index) << (PAGE_CACHE_SHIFT + from);

?

This message is given as help:

  CC [M]  fs/hostfs/hostfs_kern.o
/home/paolo/Admin/kernel/6/VCS/linux-2.6.git/fs/hostfs/hostfs_kern.c: In 
function `hostfs_commit_write':
/home/paolo/Admin/kernel/6/VCS/linux-2.6.git/fs/hostfs/hostfs_kern.c:504: 
warning: suggest parentheses around + or - inside shift

Luckily, however, the clumsy programmer saw the message and learned The Way 
(tm). And the patch hadn't been merged yet. Another point for GCC.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
