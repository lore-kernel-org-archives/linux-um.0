Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxeBV-0000Ao-AA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 20:38:09 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CxeBU-000655-OK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 20:38:09 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.61.0502052333110.6550@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] linux-2.6.11-rc3-bk2-jdike-uml-compile-fixes;
	UDF FS won't compile.
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
Date: Sat, 5 Feb 2005 23:38:21 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, all,
 	Just for reference, if I have the UDF filesystem turned on, I get 
this error at the end of the compile:


   LD      .tmp_vmlinux1
/usr/lib/libc.a(mktime.o)(.rodata+0x0): multiple definition of 
`__mon_yday'
fs/built-in.o(.rodata+0x36a0):fs/buffer.c:331: first defined here
collect2: ld returned 1 exit status
   KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
/bin/bash: line 1:  7871 Exit 1                  nm -n .tmp_vmlinux1
       7872 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
make: *** [.tmp_kallsyms1.S] Error 139

 	If it makes a difference, /usr/lib/libc.a is owned by 
glibc-devel-2.3.4-2.fc3 .
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Any sufficiently advanced technology is indistinguishable from
magic."
 	-- Arthur C. Clark (?)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
