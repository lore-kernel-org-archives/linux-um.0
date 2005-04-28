Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DR5pg-0004A3-FX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 03:01:20 -0700
Received: from lon-del-02.spheriq.net ([195.46.50.98])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DR5pf-0008GH-Aa
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 03:01:20 -0700
Received: from lon-out-03.spheriq.net ([195.46.50.131])
	by lon-del-02.spheriq.net with ESMTP id j3SA15Vi027255
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:01:05 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-03.spheriq.net with ESMTP id j3SA152J030281
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:01:05 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j3SA10Zo019614
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:01:04 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C275BDA44
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:00:58 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 58C4A520C1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:00:58 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B14D6132A3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 10:00:57 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <000b01c54bd9$24d32150$90b3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: [uml-devel] Question about kernel_thread in UML TT mode
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
Date: Thu, 28 Apr 2005 18:00:40 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

I found UML only implement its own kernel_thread function but doesn't implement kernel_thread_helper function.
Then how does UML start a kernel thread in TT mode? Is there any other functions being called? Thanks a lot!

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
