Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ajgwv-0007fn-2o for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 07:40:53 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1Ajgwu-0005gY-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 07:40:52 -0800
Received: from localhost ([127.0.0.1]:33356 helo=shearer.org)
	by shearer.org with esmtp (Dan's MTA 1.0) id 1Ajgz1-00048z-1U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 02:13:03 +1030
Received: from dan by erizo.shearer.org with local (Spammer Slammer 3.141)
	id 1Ajgz0-00048w-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 02:13:02 +1030
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Changes to port_user
Message-ID: <20040122154302.GR4203@erizo.shearer.org>
References: <20040122144020.GQ4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040122144020.GQ4203@erizo.shearer.org>
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
Date: Fri, 23 Jan 2004 02:13:02 +1030
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 23, 2004 at 01:10:20AM +1030, Dan Shearer wrote:
> Now, I just want raw data to go from the kernel to the port and back
> again. So should I:
> 
> 	a) just shortcircuit this by hooking the inbound and outbound
> 	descriptors up, or

I'm starting to get it, chan_kern is the place to start to understand
what happens when a read or write irq goes off. I don't think there is a
short-circuit mechanism for hooking up the internal fd for a tty
directly to an fd within a channel driver without breaking this design.
So what if I modified port_task_proc to copy the incoming data in the
appropriate direction? I'll give that a try next.

Jeff, please, what does "winch" stand for?

And also, if I submit some patches that just contain brief source
comments about how things work will you accept them? I notice you don't
use them much.

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
