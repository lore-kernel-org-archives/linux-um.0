Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uxl3-00005p-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 10:18:57 -0700
Received: from birosca.ime.usp.br ([143.107.45.59])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19uxl1-0001Ii-Fl
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 10:18:55 -0700
From: Livio Baldini Soares <livio@ime.usp.br>
Message-ID: <20030904171245.GA30388@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Bug with hostfs when not specifying host dir in fstab
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
Date: Thu, 4 Sep 2003 14:12:46 -0300
To: user-mode-linux-devel@lists.sourceforge.net

  Hi,

  Something changed in hostfs in the  past months so that now, this line in
fstab will kill UML on boot:

none /host hostfs defaults 0 0

  Changing it to:

none /host hostfs /,defaults 0 0

  does what I want. Additionally, doing this on the command line:

mount -t hostfs -o defaults none /mnt

  also kills UML. Here's the backtrace:

#0 panic (fmt=0xa01e2107 "kernel BUG at %s:%d!\n") at panic.c:52
#1 0xa003e5aa in kfree (objp=0xa3181514) at slab.c:1439
#2 0xa013b7ee in hostfs_read_super (sb=<incomplete type>, data=0xa2ffc000, 
    silent=0) at hostfs_kern.c:932
#3 0xa004c44b in get_sb_nodev (fs_type=0xa02403ec, flags=0, 
    dev_name=0xa2ffd000 "none", data=0xa2ffc000) at super.c:756
#4 0xa004c5b2 in do_kern_mount (fstype=0xa300a000 "hostfs", flags=0, 
    name=0xa2ffd000 "none", data=0xa2ffc000) at super.c:808
#5 0xa0065db5 in do_add_mount (nd=0xa3507b20, type=0xa300a000 "hostfs", 
    flags=0, mnt_flags=0, name=0xa2ffd000 "none", data=0xa2ffc000)
    at namespace.c:626
#6 0xa00661c9 in do_mount (dev_name=0xa2ffd000 "none", 
    dir_name=0xa3803000 "/mnt", type_page=0xa300a000 "hostfs", 
    flags=3236757504, data_page=0xa2ffc000) at namespace.c:740
#7 0xa0066583 in sys_mount (dev_name=0x805c180 "none", 
    dir_name=0x805c190 "/mnt", type=0x805c1a0 "hostfs", flags=3236757504, 
    data=0x805c1d0) at namespace.c:853
#8 0xa00f0e37 in um_mount (dev_name=0x805c180 "none", 
    dir_name=0x805c190 "/mnt", type=0x805c1a0 "hostfs", new_flags=3236757504, 
    data=0x805c1d0) at syscall_kern.c:33


  I  have no  time to  look at  this  right now,  but maybe  its an  useful
bug-report, and perhaps someone who  knows hostfs better than I can quickly
identify the problem. The kernel is 2.4.22-1 usgin TT mode.

  best regards,

--  
  Livio B. Soares


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
