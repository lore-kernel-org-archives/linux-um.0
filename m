Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vSGX-0007pO-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 18:53:29 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19vSGX-0002or-2x
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 18:53:29 -0700
Message-ID: <3F593DFB.7040609@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic: I/O op mismatch
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
Date: Fri, 05 Sep 2003 21:52:59 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I'm having a few issues with my current UML kernels -

/dev/ubd/2: recovering journal
Kernel panic: I/O op mismatch
In interrupt handler - not syncing

Anyone seen this before?

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
