Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhXQ3-0005Ot-U0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 09:06:03 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AhXQ1-0003Q6-39
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 09:06:01 -0800
Message-Id: <200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0 
In-Reply-To: Your message of "Fri, 16 Jan 2004 10:03:11 GMT."
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk> 
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
Date: Fri, 16 Jan 2004 12:27:20 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> Actually, I am no longer convinced the lack of these syscalls cause
> the problem directly; I think there is something else in recent glibcs
> that cause the kernel to hang, at least in tt mode, though it is
> probably related. 

Maybe, but it's a definite problem.  However, the segfaults people were seeing
with 2.6.1 may be gone since that was a separate problem which is fixed in
the 2.6.1 patch.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
