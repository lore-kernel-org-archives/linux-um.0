Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CjLEr-0006HN-Q9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Dec 2004 09:34:29 -0800
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CjLEr-0003ri-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Dec 2004 09:34:29 -0800
Received: from lon-inc-03.spheriq.net ([195.46.50.67])
	by lon-del-03.spheriq.net with ESMTP id iBSHYKeG010444
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:20 GMT
Received: from lon-out-01.spheriq.net (lon-out-01.spheriq.net [195.46.50.129])
	by lon-inc-03.spheriq.net with ESMTP id iBSHYKDt028358
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:20 GMT
Received: from lon-cus-01.spheriq.net (lon-cus-01.spheriq.net [195.46.50.37])
	by lon-out-01.spheriq.net with ESMTP id iBSHYKv5004711
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:20 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-01.spheriq.net with ESMTP id iBSHYH7C003796
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:20 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4C874DA41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:16 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BC436520C7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:15 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2AEE913328
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Dec 2004 17:34:15 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <00c901c4ed03$7313d1a0$83655e0a@sha.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: [uml-devel] Do_signal in tt mode
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
Date: Wed, 29 Dec 2004 01:34:14 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

In i386 do_signal is called just after the system call so the processes can deal with their signals.But uml has changed the system call interface. When and how do the traced threads in uml tt mode receive their signals? I used the uml 2.6.7 version. Thanks!

Alex





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
