Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A5TMW-0008CE-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 03 Oct 2003 10:05:04 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A5TMT-0008Ax-M8
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 03 Oct 2003 10:05:01 -0700
Message-ID: <34131.81.0.169.41.1065192660.squirrel@pluto.nixia.no>
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [uml-devel] (no subject)
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
Date: Fri, 3 Oct 2003 16:51:00 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

I'd like to share memory between the uml-kernel and a user-space util
(some megabytes). I'd like this to be a file-descriptor that is mmap'ed in
both processes. What is the most nice way to do this?

The memory manager in uml can do this for me as far as I can see (but I'm
not into the internals to hack out the fd and memory maped up in the
kernel side).

Or should I just use malloc() and mmap into this area? Doesn't this fuck
up when uml goes between internal user space and kernel space, remapping
in the /tmp/foo (deleted) files? into the malloc'ed areas?

If so, this might be an issue for the dude who wants to play with gtk/x11
into the kernel then some points of implementations plays with
mmap-buffers etc.



Stian


This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
