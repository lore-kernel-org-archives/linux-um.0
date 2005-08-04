Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0pCp-0006DU-Ki	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 16:32:55 -0700
Received: from newmail.brainfood.com ([146.82.138.14] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:RC4-SHA:128)	(Exim 4.44)
	id 1E0pCp-0004fv-FE	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 16:32:55 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	(TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24)	(Exim 4.31)	id 1E0pAN-0002xu-1v
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 18:30:23 -0500
From: Adam Heath <doogie@brainfood.com>
Subject: Re: [uml-devel] Host kernel requirements for UML (fwd)
Message-ID: <Pine.LNX.4.58.0508041832400.20176@gradall.private.brainfood.com>
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
Date: Thu, 4 Aug 2005 18:32:48 -0500 (CDT)
To: user-mode-linux-devel@lists.sourceforge.net



---------- Forwarded message ----------
Date: Thu, 4 Aug 2005 18:30:09 -0500 (CDT)
From: Adam Heath <adam@doogie.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [uml-devel] Host kernel requirements for UML

On Wed, 3 Aug 2005, Jeff Dike wrote:

> It looks at /proc/cpuinfo for some information about cmov and xmm support
> on the processor.

Wouldn't it make more sense to actually test for those instructions instead of
parsing proc, for use on systems without a linux compatible /proc.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
