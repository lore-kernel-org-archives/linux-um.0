Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqi3r-0004dN-7S
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 10 Feb 2004 16:17:03 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aqi3c-0001YV-JK
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 10 Feb 2004 16:16:48 -0800
Message-Id: <200402110043.i1B0hOip004189@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Swapping directly to host swap area? 
In-Reply-To: Your message of "Thu, 05 Feb 2004 17:59:03 +0100."
             <200402051759.03917.blaisorblade_spam@yahoo.it> 
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow> <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>  <200402051759.03917.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 10 Feb 2004 19:43:24 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: William Stearns <wstearns@pobox.com>, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> About this, my idea was that using swap both on the host and on the
> guests is  not very useful: 

My suggestions were aimed at making the host less likely to swap.  There are
various pathological things which happen when both UML and the host are
swapping.  Having said that, the host needs to be able to swap UMLs if the 
memory situation is so bad that there is no other choice.

> - because the host already sees which pages are accessed and which not
> (an  access inside UML is an access inside the host); the only
> difference is that  the host can swap even the guest kernel, while UML
> not; 

UML might have a better idea than the host, though.

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
