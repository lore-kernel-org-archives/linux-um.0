Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUcCe-00050k-FQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 18:39:20 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CUcCc-0004od-AF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 18:39:20 -0800
Message-Id: <200411180453.iAI4r5Q3007865@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Debian bug 271069, gdb startup fails 
In-Reply-To: Your message of "Wed, 17 Nov 2004 19:47:39 EST."
	<20041118004739.GA25637@nevyn.them.org> 
References: <20041113211443.GA27963@nevyn.them.org>
	<200411180243.iAI2hgQ3006959@ccure.user-mode-linux.org>
	<20041118004739.GA25637@nevyn.them.org> 
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
Date: Wed, 17 Nov 2004 23:53:05 -0500
To: Daniel Jacobowitz <dan@debian.org>
Cc: 271069-submitter@bugs.debian.org, 271069@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

dan@debian.org said:
> GDB isn't trying to kill UML; it's trying to kill a process that it
> forked, for the express purpose of figuring out whether certain debug
> facilities are available on the system.

Ahh, thanks for the clarification.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
