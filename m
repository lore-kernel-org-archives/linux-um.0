Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPmff-0004ae-Lu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 11:17:03 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPmfe-0001O0-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 11:17:03 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] 2.4.23(24?)-2 TT mode hangs on request_module
In-Reply-To: <40A8F902.8090001@microbus.com>
Message-ID: <Pine.LNX.4.44.0405172007480.20517-100000@filer.marasystems.com>
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
Date: Mon, 17 May 2004 20:16:59 +0200 (CEST)
To: Robbie Dinn <robbie@microbus.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 May 2004, Robbie Dinn wrote:

> I think I may have seen this too, although I didn't understand what
> was going on at the time (still don't). I am a little unsure what
> versions of software I was using, because I wasn't working very
> systematically. It might have been:
>   host: 2.6.6 + skas3 patch or 2.6.6-rc3-mm2 + ska3 patch
> 	+ recent CVS netfilter p-o-m

If you are using SKAS and statically linked kernel (no modules) then your
problem is most likely different. The problem I am seeing is only when the
kernel tries to dynamically load a module. If code is statially linked or
manually loaded using modprobe then the problem does not occur, and also
if the host supports SKAS then the problem does not occur. The problem I
am seeing is only if using TT and allowing the kernel to dynamically
initiating loading of modules (not manually using modprobe or statically 
linked), has only been seen in the current CVS version of UML-2.4.

Please attach a debugger to your uml to see what it is doing. It may be
the same problem I am seeing, but most likely not.

If I were to guess what your problem is I would guess there is again some
problem with the vmalloc implementation in the version of UML you are
using.. there has historically been issues with vmalloc in UML and
iptables is one of very few users of the vmalloc kernel interface..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
