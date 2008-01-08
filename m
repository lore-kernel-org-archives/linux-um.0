Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCCGk-0003pw-Jt for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 03:05:18 -0800
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCCGk-0000Za-53
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 03:05:18 -0800
Received: by py-out-1112.google.com with SMTP id f47so4373947pye.20
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Jan 2008 03:05:17 -0800 (PST)
Message-ID: <a76cf2070801080305y1a90bf72u1e0f7c5d7fe21c42@mail.gmail.com>
Date: Tue, 8 Jan 2008 16:35:16 +0530
From: "Saritha Reddy" <sarithareddyt@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] mount
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0729650593=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0729650593==
Content-Type: multipart/alternative; 
	boundary="----=_Part_20255_3666622.1199790316424"

------=_Part_20255_3666622.1199790316424
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i had installed user mode linux in fedora 4,

when i am trying to mount in user mode linux i  got this error

[root@localhost ~]# mount none /host -t hostfs
mount: mount point /host does not exist

this my file system
[root@localhost ~]# cat /proc/filesystems
nodev sysfs
nodev rootfs
nodev bdev
nodev proc
nodev sockfs
nodev pipefs
nodev anon_inodefs
nodev futexfs
nodev tmpfs
nodev inotifyfs
nodev devpts
reiserfs
ext3
ext2
nodev ramfs
nodev mqueue

------=_Part_20255_3666622.1199790316424
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i had installed user mode linux in fedora 4,<br><br>when i am trying to mount in user mode linux i&nbsp; got this error<br>&nbsp;
<br>[root@localhost ~]# mount none /host -t hostfs<br>
mount: mount point /host does not exist<br><br>this my file system<br>
[root@localhost ~]#  cat /proc/filesystems<br>
nodev   sysfs<br>
nodev   rootfs<br>
nodev   bdev<br>
nodev   proc<br>
nodev   sockfs<br>
nodev   pipefs<br>
nodev   anon_inodefs<br>
nodev   futexfs<br>
nodev   tmpfs<br>
nodev   inotifyfs<br>
nodev   devpts<br>
        reiserfs<br>
        ext3<br>
        ext2<br>
nodev   ramfs<br>
nodev   mqueue<br>

------=_Part_20255_3666622.1199790316424--


--===============0729650593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0729650593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0729650593==--

