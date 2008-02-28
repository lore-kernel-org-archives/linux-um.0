Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUsBL-0000OZ-VI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Feb 2008 15:29:02 -0800
Received: from wx-out-0506.google.com ([66.249.82.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUsBK-0006FI-N7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Feb 2008 15:28:55 -0800
Received: by wx-out-0506.google.com with SMTP id h31so3861062wxd.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Feb 2008 15:28:53 -0800 (PST)
Message-ID: <88e04e60802281528j302b61bbv2780c23f2614e8cd@mail.gmail.com>
Date: Thu, 28 Feb 2008 18:28:53 -0500
From: "Weiming Liu" <runemass.cse@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] questions about mconsole driver and process address space
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1906839933=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1906839933==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14857_2072452.1204241333576"

------=_Part_14857_2072452.1204241333576
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi. I am doing some experiment on mconsole driver. My wish is to create a
new user process from mconsole driver, modifying its address space, changing
its file mapping... Eventually may be I can migrate a process from host or
between UML instances. I am a newbie to both kernel and UML, and I have
several questions on implementation:

1. create a new process from a kernel thread. It seems that mconsole uses a
work queque, and requests are processed at kevents thread. Right now what I
am doing is, creating a new kernel thread and letting it call sys_ececve().
I then find its task_struct by looking for its name and its parent. It seems
stupid and maybe not correct. Is there any better way to do this?

2. I need to manipulate the process' address space (memory segments, file
mappings) like what flush_old_exec() and do_mmap() are doing. I cannot find
a way to call those functions since I am in a kernel thread, and it seems
too complicated by working directly on page tables and memory. How can this
be done in a convenient way?

Thanks,
Weiming Liu

------=_Part_14857_2072452.1204241333576
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi. I am doing some experiment on mconsole driver. My wish is to create a new user process from mconsole driver, modifying its address space, changing its file mapping... Eventually may be I can migrate a process from host or between UML instances. I am a newbie to both kernel and UML, and I have several questions on implementation:<br>
<br>1. create a new process from a kernel thread. It seems that mconsole uses a work queque, and requests are processed at kevents thread. Right now what I am doing is, creating a new kernel thread and letting it call sys_ececve(). I then find its task_struct by looking for its name and its parent. It seems stupid and maybe not correct. Is there any better way to do this?<br>
<br>2. I need to manipulate the process&#39; address space (memory segments, file mappings) like what flush_old_exec() and do_mmap() are doing. I cannot find a way to call those functions since I am in a kernel thread, and it seems too complicated by working directly on page tables and memory. How can this be done in a convenient way?<br>
<br>Thanks,<br>Weiming Liu<br>

------=_Part_14857_2072452.1204241333576--


--===============1906839933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1906839933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1906839933==--

