Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrR3j-0004Im-Is for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Aug 2004 17:52:11 -0700
Received: from dns02.mail.yahoo.co.jp ([211.14.15.205])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BrR3j-0003L7-39 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Aug 2004 17:52:11 -0700
Message-ID: <410D9031.3080900@yahoo.co.jp>
From: kaz <shigekazun@yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] patches test results
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
Date: Mon, 02 Aug 2004 09:52:01 +0900
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

Here's my patches test results.
Applied + marked patches in order. Works fine. Thanks,

------------------------------------
kernel-source-2.6.7
http://packages.debian.org/kernel-source-2.6.7
------------------------------------
+ uml-patch-2.6.7-1
http://user-mode-linux.org/mirror/uml-patch-2.6.7-1.bz2
------------------------------------
http://user-mode-linux.sourceforge.net/patches.html
- remap			included in uml-patch-2.6.7-1
+ no-target
+ makefile-fixes
+ remove_old_bh
+ reboot-signals
- wrap-malloc		UML won't boot
- remove-user-code	UML won't boot
+ unused-header
+ time
+ copy_user
+ aio
+ filehandle
+ filehandle_switch
+ random
+ physmem_mmap
+ uaccess
+ externfs
------------------------------------
http://user-mode-linux.org/~blaisorblade/patches/bb/uml-patch-2.6.7-01-bb2.tar.bz
- Main-uml-patch-no-skas.patch	included in uml-patch-2.6.7-1 ?
- Ghash.patch			not cleanly applied
+ disable-UnitAtATime.patch
- HostFs-2.6-fd_leak.patch	not cleanly applied
+ LegacyTerminalSupport.patch
- MakeHelp.patch		not cleanly applied
+ H-02-Fixdep-improve.patch
- fix-warnings.patch		not cleanly applied
+ NR_tkill_undefined.patch
+ Move_away_from_user.patch
- Add_os_make_pty_raw.patch	not cleanly applied
+ Hostaudio_clean.patch
+ um-sysemu.patch
+ sysemu_cmdParam.patch
+ proc_sysemu.patch
- EINTR_safety.patch		not cleanly applied
- Export_strncpy.patch		not cleanly applied
------------------------------------
http://www.theshore.net/~caker/uml/patches/
+ token-limiter-v1.patch
+ proc-io_status.diff
------------------------------------

Host
------------------------------------
kernel-source-2.6.7
http://packages.debian.org/kernel-source-2.6.7
------------------------------------
host-sysemu-2.6.7-1.patch
http://sysemu.sourceforge.net/
------------------------------------
skas-leak-fix-2.6.patch
http://sf.net/mailarchive/forum.php?thread_id=5186596&forum_id=3648
------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
