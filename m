Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aoykh-0007s4-C2
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 21:42:07 -0800
Received: from mail-01.iinet.net.au ([203.59.3.33] helo=mail.iinet.net.au)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aoykg-0005bx-Lo
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 21:42:06 -0800
Received: from cameron by cp.yi.org with local (Exim 3.36 #1 (Debian))
	id 1Aoyka-0001O1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 06 Feb 2004 13:42:00 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
Message-ID: <20040206054200.GC22141@patrick.wattle.id.au>
References: <20040206003759.GY4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206003759.GY4203@erizo.shearer.org>
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
Date: Fri, 6 Feb 2004 13:42:00 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Dan Shearer wrote:

| I've got a rough implementation of an mcsonole telinit command, where
| mconsole_kern opens /dev/initctl and sends a command to change
| runlevels. Some small changes in arch/um/mconsole_kern.c.
| 
| This raises a question about UML design.  UML shouldn't be dependent on
| any specific program running inside the VM.

How about having some kind of generic interface to allow the host to
access files, send signals, etc inside the VM?  That would be overkill
for a simple telinit but could open up other possibilities too.

Cameron.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
