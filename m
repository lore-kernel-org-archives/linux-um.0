Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFiZl-0001Wt-QY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 19:34:41 -0700
Received: from mail2.tqmcube.com ([65.98.66.133] helo=mail.tqmcube.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GFiZj-0004FG-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 19:34:41 -0700
Received: from dch.TQMcube.com (mailone.tqmcube.com [68.236.166.73])
	by mail.tqmcube.com (Postfix) with ESMTP id B43B12B553
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Aug 2006 22:34:32 -0400 (EDT)
Date: Tue, 22 Aug 2006 22:34:32 -0400
From: David Cary Hart <DavidHart@TQMcube.com>
Message-ID: <20060822223432.3f9b3d3e@dch.TQMcube.com>
Mime-Version: 1.0
Subject: [uml-devel] IPTables Issues on UML Host
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

I hope that this is the right list.

I have a VDS on UML. Kernel=2.6.17.9

I have re-install netfilter several times and the host just
recompiled the kernel.

I keep getting the following error:
# iptables-save >/etc/sysconfig.iptables
Can't find library for match `tcp'

libipt_tcp.so is where it should be in /lib/iptables. What am I
missing?

Thanks.

-- 
Our DNSRBL - Eliminate Spam at the Source: http://www.TQMcube.com
               Don't Subsidize Criminals: http://boulderpledge.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
