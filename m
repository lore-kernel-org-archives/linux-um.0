Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIxN-0005eb-0q
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:38:09 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIxM-00035m-Fp
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:38:08 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
In-Reply-To: <Pine.LNX.4.58.0312191038590.6547@earth>
Message-ID: <Pine.GSO.4.58.0312191018340.8625@algedi.dur.ac.uk>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth>
 <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth>
 <Pine.LNX.4.58.0312181514140.7622@earth> <Pine.GSO.4.58.0312190914170.8625@algedi.dur.ac.uk>
 <Pine.LNX.4.58.0312191038590.6547@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Dec 2003 11:37:55 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 19 Dec 2003, Ingo Molnar wrote:

> oops, didnt mean to let this get into the patch. Fixed patch is at:
>
>      redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A3
>
> also, this patch does not have a number of fixes Jeff has in his tree.
> It's just a temporary thing for 2.6.0 users. Works for me, but YMMV.

I realize that but a combined patch is useful if you want to build both
host and uml kernels from the same rpm. I was actually trying the host
part with arjan's 1.103 kernel (with some extra patching to your patch)
and it seemed to be working until I ran of of diskspace. Incidentally, I
am not sure doing the same thing with the uml kernel will quite work as I
seem to recall that uml doesn't build if the exec-shield patch is applied.

	Michael Young


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
