Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPLhW-0003Cg-0y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 06:01:26 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPLhU-00080C-Ug for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 06:01:25 -0800
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CPLhS-0000xM-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Nov 2004 15:01:22 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Nov 2004 15:01:22 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Nov 2004 15:01:22 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87pt2v9jl1.fsf@aka.i.naked.iki.fi>
References: <417101F4.1050109@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [uml-user] UML Guests and CPU Performance.
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
Date: Wed, 03 Nov 2004 14:56:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

primero@fastwebnet.it wrote:
> It seems to me that performance of UML Guest machine is sensibly
> worst then UML Host ... even if there is only one UML guest and no
> other processes sucking resources.

It is definitely worse.

> The Bogomips of the Guest are the half of the Host

Ignore bogomips. Pure CPU workload is really close to the host. You
can try it with any CPU tester application.

> and compiling time is almost the double.

We have generally measured compile time increase by a third or
more. It is affected by many things though, so YMMV. This is with the
skas patch, but without SYSEMU.

> I want to know if this is "Normal" or i have to look for some errors
> in my configuration.

Sounds just about right - for some not-so-independent results on UML
performance compared to other techniques, I found the Xen performance
results to give a rough guideline:

  http://www.cl.cam.ac.uk/Research/SRG/netos/xen/performance.html

Do note that the benchmarks they run are really bad on virtualization
techniques - normal user workload suffers far less.

-- Naked




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
