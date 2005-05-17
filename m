Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXyXK-0006Kn-Ax	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 02:38:50 -0700
Received: from fra-del-04.spheriq.net ([195.46.51.100])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DXyXJ-0005dJ-6c
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 02:38:50 -0700
Received: from fra-out-01.spheriq.net (fra-out-01.spheriq.net [195.46.51.129])
	by fra-del-04.spheriq.net with ESMTP id j4H9cd0s010023
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:39 GMT
Received: from fra-cus-01.spheriq.net (fra-cus-01.spheriq.net [195.46.51.37])
	by fra-out-01.spheriq.net with ESMTP id j4H9cOel020495
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:24 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by fra-cus-01.spheriq.net with ESMTP id j4H9cVC6024497verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:36 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 268BBDA43
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:30 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9919B520CA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:29 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A507F13307
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 09:38:28 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <006101c55ac4$2ccbf0e0$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Question about the kernel thread in UML TT mode
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
Date: Tue, 17 May 2005 17:38:21 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

In UML,when do_fork was called,the new process P will be created in UML. Then in copy_thread_tt(in fact in start_fork_tramp)the corresponding process Q will be created in the host linux. I know the pid of the corresponding host process Q is appointed as the extern_pid of the UML process P. But then how will the 2 processes do next individually?

In UML,the function copy_thread_tt call start_fork_tramp, which cloned a thread. Once the thread was created it will run the outer_tramp function,in which cloned another thread. Once the second thread was created it will run the tramp function(fork_tramp or new_thread_proc). In fact the first thread is a temp one.it will kill itself later.Then why does UML clone 2 threads in copy_thread_tt?

In UML,when the kernel_thread was called,the UML kernel thread P will be created in copy_process. And the corresponding host thread Q will be create in copy_thread_tt. Then the host thread Q will run its SIGUSR1 signal handler new_thread_handler,which will call run_kernel_thread function and exited at last. But I think it should be the UML kernel thread P that call run_kernel_thread function, any problems? 

Thanks a lot!

Alex




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id344&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
