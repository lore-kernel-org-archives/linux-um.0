Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aoty4-0003OI-0P
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 16:35:36 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1Aoty3-0004ft-KN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 16:35:35 -0800
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040206003759.GY4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] mconsole telinit design, worry about init standards?
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
Date: Fri, 6 Feb 2004 11:07:59 +1030
To: user-mode-linux-devel@lists.sourceforge.net
Cc: miquels@cistron.nl

I've got a rough implementation of an mcsonole telinit command, where
mconsole_kern opens /dev/initctl and sends a command to change
runlevels. Some small changes in arch/um/mconsole_kern.c.

This raises a question about UML design.  UML shouldn't be dependent on
any specific program running inside the VM. In this case, /dev/initctl
is implemented by the init usually found on Linux systems, from the
sysvinit package by Miquel van Smoorenburg.  But is this too specific?
I have the impression that close to zero Linuz distros install any other
init, but I don't have good evidence.  Perhaps Miquel can comment on
this. 

I have looked for a standard definition of what communication mechanisms
init should have but haven't found anything so far. 

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
