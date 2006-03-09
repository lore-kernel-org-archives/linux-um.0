Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20060221071402.EB05F338E2@sc8-sf-spam1.sourceforge.net>
References: <20060221071402.EB05F338E2@sc8-sf-spam1.sourceforge.net>
Content-Type: text/plain
Message-Id: <1141870804.10157.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] new filesystem images
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
Date: Thu, 09 Mar 2006 02:20:04 +0000
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi list,

I have added some new images here:
http://uml.nagafix.co.uk/
Fedora Core 4 AMD64, Mandriva-2006 x86 & AMD64, OpenSuse x86.
All these now work well with TLS, tested with 2.6.15.6-bs3-tls.
The last images should be uploaded by the time you get this email.

I still have to rebuild some new Honeypot images - avoid those.
Also, do not use FC4-x86, this one still has a problem with TLS.
Do let me know of any problems.

Antoine


PS: here is the problem with FC4-x86:

Setting hostname localhost:  [  OK  ]
set_thread_area failed when setting up thread-local storage
/etc/rc.d/rc.sysinit: line 323:  1441 Done                    echo
"raidautorun /dev/md0"
      1442 Segmentation fault      | nash --quiet
set_thread_area failed when setting up thread-local storage
/etc/rc.d/rc.sysinit: line 340:  1445 Done                    echo
"mkdmnod"
      1446 Segmentation fault      | /sbin/nash --quiet >/dev/null 2>&1
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/ubda
set_thread_area failed when setting up thread-local storage
Warning... fsck.ext3 for device /dev/ubda exited with signal 11.
[FAILED]



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
