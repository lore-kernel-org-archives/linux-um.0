Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjfyE-0004u8-4D for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 06:38:10 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AjfyD-0000Yw-GK
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 06:38:09 -0800
Received: from localhost ([127.0.0.1]:33330 helo=shearer.org)
	by shearer.org with esmtp (Dan's MTA 1.0) id 1Ajg0K-00046c-Q0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 01:10:20 +1030
Received: from dan by erizo.shearer.org with local (Spammer Slammer 3.141)
	id 1Ajg0K-00046Z-ER for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 01:10:20 +1030
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040122144020.GQ4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] Changes to port_user
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
Date: Fri, 23 Jan 2004 01:10:20 +1030
To: user-mode-linux-devel@lists.sourceforge.net

I've done some minor work in drivers/port_user.c, including replacing
the binding to INADDR_ANY with a gethostbyname(passed_ip), so you
can specify which single IP to listen on. I'll post when I'm sure its
ok.

Now what I'm trying to do is replace in.telnetd with something else, for
the moment netcat as a simple case, or something that gives the same
effect. That involves understanding the significance of port_helper and
kernel/helper.c, which I don't yet.

Here's what I've noticed so far:

	When port_task_proc is run for a new incoming connection (an irq
	raised), port_accept calls port_connection, which is over in
	userspace (port_user.c)

	port_connection calls run_helper from kernel/helper.c, which
	starts in.telnetd in a new thread with clone(), supplying
	port-helper as the login program for telnetd but I'm not too
	sure what it does. telnetd behaves as if it were being run from
	inetd, being passed an input and an output descriptor, one
	connected to the UML (I don't know the mechanism for this yet)
	and the other to the network port.

Now, I just want raw data to go from the kernel to the port and back
again. So should I:

	a) just shortcircuit this by hooking the inbound and outbound
	descriptors up, or

	b) drop netcat in instead of telnetd (which I have tried but it
	isn't quite working yet.)

There may be architectural reasons why I shouldn't do (a).

Comments?

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
