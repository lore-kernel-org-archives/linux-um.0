Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xMiT-0008GN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 01:22:13 -0700
Received: from stephens.ittc.ku.edu ([129.237.125.220])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xMiS-0005HC-BF
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 01:22:12 -0700
Received: from moby.ittc.ku.edu (moby.ittc.ku.edu [129.237.127.143])
	by stephens.ittc.ku.edu (8.12.9/8.12.9/ITTC-ANTISPAM-ANTIVIRUS-3.0) with ESMTP id h8B8L7hf007421
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 03:21:07 -0500
From: Vishveswar Reddy Challagonda <vish@ittc.ku.edu>
Message-ID: <Pine.LNX.4.44.0309110316270.14423-100000@moby.ittc.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] write SIGIO emulation thread and ubd driver asynchronous I/O thread
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
Date: Thu, 11 Sep 2003 03:23:02 -0500 (CDT)
To: user mode linux list <user-mode-linux-devel@lists.sourceforge.net>

Hi all,
I am new a newbie and understood the ptrace relationship between User 
space Thread and Kernel space thread. 
But I am yet to deal with 'ubd driver asynchronous I/O thread' and 'Write 
SIGIO emulation thread'. Can anyone explain in brief their functions and 
operations. Does the concept of ptracing come here also? How are user 
space thread's read/write are handled?
vish



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
