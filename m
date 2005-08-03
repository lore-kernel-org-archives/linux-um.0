Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0Vbw-00011d-RG	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 19:37:32 -0700
Received: from e32.co.us.ibm.com ([32.97.110.130])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E0Vbw-0003xK-Gf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 19:37:32 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j742bGkQ787766
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 22:37:16 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com
	[9.17.195.168])j742bOxJ189344
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 20:37:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	j742bGlF008622	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 20:37:16 -0600
Received: from snowy.in.ibm.com ([9.182.63.175])j742bDkm008581
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 20:37:15 -0600
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [uml-devel] Host kernel requirements for UML
Message-ID: <20050803171507.GA15047@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050803094805.GA6090@in.ibm.com>
	<20050803143957.GB4701@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803143957.GB4701@ccure.user-mode-linux.org>
Resent-To: user-mode-linux-devel@lists.sourceforge.net
Resent-Message-Id: <20050803171620.7123E250E0@snowy.in.ibm.com>
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
Date: Wed, 3 Aug 2005 22:45:07 +0530
To: Jeff Dike <jdike@addtoit.com>

On Wed, Aug 03, 2005 at 10:39:57AM -0400, Jeff Dike wrote:
> On Wed, Aug 03, 2005 at 03:18:05PM +0530, Srivatsa Vaddagiri wrote:
> > Hi,
> > 	I am trying to get a quick answer for a question I had on UML.
> > As I understand, UML kernel makes use of host kernel's 
> > system call interface for its functionality. The questions is, does the
> > host kernel need to support *all* system calls or only a subset?
> 
> Only a small subset.

Thanks for the info. Is there any place where this subset is documented?
I was hoping to avoid looking at the unresoled symbols in UML binary to 
get this info!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
