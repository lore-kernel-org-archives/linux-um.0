Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtkJy-0001jR-U9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 02:22:46 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtkJy-0006xS-4K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 02:22:46 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CtkJv-0000mh-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Jan 2005 11:22:43 +0100
Received: from dsl-082-082-127-166.arcor-ip.net ([82.82.127.166])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Jan 2005 11:22:43 +0100
Received: from skoehler by dsl-082-082-127-166.arcor-ip.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Jan 2005 11:22:43 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <ct7r17$cqj$1@sea.gmane.org>
References: <41F54FE9.7060503@better.se>
	<200501242113.16569.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200501242113.16569.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: skas3 patch breaks ATI video drivers
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
Date: Wed, 26 Jan 2005 11:24:50 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> I.e. the compilation problem is not in the kernel module, right? In this case, 
> the problem is that you have /usr/include/asm symlinked to your kernel's 
> include/asm-i386 directory, which is the wrong setup. However your solution 
> should not give any problem.

Kernel-Modules are usually compiled against the sources in either 
/usr/src/linux or /lib/modules/<version>/build.

Take a look at the nvidia-kernel ebuild or other ebuilds that build 
kernel modules. It would be fatal to compile them against the headers in 
/usr/include. On Gentoo, you can have linux26-headers-2.6.7 installed, 
but actually be running a 2.6.10 Kernel - and even worse, it is even 
possible to keep 2.4 headers when running a 2.6 kernel.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
