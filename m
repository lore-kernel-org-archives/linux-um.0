Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CkmCC-0007YC-GW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jan 2005 08:33:40 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CkmC7-0003Pd-HP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jan 2005 08:33:40 -0800
Message-ID: <49797.80.203.9.2.1104597206.squirrel@80.203.9.2>
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] uml_console_write
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
Date: Sat, 1 Jan 2005 17:33:26 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

if you enable all semaphore locking debuing and such alike, you get a
warning at uml_console_write calliong __might_sleep with irqs_disabled()

The callpath are on another machine, byt here the names are

__might_sleep
uml_console_write
__call_console_drivers
call_console_drivers
release_console_drives
vprintk
printk
ext2_warning
ext2_fill_super
get_sb_bdev
__kmalloc
ext2_get_sb
ext2_fill_super
do_kern_mount
do_new_mount
do_mount
copy_from_user_tt
excact_copy_from_user
copy_mount_options
sys_mount
execute_syscall_tt
syscall_handler_tt
unblock_signals
sig_handler_common
set_user_mode
sig_handler
__restore



Stian


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
