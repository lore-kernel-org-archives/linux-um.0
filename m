Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVw9F-0003IE-8q
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Dec 2003 09:04:45 -0800
Received: from web10402.mail.yahoo.com ([216.136.130.94])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVw9E-0006Hj-Vw
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Dec 2003 09:04:44 -0800
Message-ID: <20031215170437.73387.qmail@web10402.mail.yahoo.com>
From: Joydeep Sen Sarma <jsensarma@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Debug uml kernel won't boot (VFS: Unable to mount root fs)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 15 Dec 2003 09:04:37 -0800 (PST)
To: user-mode-linux-devel@lists.sourceforge.net

Hi folks,

The regular uml kernel worked fine till i turned
on the debug option. Kernel version is 2.4.22 and
I applied uml patch 2.4.22-6 to it. Root file System
is the Debian-3.0r0.ext2.bz2 image from uml home page.

# ls -l root_fs
-rw-r--r--    1 root     root     62862336 Dec 14
18:06 root_fs
# ./linux ubd0=root_fs debug gdb-pid=2646

From debugger, failure happens here:

Breakpoint 3, do_kern_mount (fstype=0xa194b000 "ext2",
flags=32769, 
    name=0xa1949000 "/dev/root", data=0x0) at
super.c:793
(gdb)
get_sb_bdev (fs_type=0xa01fb930, flags=-12,
dev_name=0xa1949000 "/dev/root", 
    data=0x0) at super.c:669

this call in get_sb_nodev fails:
	error = path_lookup(dev_name,
LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);

with err code of ENOENT. Any ideas what's wrong or
how I can debug this ? (I have tried the 
root=/dev/ubd/0 option - same result)

thanks,

Joydeep




__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
