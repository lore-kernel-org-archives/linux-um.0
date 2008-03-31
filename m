Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgIOt-0003fI-RG for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 04:42:07 -0700
Received: from fg-out-1718.google.com ([72.14.220.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JgIOt-0001Ud-Fc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 04:42:07 -0700
Received: by fg-out-1718.google.com with SMTP id d23so1342232fga.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 31 Mar 2008 04:42:06 -0700 (PDT)
Message-ID: <a6f02da10803310442v7ca51ad9vc8926a4881bb6b28@mail.gmail.com>
Date: Mon, 31 Mar 2008 19:42:05 +0800
From: "fang zheng" <benbencan@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] about system call (how it run)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0826651253=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============0826651253==
Content-Type: multipart/alternative; 
	boundary="----=_Part_39932_17435746.1206963725835"

------=_Part_39932_17435746.1206963725835
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi :
    while in user mode, processes have their system calls intercepted and
virtualized, in kernel mode, they are released from tracing and their system
calls run directly in the host kernel.
what I want to know is since in kernel mode ,why the system calls run
directly in the host kernel?
Does the UML kernel share the same space with the host kernel?
Since UML runs as a user process on the host OS, its UML kernel should run
in the host user space.
namely, the UML kernel runs in the host user space. If it is true,how a
system call runs in a user space?
eager to your answers.

thanks very much.

------=_Part_39932_17435746.1206963725835
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi :</div>
<div>&nbsp;&nbsp;&nbsp; while in user mode, processes have their system calls intercepted and virtualized, in kernel mode, they are released from tracing and their system calls run directly in the host kernel.</div>
<div>what I want to know is since in kernel mode ,why the system calls run directly in the host kernel?</div>
<div>Does the UML kernel share the same space with the host kernel?</div>
<div>Since UML runs as a user process on the host OS, its UML kernel should run in the host user space.</div>
<div>namely, the UML kernel runs in the host user space. If it is true,how a system call runs in a user space?</div>
<div>eager to your answers.</div>
<div>&nbsp;</div>
<div>thanks very much.</div>

------=_Part_39932_17435746.1206963725835--


--===============0826651253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0826651253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0826651253==--

