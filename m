Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dkfm6-0005z0-Sj	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 03:14:34 -0700
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dkfm4-0005DZ-V8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 03:14:34 -0700
Received: from lon-out-03.spheriq.net ([195.46.50.131])
	by lon-del-03.spheriq.net with ESMTP id j5LAEN3W016507
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:14:23 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-03.spheriq.net with ESMTP id j5LAE2Gf005992
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:14:02 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j5LAEHai025984verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:14:21 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A8140DAAA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:06:19 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C93C6520CE
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:06:15 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C3AC813309
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Jun 2005 10:06:14 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <000401c57648$d8f03170$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Question about the unexpected signal 11 when fork in
	UML-2.6.7 TT mode
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
Date: Tue, 21 Jun 2005 18:05:51 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

When I fork() in UML TT mode,it always said "the sleeping process xxx received unexpedted signal 11" and the UML hang...before fork I also set the signal handler...
My UML is 2.6.7 and I used TT mode.Thanks a lot!

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
