Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CGMXb-0006LC-0H for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 12:06:03 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CGMXZ-00005E-NG for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 12:06:02 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CGMXX-0003Oi-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Oct 2004 21:05:59 +0200
Received: from 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	([209.6.22.202]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Oct 2004 21:05:59 +0200
Received: from lars by 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Oct 2004 21:05:59 +0200
From: Lars Kellogg-Stedman <lars@oddbit.com>
Message-ID: <lars-9B68ED.15055709102004@sea.gmane.org>
References: <200410091057.52832.u3205097@anu.edu.au>
	<lars-EF506D.14170609102004@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Missing exported symbols?
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
Date: Sat, 09 Oct 2004 15:05:57 -0400
To: user-mode-linux-devel@lists.sourceforge.net

> I'm seeing the same error (memmove undefined) while trying to build UML 
> 2.6.8.1.

FWIW, after removing support for externfs/hostfs and friends, the only 
remaining error is the missing memmove.  For example:

> WARNING: /tmp/myroot/lib/modules/2.6.8.1-1um/kernel/net/sunrpc/sunrpc.ko 
> needs unknown symbol memmove

-- Lars



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
