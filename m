Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlAtD-0006gG-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 09:51:11 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AlAtC-0005jm-SS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 09:51:11 -0800
Message-Id: <200401261814.i0QIElY3019159@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Draft docs for port console channel 
In-Reply-To: Your message of "Mon, 26 Jan 2004 10:08:41 +1030."
	<20040125233841.GT4203@erizo.shearer.org> 
References: <20040123035639.GC4203@erizo.shearer.org>
	<20040123144320.GB6768@ccure.user-mode-linux.org>
	<20040124082057.GG4203@erizo.shearer.org>
	<200401241820.i0OIKLY3002404@ccure.user-mode-linux.org>
	<20040125233841.GT4203@erizo.shearer.org> 
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
Date: Mon, 26 Jan 2004 13:14:47 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> Now that you've seen telnetd working reliably, would you accept xterm
> using fd passing too provided testing went ok?  Factoring out code and
> one less thing to worry about when porting UML to other types of OS.

There is that, but the xterm man page guarantees that the arguments will
be passed through to the subprocess and makes no such guarantees about
file descriptors.

So, I'd just as soon leave things as they are.  This seems to maximize the
likelihood that they will continue to work.

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
