Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DwIly-0003Iu-D7	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Jul 2005 05:06:30 -0700
Received: from lon-del-02.spheriq.net ([195.46.50.98])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1DwIlv-0006Iw-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Jul 2005 05:06:30 -0700
Received: from lon-out-01.spheriq.net ([195.46.50.129])
	by lon-del-02.spheriq.net with ESMTP id j6NC6FfP005142
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:15 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-01.spheriq.net with ESMTP id j6NC6EIh004604
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:15 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j6NC6BFX020973verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:14 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8BCDADA41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:06 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 07CA0520C1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:05 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6F087132A3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jul 2005 12:06:05 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <000001c58f7e$de9fc0f0$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] SIGSEGV handle in UML TT mode
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
Date: Sat, 23 Jul 2005 20:05:40 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

I run a process in UML TT mode. Because of some reason(I don't know yet) the process will run it's SIGSEGV signal handler segv_handler then call segv and at last call force_sig_info(SIGSEGV,&si,current).

Now I have 2 questions:

1.after tracing I found the process hadn't receive a SIGSEGV signal. Since it didn't call handle_signal before that. And it seems that send_signal hadn't be called to send the SIGSEGV signal to the process. So in UML TT mode,is there any posibility that a process can run the segv_handler without a SIGSEGV signal?

2.in segv,why it will call force_sig_info(SIGSEGV,&si,current) to send the SIGSEGV signal to itself again? Since it has been in the SIGSEGV handler.

And is there any good way to trace the reason which cause the SIGSEGV signal in UML TT mode?

Thanks a lot!

Alex




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
