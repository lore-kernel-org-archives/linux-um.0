Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFvP3-0003ak-QF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 07:07:25 -0700
Received: from ps11.kent.dot.net.au ([202.147.78.203])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFvOt-00040N-BI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 07:07:25 -0700
Received: from ip-80-7.dot.net.au ([202.147.80.7] helo=[192.168.1.103])
	by ps11.kent.dot.net.au with esmtp (Exim 3.35 #4) id 1CFuph-0000hf-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 23:30:53 +1000
From: James Roper <u3205097@anu.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410082331.08930.u3205097@anu.edu.au>
Subject: [uml-devel] Compile error with 2.6.8 patch
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
Date: Fri, 8 Oct 2004 23:31:08 +1000
To: user-mode-linux-devel@lists.sourceforge.net

I got the following compile error with the latest 2.6.8.1-1 UML patch from the 
website:
arch/um/kernel/ksyms.c:90: error: redefinition of `__kcrctab_os_ioctl_generic'
arch/um/kernel/ksyms.c:76: error: `__kcrctab_os_ioctl_generic' previously 
defined here

Fixed it by removing the extra
EXPORT_SYMBOL(os_ioctl_generic);
at line 90 in ksyms.c

James


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
