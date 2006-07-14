Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1Gz3-0000Ip-0B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 23:17:05 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1Gz2-0001OS-Hl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 23:17:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id EA6643C7E7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Jul 2006 23:17:03 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01709-02 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Jul 2006 23:17:02 -0700 (PDT)
Received: from sterling (c-67-164-103-110.hsd1.or.comcast.net [67.164.103.110])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 6BF8D3C7D4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Jul 2006 23:17:02 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Date: Thu, 13 Jul 2006 23:17:08 -0700
Message-ID: <CBELIFGMBIEPIEOFCJFACENKCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Subject: [uml-devel] Tomcat5 fails to run after UML kernel upgrade
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

I'm running Tomcat5 on a virtual server instance. I just tried to upgrade
the UML kernel (and guest) to a 2.6.17.4 version. Previously the host was
running 2.6.16.9-skas3-v8.2 and the guest was running 2.6.17-rc6. Both host
and guest are Debian Etch distributions.

However, with the host running 2.6.17.4-skas3-v9-pre9 and the guest running
a stock 2.6.17.4, I'm now experiencing a problem with Tomcat on startup.
Unfortunately, I don't have enough knowledge of Tomcat to get more detail,
but the following appears in the /var/log/tomcat5/catalina_2006-07-14.log
file:

Using CATALINA_BASE:   /var/lib/tomcat5
Using CATALINA_HOME:   /usr/share/tomcat5
Using CATALINA_TMPDIR: /var/lib/tomcat5/temp
Using JAVA_HOME:       /usr/lib/kaffe
Using Security Manager
Internal error: caught an unexpected exception.
Please check your CLASSPATH and your installation.
java/lang/NullPointerException

However, reversing the guest kernel back to 2.6.17-rc6 allows the Tomcat
server to start normally (leaving the host at 2.6.17.4-skas3-v9-pre9).

I haven't seen anything specific to Tomcat cross the list recently. However,
is there a known bug in the stock 2.6.17.4 kernel that would cause this
behavior? Any suggestions on how to get more detailed information on the
crash?

I originally attached a copy of the relevant config files for all 4 kernels.
However, the message was moderated due to size. Please contact me if you
would like copies of the configuration files for the different kernels.
Also, it's worth noting that the configuration for both guest kernels are
identical.

Any suggestions or advice is appreciated!

Tony




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
