Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYDx3-000376-E9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 18:01:53 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BYDx2-0001K7-TS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 18:01:53 -0700
Message-Id: <200406100152.i5A1q5is009173@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: The SKAS4 patch?? + ideas for 0 context-switch 
In-Reply-To: Your message of "Wed, 09 Jun 2004 23:05:24 +0200."
	<200406092305.24447.blaisorblade_spam@yahoo.it> 
References: <200406071949.04220.blaisorblade_spam@yahoo.it>
	<200406080455.i584tad2023374@ccure.user-mode-linux.org>
	<200406092305.24447.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 09 Jun 2004 21:52:05 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I don't think that a flush of fewer TLBs would be faster; what (In My
> Ignorant  Opinion) slows things down is not clearing a buffer (it will
> probably cost 1  cycle, if they put a RESET pin in the TLBs), but
> reloading its content when  memory is read;

> Well, actually it comes to changing 2 segments descriptors (the ones
> for  USER_CS and USER_DS)

> Well, using segments here means that the CS and DS descriptor limit
> are  lowered, not that I increase base_addr - are you sure that this
> would have a  cost? Currently the check is not "disabled" - just the
> check value is MAX_PTR  (0xffff....). Yes, the CPUs could be smart
> enough to optimize the check  out...

You are being way too casual and hard-waving about all this.  I've heard
scary numbers for all of these.

> I'll try to see if Intel manuals say anything about this.

Yes, spend some quality time with the Intel manuals, and see what they say.

> Well, this is the most important one... I'll try to investigate on
> this. 

Actually, the most important factor to me is virtual address space.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
