Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlJRb-0003Sp-A0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 18:59:15 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AlJRa-0001LX-TB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 18:59:15 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Swapping directly to host swap area?
Message-ID: <20040127030119.GV4203@erizo.shearer.org>
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow>
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
Date: Tue, 27 Jan 2004 13:31:19 +1030
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Jan 25, 2004 at 06:34:12PM -0500, William Stearns wrote:
> 
> 	When a VM needs to swap out, is there some way the UML kernel
> could send that sector directly to the host swap area instead of running
> its own swap?  

But that would involve making it possible for an ordinary userspace
process (for example, /bin/ls) to affect what the VM is doing on the
host.

Jeff's /dev/anon and ubd=mmap is all about addressing your problem from
the point of view of memory utilisation. See
http://user-mode-linux.sourceforge.net/devanon.html

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
