Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh6w-0006TK-U9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:30 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh6w-0007rt-11
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:30 -0800
Message-Id: <200401280439.i0S4dPZw005522@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] PATCH check for sys_sendfile() in port_user.c 
In-Reply-To: Your message of "Tue, 27 Jan 2004 15:20:14 +1030."
	<20040127045014.GZ4203@erizo.shearer.org> 
References: <20040127045014.GZ4203@erizo.shearer.org> 
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
Date: Tue, 27 Jan 2004 23:39:25 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Some kernels (including SuSE 2.4.20, according to http://
> marc.theaimsgroup.com/?l=user-mode-linux-user&m=107437381718023&w=2)
> don't have sys_sendfile, in which case the port console driver should
> refuse to start up because there is no way for telnetd to get the fd. 

sendfile has nothing to do with passing descriptors across unix sockets.
It is a relatively new performance tweak which allows files to be copied
without the data flowing through userspace.

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
