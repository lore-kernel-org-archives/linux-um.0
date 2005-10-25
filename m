Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUWUZ-0003V7-QT	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 14:37:59 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EUWUY-00029H-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 14:37:59 -0700
Message-ID: <435EA5AF.30406@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS race condition status?
References: <43542ACC.7020108@theshore.net> <435E60F1.2010005@linode.com>
	<435E63E8.2020702@theshore.net> <200510251958.14798.blaisorblade@yahoo.it>
In-Reply-To: <200510251958.14798.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 25 Oct 2005 16:37:51 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, peter.spamcatcher@rimuhosting.com

Blaisorblade wrote:
> After some researches, it seems that the matching errata document is this one:
> 
> http://www.intel.com/design/xeon/specupdt/302402.htm
> 
> which would imply you have a 64-bit enabled processor... 
> 
> Note 1: that's not the only document matching, but the other is for 64-bit 
> processors too
> 
> Note 2: I couldn't match steppings between those docs and cpuinfo...

OK.  I matched up some purchase orders with Intel part numbers:

BX80546KG3200FU <-- model 4
BX80546KG3200EU <-- model 3 (I think)

I'll start disabling HyperThreading on hosts that crash next.

-Chris


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
