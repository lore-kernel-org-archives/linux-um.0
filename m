Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkcTn-0003KT-EF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 00:47:59 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FkcTm-0004YN-7A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 00:47:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 576F23C5C6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:47:52 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17002-08 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:47:51 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 2A1A53C5AF
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:47:51 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Warnings compiling linux-2.6.17-rc5
Message-ID: <OJEEKGNKKDLJIEPBEJMIEEPICAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <LEEIJGBJEEABAGOFFGAHMEHEDGAA.brocka@sterlingcgi.com>
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
Date: Mon, 29 May 2006 00:47:50 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

> -----Original Message-----
> I actually looked through these patches before asking:
>
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4
> /patches.t
> ar
>
> I didn't see anything that appeared to address this. However, I'll try
> applying these and test from there.

I tried these patches but encountered the errors below. While most of the
patches applied without an issue, I was forced to modify one patch before it
would apply to the 2.6.17-rc5 tree. I had to delete following line from the
patch file externfs:

obj-$(CONFIG_CONFIGFS_FS)       += configfs/

I will retry this compile with externfs disabled.

Tony


  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
fs/built-in.o: In function `humfs_stat_file':
fs/externfs/humfs.c:39: undefined reference to `host_stat_file'
fs/built-in.o: In function `humfs_file_type':
fs/externfs/humfs.c:122: undefined reference to `host_file_type'
fs/built-in.o: In function `humfs_open_file':
fs/externfs/humfs.c:173: undefined reference to `get_path'
fs/externfs/humfs.c:202: undefined reference to `free_path'
fs/built-in.o: In function `humfs_open_dir':
fs/externfs/humfs.c:217: undefined reference to `host_open_dir'
fs/built-in.o: In function `humfs_make_node':
fs/externfs/humfs.c:449: undefined reference to `host_create_file'
fs/externfs/humfs.c:481: undefined reference to `host_unlink_file'
fs/built-in.o: In function `humfs_create_file':
fs/externfs/humfs.c:496: undefined reference to `host_create_file'
fs/built-in.o: In function `humfs_set_attr':
fs/externfs/humfs.c:536: undefined reference to `host_set_attr'
fs/built-in.o: In function `humfs_make_symlink':
fs/externfs/humfs.c:550: undefined reference to `host_make_symlink'
fs/built-in.o: In function `humfs_link_file':
fs/externfs/humfs.c:570: undefined reference to `host_link_file'
fs/built-in.o: In function `humfs_unlink_file':
fs/externfs/humfs.c:587: undefined reference to `host_unlink_file'
fs/built-in.o: In function `humfs_make_dir':
fs/externfs/humfs.c:610: undefined reference to `host_make_dir'
fs/built-in.o: In function `humfs_remove_dir':
fs/externfs/humfs.c:623: undefined reference to `host_remove_dir'
fs/built-in.o: In function `humfs_read_link':
fs/externfs/humfs.c:638: undefined reference to `host_read_link'
fs/built-in.o: In function `humfs_rename_file':
fs/externfs/humfs.c:657: undefined reference to `host_rename_file'
fs/built-in.o: In function `humfs_stat_fs':
fs/externfs/humfs.c:675: undefined reference to `host_stat_fs'
fs/built-in.o: In function `read_superblock':
fs/externfs/humfs.c:777: undefined reference to `host_open_file'
fs/built-in.o: In function `humfs_read_dir':
fs/externfs/humfs.c:229: undefined reference to `generic_host_read_dir'
fs/built-in.o: In function `meta_file_name':
fs/externfs/meta_fs.c:32: undefined reference to `get_path'
fs/externfs/meta_fs.c:49: undefined reference to `get_path'
fs/externfs/meta_fs.c:58: undefined reference to `free_path'
fs/built-in.o: In function `meta_fs_name':
fs/externfs/meta_fs.c:76: undefined reference to `free_path'
fs/built-in.o: In function `metafs_create_file':
fs/externfs/meta_fs.c:152: undefined reference to `get_path'
fs/externfs/meta_fs.c:170: undefined reference to `free_path'
fs/externfs/meta_fs.c:176: undefined reference to `free_path'
fs/built-in.o: In function `metafs_create_link':
fs/externfs/meta_fs.c:188: undefined reference to `host_link_file'
fs/built-in.o: In function `metafs_remove_file':
fs/externfs/meta_fs.c:196: undefined reference to `get_path'
fs/externfs/meta_fs.c:205: undefined reference to `free_path'
fs/built-in.o: In function `metafs_create_directory':
fs/externfs/meta_fs.c:220: undefined reference to `host_make_dir'
fs/externfs/meta_fs.c:224: undefined reference to `host_make_dir'
fs/externfs/meta_fs.c:234: undefined reference to `get_path'
fs/externfs/meta_fs.c:252: undefined reference to `free_path'
fs/externfs/meta_fs.c:254: undefined reference to `host_remove_dir'
fs/built-in.o: In function `metafs_remove_directory':
fs/externfs/meta_fs.c:270: undefined reference to `get_path'
fs/externfs/meta_fs.c:285: undefined reference to `free_path'
fs/externfs/meta_fs.c:287: undefined reference to `get_path'
fs/externfs/meta_fs.c:298: undefined reference to `free_path'
fs/built-in.o: In function `metafs_make_node':
fs/externfs/meta_fs.c:316: undefined reference to `get_path'
fs/externfs/meta_fs.c:332: undefined reference to `free_path'
fs/built-in.o: In function `metafs_rename_file':
fs/externfs/meta_fs.c:455: undefined reference to `free_path'
fs/externfs/meta_fs.c:457: undefined reference to `free_path'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1
#



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
