Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhuwM-0003aA-Le for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 10:12:58 -0800
Received: from brown.brainfood.com ([146.82.138.61] helo=yakko.doogie.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhuwJ-0002jF-Hy for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 10:12:55 -0800
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] What is the most up to date, least crashing
	kernel+patch?
In-Reply-To: <4008A7DF.6000308@lig.net>
Message-ID: <Pine.LNX.4.44.0401171208310.23425-100000@yakko.doogie.org>
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
Date: Sat, 17 Jan 2004 12:12:37 -0600 (CST)
To: "Stephen D. Williams" <sdw@lig.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

yOn Fri, 16 Jan 2004, Stephen D. Williams wrote:

> I have noticed that paging an executable (like Python) in takes much
> more time that it would natively and that large amounts of disk I/O is
> slow.  Where is the bottleneck for this and what can be done about it?
> (I realized that the virtual layering is going to cost some.)

Any context switches(which includes pthreads), or io, in UML, is dog slow.

A context switch underneath uml(and io as well) involes the host uml switching
from the emulated process, into itself, and back(at the very least).

With the current and forseeable UML implementations, this can't be fixed.
You'd have to port major portitions of UML to a kernel module(this is more
than just SKAS).




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
