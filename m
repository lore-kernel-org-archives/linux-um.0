Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fwezs-0007Th-D5 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 05:54:52 -0700
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fwezr-0005WU-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 05:54:52 -0700
Received: by nf-out-0910.google.com with SMTP id y38so413883nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 01 Jul 2006 05:54:48 -0700 (PDT)
Message-ID: <cc723f590607010554q594eaa71xa0e9532d36486458@mail.gmail.com>
Date: Sat, 1 Jul 2006 18:24:48 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] UML and TASK_SIZE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi All,

Will the below test make sense for UML. IF not how to do the same.


 if ((unsigned long)param < TASK_SIZE)
                panic("%s:user address %p not allowed\n", __FUNCTION__, param);

-aneesh

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
