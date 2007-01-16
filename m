Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H6o5z-0003Ok-Dw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 05:11:23 -0800
Received: from wr-out-0506.google.com ([64.233.184.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H6o5z-00006X-1M
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 05:11:23 -0800
Received: by wr-out-0506.google.com with SMTP id 70so1527085wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 16 Jan 2007 05:11:22 -0800 (PST)
Message-ID: <3cb76b010701160511i1ff30a49k467fc1f4d5887c94@mail.gmail.com>
Date: Tue, 16 Jan 2007 08:11:20 -0500
From: "Sapan Bhatia" <sapan.bhatia@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] FC4 rootfs - crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1830969669=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1830969669==
Content-Type: multipart/alternative; 
	boundary="----=_Part_69196_19699979.1168953080871"

------=_Part_69196_19699979.1168953080871
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm using UML 2.6.19.2 on a 2.6.19-skas3 host, and observing the following
when I try booting with a root fs based on FC4/glibc- 2.6-20. UML gets stuck
with a 'Warning: unable to open an initial console'. gdb shows that it's
because it gets a stream of infinite segfaults. When I boot off another
rootfs and try to chroot into the one with FC4, it segfaults out. strace
shows that this happens just after libc is ldopened.. at a call to
rt_sigprocmask.

So I tried regressing glibc, and now (with glibc-2.6.3) chroot works, but
UML still gets stuck at the same place when I try to boot.

Sapan

------=_Part_69196_19699979.1168953080871
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;m using UML <a href="http://2.6.19.2" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.19.2</a> on a 2.6.19-skas3 host, and observing the following when I try booting with a root fs based on FC4/glibc-
2.6-20. UML gets stuck with a &#39;Warning: unable to open an initial console&#39;. gdb shows that it&#39;s because it gets a stream of infinite segfaults. When I boot off another rootfs and try to chroot into the one with FC4, it segfaults out. strace shows that this happens just after libc is ldopened.. at a call to rt_sigprocmask.
<br><br>So I tried regressing glibc, and now (with glibc-2.6.3) chroot works, but UML still gets stuck at the same place when I try to boot.<br><br>Sapan<br>


------=_Part_69196_19699979.1168953080871--


--===============1830969669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1830969669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1830969669==--
