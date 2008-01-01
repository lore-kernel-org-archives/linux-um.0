Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list2-new-b.sourceforge.net ([10.3.1.94]
	helo=sc8-sf-list2-new.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J9obG-0004VG-NC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Jan 2008 13:24:38 -0800
Message-ID: <477AAFA1.9060807@BitWagon.com>
Date: Tue, 01 Jan 2008 13:24:49 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <4773F11D.7060803@BitWagon.com>
In-Reply-To: <4773F11D.7060803@BitWagon.com>
Subject: Re: [uml-devel] running UserModeLinux under Valgrind(memcheck)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, valgrind-developers@lists.sourceforge.net

The web page  http://bitwagon.com/valgrind+uml/index.html
now exists with news, history, commentary, scripts, links
on getting User Mode Linux for i686 to run under memcheck on i686.

A standalone patch  http://bitwagon.com/valgrind+uml/mc_main-asap.patch
to valgrind-3.3.0 implements "--complain-asap=yes" independently of
the other changes.  See  http://bitwagon.com/glibc-audit/glibc-audit.html
about getting a "quiet" glibc.

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
