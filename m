Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ANXWV-0005gB-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 22 Nov 2003 05:10:03 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ANXVq-0002AE-CS
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 22 Nov 2003 05:09:22 -0800
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id hAMD9IW20700
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 22 Nov 2003 14:09:18 +0100
From: Henrik Nordstrom <hno@marasystems.com>
Message-ID: <Pine.LNX.4.44.0311221347440.20561-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] iptables-restore randomly crashes under UML
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
Date: Sat, 22 Nov 2003 14:09:18 +0100 (CET)
To: User-mode-linux-devel@lists.sourceforge.net

We have found what looks like a UML-specific problem when running the 
iptables-restore command.

Environment:

Linux-2.4.22 + current UML from CVS. iptables compiled as modules.

iptables (tested with both 1.2.8 and current CVS)

Host: RedHat 7.1, 7.3 and 9 with current updates.


boot without any iptables loaded

load the iptables modules

iptables -t mangle -L
iptables -t nat -L
iptables -t filter -L

Try running iptables-restore

iptables-save | iptables-restore

If no problem seen, try adding a few rules or chains to the table and 
repeat the command or try loading additional iptables such as filter 
and/or nat. In our tests this very reliably makes the iptables-restore 
fail after at most a few attemtps. In many cases a cycle of 4 is seen 
where the command works three times and then fails once, or fails with one 
error three times and another error once.

This problem is only seen when using UML, not when running on "real" 
hardware. This makes me suspect the problem is to be found somewhere 
within UML.

We have also seen occations when the kernel copy of the iptables table 
(usually the nat table) gets corrupted in the few cases where 
iptables-restore runs without error, later causing a kernel panic inside 
iptables.

The problems does only seem to occur when using iptables-restore to load a
new iptables definition, not when using iptables to modify individual
rules. But I can not understand why as the kernel operations are almost
identical in both cases.. iptables reads the current table from the
kernel, modifies it and writes the new table, iptables-restore compiles a
new table from the source rules and writes it into the kernel.


Any hints on how to pinpoint if this is a UML or a iptables problem is 
preciated.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
