Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG1WL-00009E-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 11:34:49 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AG1WL-0000fB-6u
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 11:34:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311011159.11435.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Partitioning scheme for ubd's
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
Date: Sat, 1 Nov 2003 11:59:11 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Since some time, we can get nice messages as ubda: unknown partition table on 
boot if we use ubd's normally, and even install UML on partitions for 
installs.

But there is a problem here:
1) device names are not consistent: if you want to use ubd[a-z], decide so and 
start the change(for 2.6 there's a lot more changes anyway, so it is a good 
occasion...)

2) if I do an install, I can partition the ubd's; but then, I won't be able to 
loop mount the file on the host(and if I'm in trouble, this ability is worth 
a lot). In fact, I've never partitioned the ubd's, but this meant a lot of 
trouble even to run Slackware install.

3) so, I thought this: since partitioning schemes are pluggable, it would be 
possible to fool it and turn the ubd's into partitions of a single disk. I.e. 
if I setup udb0, ubd1 and so on, they would be seen as three partitions of a 
single disk. But they are still different files, loop-mountable on host.

Would you ever accept this? The other possible solution(which would be 
cleaner) would be to teach, if possible, to the host kernel Device Manager to 
read a file as a bunch of partition with its table(I've heard of DM about COW 
files these days), and then to mount the partitions, but I don't know if it's 
possible.

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
