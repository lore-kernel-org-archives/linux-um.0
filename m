Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CG5YJ-0006zp-EQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 17:57:39 -0700
Received: from ps11.kent.dot.net.au ([202.147.78.203])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CG5YI-0007tL-D0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 17:57:39 -0700
Received: from ip-80-7.dot.net.au ([202.147.80.7] helo=[192.168.1.103])
	by ps11.kent.dot.net.au with esmtp (Exim 3.35 #4) id 1CG5YA-00070U-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 10:57:31 +1000
From: James Roper <u3205097@anu.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410091057.52832.u3205097@anu.edu.au>
Subject: [uml-devel] Missing exported symbols?
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
Date: Sat, 9 Oct 2004 10:57:52 +1000
To: user-mode-linux-devel@lists.sourceforge.net

I'm still using the 2.6.8 uml patch release, and I'm getting heaps of errors 
complaining about unknown symbols.  In particular:
WARNING: ../mnt/ lib/modules/2.6.8-1um/kernel/fs/cifs/cifs.ko needs unknown 
symbol memmove
Which I need as I'm doing cifs development.  I saw an incremental 2.6.9-rc2 
patch that said it added heaps of exported symbols, is there anything for 
2.6.8?  Or is there a simple way to export the memmove symbol?

I guess compiling cifs into the kernel would fix the problem altogether, 
though wouldn't it...

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
