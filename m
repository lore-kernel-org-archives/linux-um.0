Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Prd-0005wH-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 07:09:29 -0700
Received: from bay7-f125.bay7.hotmail.com ([64.4.11.125] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9Prc-00053I-G8
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 14 Oct 2003 07:09:28 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F125P4zi6UUG7W0000f8fc@hotmail.com>
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
Date: Tue, 14 Oct 2003 14:08:57 +0000
To: doug@easyco.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Doug Dumitru wrote:
>A couple of questions.  I noticed that you are not mapping /proc/mm.
[...]
>This looks like one per virtual process (minus threads).  Am I reading this 
>right.

yes. The discussion for a previous patch considered a "mm" table to hold a 
pool of /proc/mm files to handle one fd per process.  One side effect of 
this would place a hard limit on the number of processes in the UML: the 
number of /proc/mm files opened.  I'm not sure what side effects re-using 
/proc/mm files would have, either.  I should have mentioned TT/SKAS issues, 
but it slipped my mind (I only use TT mode). So to use skas in a chroot, 
you'll still have to mount /proc/mm in there.  Hopefully Jeff has a fix for 
/proc/mm in the works.

>On virtuals that I run, I tend to only see a single "vm" file opened:

yup. Things have changed since I looked at it for the last filemap patch 
*sigh*.  It used to be 1 file for every 256M of memory, but now, it is just 
one big happy file, so in SKAS mode you should need only one vm file entry.  
In TT mode there are a few more files required, but the max now seems to be 
3 or 4 entries.

>Is there any reason the tun/tap networking wouldn't work with this layout 
>by pre-opening /dev/net/tun.

Possibly, but you will have to check out the "TUN/TAP with a preconfigured 
tap device" section of the virtual networking howto as the uml_net helper 
won't pick up the filemapped fd for /dev/net/tun inside a chroot (nor will 
it likely have ifconfig or route binaries available).   Let me know if you 
get this to work.

Steve Schmidtke

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
