Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKgJk-0003Om-MF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 09:29:20 -0700
Received: from houufw01-l3.rlx.com ([64.158.46.249] helo=exch2000.corp.rlx.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BKgJk-0001PY-DX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 09:29:20 -0700
From: Dan Eaton <Dan.Eaton@rlx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083601512.6946.6.camel@dan>
Mime-Version: 1.0
Subject: [uml-devel] hppfs file descriptor leak?
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
Date: Mon, 03 May 2004 11:25:12 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I am attempting to track down an issue that I am seeing but I thought
that I would ask if you have anyone has seen this or has any insight
into the behavior in parallel to my troubleshooting.  I am using
hppfs to spoof some /proc entries in the UML.  When I mount /proc
with hppfs, however, the system only runs for a short while before
the UML kernel process runs out of file descriptors (1024).  It seems
that each access to /proc entries that I am spoofing from the host
results in an open file that never gets closed.  I am looking at it
via gdb but any insight that anyone has would be greatly appreciated.

Configuration:

2.4.24-2 for UML
2.4.24 for host with the skas3 patch(same thing seen running tt mode)
The host and UML are running RH9.
(Basically latest and greatest 2.4 stuff I could find.)

Thanks in advance for any help.

-- 
Dan Eaton <Dan.Eaton@rlx.com>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
