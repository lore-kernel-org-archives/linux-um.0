Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQiYF-0002uW-D7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 02:09:47 -0700
Received: from fra-del-03.spheriq.net ([195.46.51.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQiYC-0007tN-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 02:09:47 -0700
Received: from fra-out-02.spheriq.net (fra-out-02.spheriq.net [195.46.51.130])
	by fra-del-03.spheriq.net with ESMTP id j3R99Wmn022848
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:09:32 GMT
Received: from fra-cus-02.spheriq.net (fra-cus-02.spheriq.net [195.46.51.38])
	by fra-out-02.spheriq.net with ESMTP id j3R99VQk024286
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:09:31 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by fra-cus-02.spheriq.net with ESMTP id j3R99Qi7031784
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:09:30 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 390B1DA42
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:09:09 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A4463520C1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:04:46 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A2F21336A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 09:04:45 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <002901c54b08$223494a0$90b3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Question about UML gdb
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
Date: Wed, 27 Apr 2005 17:04:34 +0800
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi all:

I have 2 questions about UML gdb:

1.how to get the address of current process UML gdb?
It seems "esp & 0xffffe000" is not the correct address.

2.how to read the contents of a file in UML gdb?
The file is an object of struct file. I only know the address of the file.

Thanks a lot!

Alex



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
