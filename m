Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoVD4-0003k0-QC
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 14:09:26 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AoVD4-0004pM-Ae
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 14:09:26 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id i14M9C124738
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 4 Feb 2004 22:09:12 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id i14M9B7V005661
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 4 Feb 2004 22:09:11 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id i14M9BH29658
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 4 Feb 2004 22:09:11 GMT
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Hang on boot with 2.6.*
In-Reply-To: <1075930245.7569.15.camel@wopr.tektonic.net>
Message-ID: <Pine.GSO.4.58.0402042204280.28743@altair.dur.ac.uk>
References: <1075921947.7569.7.camel@wopr.tektonic.net> 
 <200402042042.09932.blaisorblade_spam@yahoo.it> <1075930245.7569.15.camel@wopr.tektonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 4 Feb 2004 22:09:11 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, 4 Feb 2004, Matt Ayres wrote:

> ...
>
> The OS is RedHat 9 (glibc with NTPL), hence my reason for wanting 2.6
> because it includes NTPL whereas 2.4 does not.  It seems odd that 2.6
> wouldn't work with a NTPL enabled glibc, is this a known problem?  I've
> been following the threads regarding 2.6, but I seem to have missed
> that.

Yes it is a known problem, and should be fixed in 2.6.2-1um, or whatever
the next release is. The solution is to edit
include/asm-um/archparam-i386.h and change the definition of
VSYSCALL_BASE to be NULL .

	Michael Young


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
