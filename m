Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aewps-00011X-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:38:00 -0800
Received: from adsl-b4-78-221.telepac.pt ([81.193.78.221]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aewps-0004Zw-HD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:38:00 -0800
Message-ID: <3FFEAF28.8000707@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com> <3FFEAA6C.8020002@timesys.com>
	<3FFEACBC.7060704@timesys.com>
In-Reply-To: <3FFEACBC.7060704@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 09 Jan 2004 13:39:52 +0000
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



La Monte H.P. Yarroll wrote:
> 
> Going back through your posting it looks like it probably does not 
> matter if the host kernel
> implements TLS as long as libc does not use NTPL.  Is this a correct 
> interpretation?
> 

The host kernel runs UML fine... UML doesn't run only when system's 
glibc has nptl+tls support.

This same kernel runs UML with the same glibc, compiled without nptl+tls 
support.

So, I can only assume that's nptl :)

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
