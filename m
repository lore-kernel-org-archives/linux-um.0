Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahx7K-0007qF-HO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:32:26 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahx7K-0000O9-15 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:32:26 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id i0HKWHn22077
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 20:32:17 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id i0HKWGg8004980
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 20:32:16 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id i0HKWFN12269
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 20:32:15 GMT
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] uml-patch-2.6.0
In-Reply-To: <200401172009.50449.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.GSO.4.58.0401172027460.11676@altair.dur.ac.uk>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 17 Jan 2004 20:32:15 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, 17 Jan 2004, BlaisorBlade wrote:

> I've updated all the stuff that was there. You claimed you didn't want some
> patches, now I've organized things so they can be easily excluded. Do *not*
> use the combo.
>
> This are some brief patches descriptions (in the 00-README).
> C-03 (trivial, removes smplock.h which went away)
> C-04 (sys-i386/fault.c shouldn't even compile for now, as the exception
> handling has had a syntactic change)
> G-01 (one-liner for SELinux build, from M A Young)

Actually, I got it from u-m-l-d; it was originally by someone else,
possibly Russell Coker.


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
