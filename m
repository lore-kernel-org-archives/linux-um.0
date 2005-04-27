Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQiMM-0002Ju-K0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 01:57:30 -0700
Received: from lon-del-02.spheriq.net ([195.46.50.98])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQiMJ-0006Gy-Jo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 01:57:30 -0700
Received: from lon-out-03.spheriq.net ([195.46.50.131])
	by lon-del-02.spheriq.net with ESMTP id j3R8vID7022537
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:57:18 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-03.spheriq.net with ESMTP id j3R8vIDV004819
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:57:18 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j3R8vE5R013510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:57:17 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 632A9DA43
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:57:12 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 61306520C1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:56:58 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7D2E31329E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 08:56:57 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <002801c54b07$0cdde490$90b3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: [uml-devel] Question about syscall in UML tt mode
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
Date: Wed, 27 Apr 2005 16:56:47 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi all:

Now I added a system call in UML which should use pt_regs as its parameter. So the system call is "sys_XXX(struct pt_regs)" just like sys_fork(struct pt_regs) under i386 architecture. But I didn't find any syscall under UML which use pt_regs as its parameter. 

I found the EXECUTE_SYSCALL(syscall,regs) in UML is defined only with 6 parameters which are ebx,ecx.... So I think I can't use pt_regs as my syscall parameter,right?

So I directly use current->thread.regs in my system call. It seems worked.

I want to know whether it's safe to do that. Thanks!

Alex



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id5hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
