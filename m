Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F2zEF-0000YG-ED for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 15:11:35 -0800
Received: from bay101-f14.bay101.hotmail.com ([64.4.56.24] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F2zEF-00016U-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 15:11:35 -0800
Message-ID: <BAY101-F14AF59E645AF66A2146EF5E2170@phx.gbl>
From: "James McMechan" <james_mcmechan@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [uml-devel] many cow files with ubd_kern.c
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
Date: Sat, 28 Jan 2006 23:11:31 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Once again I have been tweaking ubd_kern to support lots of disks since I 
need it for recovery
but I hit (even on a plain 2.6.15-bs1 kernel)
allocation failed: out of vmalloc space - use "vmalloc=<size>" to increse 
size
Failed to vmalloc COW bitmap
ubd0: Can't open "COW0": errno -12

but I already had vmalloc=128M (which should be the default) and 
vmalloc=256M and mem=384M on the command line.
I can't seem to locate where the equivlaent of arch/i386/kernel/setup.c has 
the vmalloc= option on arch/um though
has anyone hit something like this before each of the bitmaps should only 
take about 60M of memory and at this point I have only tried to allocate 1 
for a single 250G ubd device

This will present a larger problem when I get everything working and try to 
allocate all 10 drives worth of bitmap ~600M
I suppose I may have to go back to the paged bitmap logic but it is still a 
mess...
The multiple major numbers and C:H:S from mconsole do seem to work correctly 
though




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
